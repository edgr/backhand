const selectBox = document.getElementById('match_player_2_id');
const input = document.getElementById('match_result_winner');

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
    const fakeOption = `<option value=""> </option>`;
    input.insertAdjacentHTML('beforeend', fakeOption);
    selectBox.onchange=changeOpponent;
  }
};

export { onChange };
