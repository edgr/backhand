import swal from 'sweetalert';

const firstStep = document.querySelector('.user-review-step1');
const nextStep = document.getElementById('next-review-step');
const secondStep = document.querySelector('.user-review-step2');
const backStep = document.getElementById('back-review-step');
const thirdStep = document.querySelector('.user-review-step3');
const lastStep = document.getElementById('last-review-step');

const notReally = document.getElementById('user_review_thumb_false');
const ofCourse = document.getElementById('user_review_thumb_true');
const reviewContent = document.getElementById('user_review_content');

const reviewSteps = () => {
  if (firstStep) {
    secondStep.style.display = 'none';
    thirdStep.style.display = 'none';
    nextStep.addEventListener('click', () => {
      if (notReally.checked || ofCourse.checked) {
        if (reviewContent.value) {
          firstStep.style.display = 'none';
          secondStep.style.display = '';
        } else {
          const alert = document.querySelector('.please-write').innerText
          swal(alert)
        }
      } else {
        const alert = document.querySelector('.please-rate').innerText
        swal(alert)
      }
    });
    backStep.addEventListener('click', () => {
      thirdStep.style.display = 'none';
      secondStep.style.display = 'none';
      firstStep.style.display = '';
    });
  }
  if (secondStep) {
    lastStep.addEventListener('click', () => {
      secondStep.style.display = 'none';
      thirdStep.style.display = '';
    })
  }
}

export { reviewSteps };
