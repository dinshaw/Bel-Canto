;(function($) {
  
  function initialize() {
    var form = $('form.async_form');
    form.live('submit', function(event) {
      submit_form($(this));
      return false;      
    });
    
    handle_form_responses();
  }

  $(document).ready(initialize);

  function submit_form(form) {
    $.post(form.attr('action') + '.json', form.serialize(), function(response) {
      form.data('response', response);
      form.trigger('async_form_success');
    }, 'json');
  }
  
  // Specific handlers for any async forms go here
  function handle_form_responses() {
  
    // lesson creation from schedule modal
    $('form#private_lesson_form').live('async_form_success.private_lesson_form', function(event) {
      console.log($(this).data('response'));  
    });
  
  }
})(jQuery);
