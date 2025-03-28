//= require arctic_admin/base

// Agar tumhe custom JS chahiye, yahan add karo
  


import SlimSelect from 'slim-select'

// Initialize Slim Select after DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
  new SlimSelect({
    select: '#exam_question_ids',
    settings: {
      placeholderText: 'Select Questions',
      allowDeselect: true,
      closeOnSelect: false,
      showSearch: true, // Enable search
      allowDeselectOption: true,
    }
  })
})
