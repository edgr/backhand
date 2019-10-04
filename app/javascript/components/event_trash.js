const eventCards = document.querySelectorAll('.card-and-actions')

const showTrash = () => {
  eventCards.forEach((eventCard) => {
    const card = eventCard.querySelector('.event-card');
    const trash = eventCard.querySelector('.card-delete');
    const date = eventCard.querySelector('.date-club')
    card.addEventListener('click', (event) => {
      trash.classList.toggle('d-none');
      date.classList.toggle('d-none');
    })
  })
}

export { showTrash }
