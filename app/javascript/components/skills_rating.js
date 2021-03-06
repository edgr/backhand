const skillsInput = document.querySelectorAll('.review-skills-score')

const selectSkillValue = () => {
  if (skillsInput) {
    skillsInput.forEach((skill) => {
      skill.parentNode.parentNode.firstElementChild.innerText = '';
      skill.parentNode.parentNode.firstElementChild.innerText = skill.value;
      skill.addEventListener('change', () => {
        skill.parentNode.parentNode.firstElementChild.innerText = '';
        skill.parentNode.parentNode.firstElementChild.innerText = skill.value;
      })
    })
  }
}

export { selectSkillValue };
