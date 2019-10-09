const copyStringToClipboard = (str) => {
   // Create new element
   const el = document.createElement('textarea');
   // Set value (string to be copied)
   el.value = str;
   // Set non-editable to avoid focus and move outside of view
   el.setAttribute('readonly', '');
   el.style = {position: 'absolute', left: '-9999px'};
   document.body.appendChild(el);
   // Select text inside element
   el.select();
   // Copy text to clipboard
   document.execCommand('copy');
   // Remove temporary element
   document.body.removeChild(el);
}

const copyLink = () => {
  const button = document.getElementById('copy-link-button');
  if (button) {
    button.addEventListener('click', (event) => {
      event.preventDefault();
      const copy = window.location.href;
      console.log(copy);
      copyStringToClipboard(copy);
      // document.getElementById("alarm-msg").innerHTML = "copied";
      // setTimeout(function(){
        // document.getElementById("alarm-msg").innerHTML = '';
      // }, 1000);
    })
  }
}

export { copyLink }
