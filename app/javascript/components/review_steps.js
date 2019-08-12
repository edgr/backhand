import swal from 'sweetalert';

const firstStep = document.querySelector('.user-review-step1');
const nextStep = document.getElementById('next-review-step');
const secondStep = document.querySelector('.user-review-step2');
const backStep = document.getElementById('back-review-step');

const notReally = document.getElementById('user_review_thumb_false');
const ofCourse = document.getElementById('user_review_thumb_true');
const reviewContent = document.getElementById('user_review_content');

const reviewSteps = () => {
  if (firstStep) {
    secondStep.style.display = 'none';
    nextStep.addEventListener('click', () => {
      if (notReally.checked || ofCourse.checked) {
        if (reviewContent.value) {
          firstStep.style.display = 'none';
          secondStep.style.display = '';
        } else {
          swal('Please write something about your partner!')
        }
      } else {
      swal('Please rate your partner!')
      }
    });
    backStep.addEventListener('click', () => {
      secondStep.style.display = 'none';
      firstStep.style.display = '';
    });
  }
}

export { reviewSteps };
