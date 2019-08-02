const selectBox = document.querySelector('.match_opponent');
const input = document.getElementById('select-winner');

const changeOpponent = (event) => {
  if (input) {
    input.lastChild.remove();
    const selectedIndex = event.currentTarget.options.selectedIndex
    const opponentName = event.currentTarget.options[selectedIndex].innerText
    const opponent = `<option value="${event.currentTarget.value}">${opponentName}</option>`;
    input.insertAdjacentHTML('beforeend', opponent);
  }
}

const onChange = (event) => {
  if (selectBox) {
    selectBox.onchange=changeOpponent;
  }
};

export { onChange };

