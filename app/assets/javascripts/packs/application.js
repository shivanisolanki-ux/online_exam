import SlimSelect from 'slim-select';
import 'slim-select/dist/slimselect.css';

document.addEventListener("DOMContentLoaded", function () {
  new SlimSelect({
    select: '#exam_question_ids',
    settings: {
      placeholderText: 'Select Questions...',
      allowDeselect: true,
      hideSelected: true,
    }
  });
});
//= require slimselect.min
