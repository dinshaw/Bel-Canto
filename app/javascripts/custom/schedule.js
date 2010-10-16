;(function($) {

  function initialize() {
    
  	$('#calendar').weekCalendar({
  		timeslotsPerHour: 3,
  		timeslotHeight: 25,
  		defaultEventLength: 2,
  		daysToShow: 5,
  		businessHours: {start: 7, end: 23, limitDisplay: true},
  		height: function($calendar){
  			return $(window).height() - $("h1").outerHeight();
  		},
  		eventRender : function(calEvent, $event) {
  			if(calEvent.end.getTime() < new Date().getTime()) {
  				$event.css("backgroundColor", "#aaa");
  				$event.find(".time").css({"backgroundColor": "#999", "border":"1px solid #888"});
  			}
  		},
  		eventNew : function(calEvent, $event) {
  		  var template, view, form;
  		  template = $('#private_lesson_modal_form').html();
    	  view = {
    	    start_date: calEvent.start.toString('ddd, MMM dS'),
    	    start_time: calEvent.start.toString('h:mm'),
    	    end_time: calEvent.end.toString('h:mm tt')
    	  }
    	  form = $(Mustache.to_html(template, view));
    	  form.modal();
  		},
  		eventDrop : function(calEvent, $event) {
  			displayMessage("<strong>Moved Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
  		},
  		eventResize : function(calEvent, $event) {
  			displayMessage("<strong>Resized Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
  		},
  		eventClick : function(calEvent, $event) {
  			displayMessage("<strong>Clicked Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
  		},
  		eventMouseover : function(calEvent, $event) {
  			displayMessage("<strong>Mouseover Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
  		},
  		eventMouseout : function(calEvent, $event) {
  			displayMessage("<strong>Mouseout Event</strong><br/>Start: " + calEvent.start + "<br/>End: " + calEvent.end);
  		},
  		noEvents : function() {
  			displayMessage("There are no events for this week");
  		},
  		data:"events.json"
  	});
  	
  	$("<div id=\"message\" class=\"ui-corner-all\"></div>").prependTo($("body"));
    
  }

  $(document).ready(initialize);
    
  function displayMessage(message) {
		$("#message").html(message).fadeIn();
	}

})(jQuery);
