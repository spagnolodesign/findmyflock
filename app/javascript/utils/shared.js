const el = document.querySelector('form');

function checkEnter(e){
 e = e || event;
 var txtArea = /textarea/i.test((e.target || e.srcElement).tagName);
 var mediumEditor = document.getElementsByClassName('medium-editor-element');
 return mediumEditor || txtArea || (e.keyCode || e.which || e.charCode || 0) !== 13;
}

if (el) {
  document.querySelector('form').onkeypress = checkEnter;
}
