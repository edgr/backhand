const selectBox = document.getElementById('match_player_2_id');
const input = document.getElementById('match_result_winner');
const opponentInScore = document.getElementById('player_2_name');

const changeOpponent = (event) => {
  if (input) {
    input.lastChild.remove();
    opponentInScore.innerText = "";

    const selectedIndex = event.currentTarget.options.selectedIndex
    const opponentName = event.currentTarget.options[selectedIndex].innerText
    // const opponentPicture = `<%= cl_image_tag User.find(current_user.${selectedIndex}).picture, class: "avatar" %>`

    const opponentOption = `<option value="${event.currentTarget.value}">${opponentName}</option>`;
    const opponentNameString = `${opponentName}`;

    input.insertAdjacentHTML('beforeend', opponentOption);
    // opponentInScore.insertAdjacentHTML('beforeend', opponentPicture);
    opponentInScore.insertAdjacentHTML('beforeend', opponentNameString);
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

