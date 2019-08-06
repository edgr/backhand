const searchPlayers = document.getElementById('search_query')
const playersList = document.querySelectorAll('.player-card')

const findUsersByName = (event) => {
  const input = searchPlayers.value;
  const nodesArray = Array.prototype.slice.call(document.querySelectorAll(".player-card"));
  console.log(nodesArray);
}

const typeIn = () => {
  searchPlayers.addEventListener('keyup', (event) => {
    findUsersByName();
  })
}

export { typeIn };
