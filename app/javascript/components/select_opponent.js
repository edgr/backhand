const selectPlayer2 = document.getElementById('match_player_2');
const selectWinner = document.getElementById('match_result_winner');

const opponentName = document.getElementById('player_2_name');
const playerDivs = document.querySelectorAll('.avatar-name-match-record');
const opponentPicture = playerDivs[1].firstElementChild;


const myFunction = (event) => {
  if (selectPlayer2) {
    selectWinner.lastChild.remove();
    opponentName.innerText = "";

    const i = event.currentTarget.selectedIndex;
    const opponentOption = `<option value="${event.currentTarget.value}">${event.currentTarget.options[i].innerText}</option>`;
    selectWinner.insertAdjacentHTML('beforeend', opponentOption);

    const pictureLink = event.currentTarget.options[i].dataset.picture.slice(8,-2);
    opponentPicture.src = pictureLink;

    const opponentNameString = `${event.currentTarget.options[i].innerText}`;
    opponentName.insertAdjacentHTML('beforeend', opponentNameString);
  }
}


const selectOpponent = () => {
  if (selectPlayer2) {
    const fakeOption = `<option value=""> </option>`;
    selectWinner.insertAdjacentHTML('beforeend', fakeOption);
    selectPlayer2.onchange = myFunction;
  }
}

export { selectOpponent };
