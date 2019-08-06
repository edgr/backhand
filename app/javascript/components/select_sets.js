const setsPlayed = document.getElementById('sets-played');

const selectSets = () => {
  setsPlayed.value = 1;
  setsPlayed.addEventListener('change', () => {
    console.log(setsPlayed.value)
  });
}

export { selectSets };
