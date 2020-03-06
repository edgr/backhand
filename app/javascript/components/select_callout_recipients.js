import noUiSlider from "nouislider";
import wNumb from "wnumb";

const slider = document.getElementById('level-slider');
const minLevel = document.getElementById('callout_minimum_level');
const maxLevel = document.getElementById('callout_maximum_level');
const sendCalloutButton = document.getElementById('send_callout');

const disableSendButton = (number) => {
  if (number === 0) {
    sendCalloutButton.disabled = true
  } else {
    sendCalloutButton.disabled = false
  }
}

const makeNiceSentence = (number) => {
  const text = sendCalloutButton.value
  const stringNumber = number.toString()
  const newText = text.split(' ')
  newText.splice(2, 1, stringNumber)
  sendCalloutButton.value = newText.join(' ')
}

const calculateRecipients = (list) => {
  const min = Number(minLevel.value)
  const max = Number(maxLevel.value)
  const recipients = []
  list.forEach((user) => {
    if (user.points >= min && user.points <= max) {
      recipients.push(user)
    }
  })
  makeNiceSentence(recipients.length)
  disableSendButton(recipients.length)
}

const updateRecipients = () => {
  const dropDown = document.getElementById('callout_recipients');
  const selected = dropDown.options[dropDown.selectedIndex].value;
  if (dropDown && selected) {
    if (selected === "0") {
      calculateRecipients(gon.users_around)
    } else if (selected === "1") {
      calculateRecipients(gon.club_users)
    } else {
      makeNiceSentence(gon.favorites.length)
      disableSendButton(gon.favorites.length)
    }
  }
}

const startSlider = () => {
  if (slider) {
    noUiSlider.create(slider, {
        start: [600, 1800],
        connect: true,
        behaviour: 'drag',
        padding: [50, 50],
        margin: 200,
        limit: 1200,
        step: 50,
        tooltips: true,
        format: wNumb({
            decimals: 0
        }),
        range: {
            'min': -50,
            'max': 2450
        }
    });
    slider.noUiSlider.on('update', (event) => {
      minLevel.value = slider.noUiSlider.get()[0]
      maxLevel.value = slider.noUiSlider.get()[1]
      updateRecipients();
    })
  }
}

const hideLevel = () => {
  const callout = document.getElementById('new_callout');
  if (callout) {
    callout.addEventListener('change', (event) => {
      const dropDown = document.getElementById('callout_recipients');
      const selected = dropDown.options[dropDown.selectedIndex].value;
      const levelSection = document.getElementById('level-slider');
      const minLevel = document.querySelector('.callout_minimum_level');
      const maxLevel = document.querySelector('.callout_minimum_level');
      if (selected === "2") {
        levelSection.classList.add('hidden');
        minLevel.classList.add('hidden');
        maxLevel.classList.add('hidden');
        updateRecipients();
      } else {
        levelSection.classList.remove('hidden');
        minLevel.classList.remove('hidden');
        maxLevel.classList.remove('hidden');
        updateRecipients();
      }
    })
  }
}

export { hideLevel };
export { startSlider };
