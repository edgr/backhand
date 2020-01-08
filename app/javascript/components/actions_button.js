const openActions = () => {
  const moreButton = document.getElementById('more-button')
  if (moreButton) {
    const reviewButton = document.getElementById('review-button')
    const whatsappButton = document.getElementById('whatsapp-button')
    const linkButton = document.getElementById('copy-link-button')
    const innerIcon = moreButton.querySelector('.mdc-fab__icon')
    moreButton.addEventListener('click', (event) => {
      if (reviewButton) {
        reviewButton.classList.toggle('hidden');
      }
      if (whatsappButton){
        whatsappButton.classList.toggle('hidden');
        if (linkButton) {
          linkButton.classList.toggle('hidden');
        }
      } else {
        if (linkButton) {
          linkButton.classList.toggle('hidden');
          linkButton.classList.toggle('b-230');
          linkButton.classList.toggle('b-160');
        }
      }
      if (innerIcon.innerText === 'add') {
        innerIcon.innerText = 'close'
      }
      else {
        innerIcon.innerText = 'add'
      }
    })
  }
}

export { openActions };
