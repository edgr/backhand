const autoLoserSelection = () => {
  const form = document.querySelector("#challenge_winner");
  if (form) {
    const loserForm = document.querySelector("#challenge_loser");
    form.addEventListener("change", (event) => {
      form.querySelectorAll("option").forEach(option => {
        if (!option.selected && option.value != "") {
          loserForm.value = option.value
        }
      })
    })
  }
}

export { autoLoserSelection };
