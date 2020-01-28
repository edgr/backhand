const copyStringToClipboard = (str) => {
   // Create new element
   const el = document.createElement('textarea');
   // Set value (string to be copied)
   el.value = str;
   // Set non-editable to avoid focus and move outside of view
   el.setAttribute('readonly', '');
   el.style = {position: 'absolute', left: '-9999px'};

   if (window.location.href.includes('users')) {
     document.body.appendChild(el);
     el.select();
     document.execCommand('copy');
     document.body.removeChild(el);
   } else {
     const modal = document.querySelector('.modal-content');
     modal.appendChild(el);
     el.select();
     document.execCommand('copy');
     modal.removeChild(el);
   }
}

const copyLink = () => {
  const button = document.getElementById('copy-link-button');
  if (button) {
    button.addEventListener('click', (event) => {
      event.preventDefault();
      const copy = window.location.href;
      copyStringToClipboard(copy);
    })
  }
}

export { copyLink }
