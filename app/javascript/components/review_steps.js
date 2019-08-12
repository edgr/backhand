import swal from 'sweetalert';

const firstStep = document.querySelector('.user-review-step1');
const nextStep = document.getElementById('next-review-step');
const secondStep = document.querySelector('.user-review-step2');
const backStep = document.getElementById('back-review-step');

const reviewSteps = () => {
  if (firstStep) {
    secondStep.style.display = 'none';
    nextStep.addEventListener('click', () => {
      firstStep.style.display = 'none';
      secondStep.style.display = '';
    });
    backStep.addEventListener('click', () => {
      secondStep.style.display = 'none';
      firstStep.style.display = '';
    });
  }
}

export { reviewSteps };
