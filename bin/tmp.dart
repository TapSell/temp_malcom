import 'dart:io';
import 'dart:math';

final random = Random();

int randomFactor = 10; // This is changed by PUT https://dev.tapsell.de:13000/random/:factor

// This is the small nasty server that is being queried at dev.tapsell.de:13000

void main(List<String> arguments) async {
  (await HttpServer.bind(InternetAddress.anyIPv4, 5101)).listen(onRequest);
}

void onRequest(HttpRequest request) async {
  var maxStreamLength = 120,
      streamLength    = int.tryParse(request.headers.value('X-Stream') ?? '1'),
      route           = request.uri.path,
      now             = DateTime.now();

  print('$now : $route');

  request.response.headers.set('Access-Control-Allow-Origin', '*');
  request.response.headers.set('Access-Control-Allow-Methods', '*');
  request.response.headers.set('Access-Control-Allow-Headers', '*');
  
  if (route.startsWith('/random')) {

    if (request.method == 'GET' && route == '/random') {
      
      if (streamLength == null) {
        request.response.statusCode   = 400;
        request.response.reasonPhrase = 'Sorry bro: X-Stream header must be an int';
      } else if (streamLength > maxStreamLength) {
        request.response.statusCode   = 400;
        request.response.reasonPhrase = 'Sorry bro: X-Stream can be a max of $maxStreamLength' ;
      } else {
        request.response.statusCode          = 200;
        request.response.headers.contentType = ContentType.text;
        request.response.bufferOutput        = false;
        
        while (true) {
          request.response.writeln(random.nextInt(randomFactor));

          await request.response.flush();

         

          streamLength = streamLength! - 1;
          
          if (streamLength == 0) {
            break;
          } else {
            await Future.delayed(Duration(seconds: 1));
          }

        }
      }

    } else if (request.method == 'PUT') {
      var factor = int.tryParse(route.replaceFirst('/random/', ''));

      if (factor == null) {
        request.response.statusCode   = 400;
        request.response.reasonPhrase = 'Sorry bro: Factor to put must be an int';
      } else {
        randomFactor = factor;

        request.response.statusCode = 204;
      }

    } else if (request.method == 'OPTIONS') {
      request.response.statusCode = 204;
    } else {
      request.response.statusCode = 405;
    }

  } else {
    request.response.statusCode = 404;
  }

  await request.response.close();
}
