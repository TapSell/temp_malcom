// Can be plain, preference is Dart [https://angulardart.xyz/]
let myMax = 1000


let random_numbers = [];

window.onload = displayClock();
function displayClock(){
  var date = new Date().toLocaleTimeString();
  document.getElementById('time').innerHTML = date;
  setTimeout(displayClock, 1000); 
}

function remove(node) {
  let event = window.event;
  node.parentNode.removeChild(node);
  event.cancelBubble = true;
}

function getRandomNumberDate(art) {

  var showDate = new Date().toLocaleTimeString();
  let randomNumber = Math.floor(Math.random() * myMax) + 1;

  document.getElementById("output").innerHTML = randomNumber

  /** 
  const table = document.getElementById("rowMiddle");
  art.forEach(showDate, randomNumber => {

  let tbody = document.createElement('tbody');
  let tr1   = document.createElement('tr');
  let tr2 = document.createElement('tr');
  let td1 = document.createElement('td');
  let td2 = document.createElement('td');

  tr1.id = "rowMiddleLeft";
  tr2.id = "rowMiddleRight";
  td1.id = "stamp";
  td1.innerHTML = `${showDate}`;
  td2.id = "saveNumber";
  td2.innerHTML = `${randomNumber}`;

  tbody.appendChild(tr1);
  tbody.appendChild(tr2);
  tr1.appendChild(td1);
  tr2.appendChild(td2);
  table.appendChild(tbody);
  })
  **/
  

  let a = `<tbody onclick="remove(this)" class="rowMiddleBody">
    <tr class="rowMiddleLeft">
      <td id="stamp">${showDate}</td>
    </tr>
    <tr class="rowMiddleRight">
      <td id="saveNumber">${randomNumber}</div>
    </tr>
  </tbody>`;

  document.querySelector(".rowMiddle").innerHTML += a; 

}

b5.onclick = function() {
  myMax = 5;
}

b10.onclick = function() {
  myMax = 10;
}

b25.onclick = function() {
  myMax = 25;
}

b50.onclick = function() {
  myMax = 50;
}

setMax.onclick = function() {
  myMax = setMax.value;
}
