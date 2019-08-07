const setNumber = document.getElementById('sets-played');
const displayNumber = document.querySelector('.display-sets-number')
const setsPlayed = document.querySelectorAll('.set-played')

const showSets = (number) => {
  let n = 1;
  setsPlayed.forEach((set) => {
    set.classList.remove('hidden');
    if (n > number) {
      set.classList.add('hidden');
    }
    n += 1;
  });
}

const displaySetsNumber = (number) => {
  displayNumber.innerText = '';
  displayNumber.innerText = number;
}

const selectSets = () => {
  if (setNumber) {
    setNumber.value = 1;
    displaySetsNumber(setNumber.value);
    showSets(setNumber.value);
    setNumber.addEventListener('change', () => {
    showSets(setNumber.value);
    displaySetsNumber(setNumber.value);
  });
  }
}

export { selectSets };
