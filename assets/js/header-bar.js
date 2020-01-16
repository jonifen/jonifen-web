var prevScrollpos = window.pageYOffset;
window.onscroll = function() {
  var currentScrollPos = window.pageYOffset;
  if (prevScrollpos > currentScrollPos || currentScrollPos < 32) {
    document.querySelector("#header").style.top = "0";
  } else {
    document.querySelector("#header").style.top = window.innerWidth > 840 ? "-3rem" : "-6rem";
  }
  prevScrollpos = currentScrollPos;
}