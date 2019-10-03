const player2 = document.querySelector('.form-group.select.required.event_player_2');

const addPlayer = ()=>{
  if (player2) {
    const playersParent = player2.parentElement
    const player3 = playersParent.childNodes[3];
    const player4 = playersParent.childNodes[5];
    playersParent.removeChild(playersParent.childNodes[3]);
    playersParent.removeChild(playersParent.childNodes[4]);
    const addLink = document.querySelector('.add');
    const removeLink = document.querySelector('.remove');
    removeLink.style.display = 'none';
    let n = 0;
    addLink.addEventListener('click', (event)=>{
      event.preventDefault();
      n += 1;
      if (n == 1){
        playersParent.append(player3);
        removeLink.style.display = '';
      }
      if (n == 2){
        playersParent.append(player4);
        addLink.style.display = 'none';
      }
    })
    removeLink.addEventListener('click', (event)=>{
      event.preventDefault();
      n -= 1;
      playersParent.lastChild.remove();
      if (n == 1){
        addLink.style.display = '';
      }
      if (n == 0){
        removeLink.style.display = 'none';
      }
    })
  }
}

export { addPlayer }
