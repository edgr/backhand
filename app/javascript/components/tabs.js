const tabsSwitcher = (event) => {
  const activeTab = document.querySelector(".tab-underlined.active");
  console.log(activeTab.dataset.target);
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
