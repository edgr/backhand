const welcome = document.querySelector(".welcome");
const welcomeRedirect = () => {
  if (welcome) {
    let seconds = document.getElementById("countdown").textContent;
    const countdown = setInterval(function() {
      seconds--;
      document.getElementById("countdown").textContent = seconds;
      if (seconds <= 0) clearInterval(countdown);
    }, 1000);
    setTimeout(function(){
        window.location.assign("/");
      }, 6000);
  }
}

export { welcomeRedirect }
