;(function($) {

  $('form#private_lesson_modal_form')
    .bind("ajax:loading",  showProgress)
    .bind("ajax:success", function(data, status, xhr) {
      console.log(data);
    });

  function showProgress() {
    console.log('spinner');
  }
})(jQuery);
