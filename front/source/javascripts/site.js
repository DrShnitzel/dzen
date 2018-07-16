function conncetToServer() {
  if (location.protocol == 'https:') {
    socket = new WebSocket("wss://" + location.host + "/ws");
  } else {
    socket = new WebSocket("ws://" + location.host + "/ws");
  }
  socket.onmessage = function(event) {
    for (let curency of ["usd", "eur", "btc"]) {
      updateCurency(curency, event.data);
    }
  };

  socket.onclose = function(){
    setTimeout(conncetToServer, 5000);
  };
}

function updateCurency(curency, data) {
  value = JSON.parse(data)[curency];
  if (curencyValid(value)) {
    element = document.getElementById(curency);
    element.textContent = value;
  } else {
    console.log("incorrect curency data:" + data)
  }
}

function curencyValid(value) {
  // it start with digit and may contain digits, dots and spaces after that
  return /^[1-9][0-9. ]*$/.exec(value) !== null;
}

conncetToServer();
