;(function($) {

  function initialize() {
    var $this, form, script_tag, template, view;
    
    script_tag = $('script#private_lesson_modal_form');
    
    if (script_tag.length > 0) {
      script_tag.bind('new_lesson', function() {
        $this = $(this);
        template = script_tag.html();
        view = {
          start_date: $this.data('calEvent').start.toString('ddd, MMM dS'),
          start_time: $this.data('calEvent').start.toString('h:mm'),
          end_time: $this.data('calEvent').end.toString('h:mm tt')
        }
        form_modal = $(Mustache.to_html(template, view));
        
        // form_modal.find('form#private_lesson_form')
        //   .bind("ajax:loading",  showProgress)
        //   .bind("ajax:success", function(data, status, xhr) {
        //     console.log(data);
        // });

        form_modal.modal();
      });
    }    
  }

  function showProgress() {
    console.log('spinner');
  }

  $(document).ready(initialize);

})(jQuery);
