const el = document.querySelector('form');

function checkEnter(e){
 e = e || event;
 var txtArea = /textarea/i.test((e.target || e.srcElement).tagName);
 return txtArea || (e.keyCode || e.which || e.charCode || 0) !== 13;
}

if (el) {
  document.querySelector('form').onkeypress = checkEnter;
}
