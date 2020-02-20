const hideGeneralRanking = () => {
  const clubRanking = document.getElementById("club_ranking")
  if (clubRanking) {
    const generalRanking = document.getElementById("general_ranking")
    generalRanking.classList.add("hidden")
  }
}
const tabsSwitcher = (event) => {
  event.preventDefault();
  const activeTab = document.querySelector(".tab-underlined.active");
  const currentContent = document.getElementById(activeTab.dataset.target);
  currentContent.classList.toggle("hidden");

  activeTab.classList.remove("active");
  event.currentTarget.classList.toggle("active");
  const contentToShow = document.getElementById(event.currentTarget.dataset.target);
  contentToShow.classList.toggle("hidden");
}

const addListener = (tab) => {
  tab.addEventListener("click", tabsSwitcher);
}

export { addListener };
export { hideGeneralRanking };

