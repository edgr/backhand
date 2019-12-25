const shareButton = document.getElementById('tell-your-friends')
const hiddenShare = document.getElementById('hidden-share-button')

const webShare = () => {
  if (navigator.share) {
    navigator.share({
      title: 'Backhand App',
      text: 'Check this tennis app mate!',
      url: 'https://www.backhandapp.com',
    })
      .then(() => console.log('Successful share'))
      .catch((error) => console.log('Error sharing', error));
  } else {
    hiddenShare.click()
  }
}

const tellYourFriends = () => {
  if (shareButton) {
    shareButton.addEventListener('click', webShare)
  }
}

export { tellYourFriends }
