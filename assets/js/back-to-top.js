function setBttState() {
  document.querySelector(".back-to-top").style.display = (window.pageYOffset < 300) ? "none" : "block";
}

window.onscroll = setBttState;