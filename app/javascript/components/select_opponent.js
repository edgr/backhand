const selectPlayer2 = document.getElementById('match_player_2');
const selectWinner = document.getElementById('match_result_winner');


const myFunction = (event) => {
  if (selectPlayer2) {
    selectWinner.lastChild.remove();

    const i = event.currentTarget.selectedIndex;
    const opponentOption = `<option value="${event.currentTarget.value}">${event.currentTarget.options[i].innerText}</option>`;
    selectWinner.insertAdjacentHTML('beforeend', opponentOption);

    const playerDivs = document.querySelectorAll('.avatar-name-match-record');
    const opponentPicture = playerDivs[1].firstElementChild;
    opponentPicture.src = event.currentTarget.options[i].dataset.picture;

    const opponentName = document.getElementById('player_2_name');
    opponentName.innerText = event.currentTarget.options[i].innerText;
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
