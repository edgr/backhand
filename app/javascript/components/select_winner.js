const selectBox = document.getElementById('match_player_2_id');
const selectSecondBox = document.getElementById('match_result_winner');

const input = document.getElementById('match_result_winner');
const opponentInScore = document.getElementById('player_2_name');
const avatarName = document.querySelectorAll('.avatar-name-match-record');

let opponentNames = [];
let opponentPhotos = [];
let i = 1;

if (selectBox) {
  selectSecondBox.options[1].innerText = selectSecondBox.options[1].innerText.split("-")[0];
  while (i < selectBox.options.length) {
    opponentNames = opponentNames.concat(selectBox.options[i].innerText.split("-")[0]);
    opponentPhotos = opponentPhotos.concat(selectBox.options[i].innerText.split("-")[1]);
    selectBox.options[i].innerText = selectBox.options[i].innerText.split("-")[0]
    i ++;
  }
}


const changeOpponent = (event) => {
  if (input) {
    input.lastChild.remove();
    opponentInScore.innerText = "";

    const selectedIndex = event.currentTarget.options.selectedIndex;
    const opponentName = opponentNames[selectedIndex - 1];
    const opponentPhoto = opponentPhotos[selectedIndex - 1];

    const opponentOption = `<option value="${event.currentTarget.value}">${opponentName}</option>`;
    const opponentNameString = `${opponentName}`;

    avatarName[1].firstElementChild.src = opponentPhoto
    input.insertAdjacentHTML('beforeend', opponentOption);
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

