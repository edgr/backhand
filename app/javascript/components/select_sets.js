const setNumber = document.getElementById('sets-played');
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

const selectSets = () => {
  if (setNumber) {
    setNumber.value = 1;
    showSets(setNumber.value);
    setNumber.addEventListener('change', () => {
    showSets(setNumber.value);
  });
  }
}

export { selectSets };
