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
        console.log('zero');
      } else {
        levelSection.classList.remove('hidden');
        minLevel.classList.remove('hidden');
        maxLevel.classList.remove('hidden');
        console.log('not zero');
      }
    })
  }
}

export { hideLevel };
