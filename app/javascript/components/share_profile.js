const shareButton = document.getElementById('share-button')

const shareProfile = () => {
  console.log('shared!')
  if (navigator.share) {
    navigator.share({
        title: 'My Backhand Profile',
        text: 'This is my profile',
        url: 'https://developers.google.com/web',
    })
      .then(() => console.log('Successful share'))
      .catch((error) => console.log('Error sharing', error));
  }
}

const triggerShare = () => {
  if (shareButton) {
    shareButton.addEventListener('click', shareProfile)
  }
}

export { triggerShare };
