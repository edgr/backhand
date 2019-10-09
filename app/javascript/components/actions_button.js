const openActions = () => {
  const moreButton = document.getElementById('more-button')
  if (moreButton) {
    const reviewButton = document.getElementById('review-button')
    const whatsappButton = document.getElementById('whatsapp-button')
    const linkButton = document.getElementById('copy-link-button')
    const innerIcon = moreButton.querySelector('.mdc-fab__icon')
    moreButton.addEventListener('click', (event) => {
      reviewButton.classList.toggle('hidden');
      whatsappButton.classList.toggle('hidden');
      linkButton.classList.toggle('hidden');
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