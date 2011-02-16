$(document).ready(function() {


  var $calendar = $('#calendar');
  var id = 10;

  $calendar.weekCalendar({
    timeslotsPerHour : 3,
    allowCalEventOverlap : false,
    overlapEventsSeparate: false,
    firstDayOfWeek : 1,
    timeslotHeight: 30,
    defaultEventLength: 2,
    businessHours :{start: 7, end: 23, limitDisplay: true },
    daysToShow : 5,
    // switchDisplay: {'1 day': 1, '3 next days': 3, 'work week': 5, 'full week': 7},
    title: function(daysToShow) {
      return daysToShow == 1 ? '%date%' : '%start% - %end%';
    },
    height : function($calendar) {
      return $(window).height() - $("h1").outerHeight() - 1;
    },
    eventRender : function(calEvent, $event) {
      if (calEvent.end.getTime() < new Date().getTime()) {
        $event.css("backgroundColor", "#aaa");
        $event.find(".wc-time").css({
          "backgroundColor" : "#999",
          "border" : "1px solid #888"
        });
      }
    },
    draggable : function(calEvent, $event) {
      return calEvent.readOnly != true;
    },
    resizable : function(calEvent, $event) {
      return calEvent.readOnly != true;
    },
    eventNew : function(calEvent, $event) {
      var $dialogContent = $("#event_edit_container");
      resetForm($dialogContent);
      var startField = $dialogContent.find("select.start_time").val(calEvent.start);
      var endField = $dialogContent.find("select.end_time").val(calEvent.end);
      var titleField = $dialogContent.find("input[name='title']");
      var bodyField = $dialogContent.find("textarea[name='body']");


      $dialogContent.dialog({
        width: 350,
        modal: true,
        title: "New Calendar Event",
        close: function() {
          $dialogContent.dialog("destroy");
          $dialogContent.hide();
          $('#calendar').weekCalendar("removeUnsavedEvents");
        },
        buttons: {
          save : function() {
            var form = $dialogContent.find("form");
            $.ajax({
              type: 'POST',
              url: form.attr('action')+'.json',
              data: form.serialize(),
              complete: function(res) { console.log(res)},
              dataType: 'json'
            });
            // calEvent.id = id;
            // id++;
            // calEvent.start = new Date(startField.val());
            // calEvent.end = new Date(endField.val());
            // calEvent.title = titleField.val();
            // calEvent.body = bodyField.val();
            // 
            // $calendar.weekCalendar("removeUnsavedEvents");
            // $calendar.weekCalendar("updateEvent", calEvent);
            // $dialogContent.dialog("close");
          },
          cancel : function() {
            $dialogContent.dialog("close");
          }
        }
      }).show();

      $dialogContent.find(".date_holder").text($calendar.weekCalendar("formatDate", calEvent.start));
      setupStartAndEndTimeFields(startField, endField, calEvent, $calendar.weekCalendar("getTimeslotTimes", calEvent.start));

    },
    eventDrop : function(calEvent, $event) {
    },
    
    eventResize : function(calEvent, $event) {
    },
    
    eventClick : function(calEvent, $event) {
      // edit
      if (calEvent.readOnly) {
        return;
      }

      var $dialogContent = $("#event_edit_container");
      resetForm($dialogContent);
      var startField = $dialogContent.find("select.start_time").val(calEvent.start);
      var endField = $dialogContent.find("select.end_time").val(calEvent.end);
      var titleField = $dialogContent.find("input[name='title']").val(calEvent.title);
      var bodyField = $dialogContent.find("textarea[name='body']");
      bodyField.val(calEvent.body);

      $dialogContent.dialog({
        modal: true,
        title: "Edit - " + calEvent.title,
        close: function() {
          $dialogContent.dialog("destroy");
          $dialogContent.hide();
          $('#calendar').weekCalendar("removeUnsavedEvents");
        },
        buttons: {
          save : function() {

            calEvent.start = new Date(startField.val());
            calEvent.end = new Date(endField.val());
            calEvent.title = titleField.val();
            calEvent.body = bodyField.val();
                    
            $calendar.weekCalendar("updateEvent", calEvent);
            $dialogContent.dialog("close");
          },
          "delete" : function() {
            $calendar.weekCalendar("removeEvent", calEvent.id);
            $dialogContent.dialog("close");
          },
          cancel : function() {
            $dialogContent.dialog("close");
          }
        }
        }).show();

        var startField = $dialogContent.find("select.start_time").val(calEvent.start);
        var endField = $dialogContent.find("select.end_time").val(calEvent.end);
        $dialogContent.find(".date_holder").text($calendar.weekCalendar("formatDate", calEvent.start));
        setupStartAndEndTimeFields(startField, endField, calEvent, $calendar.weekCalendar("getTimeslotTimes", calEvent.start));
        $(window).resize().resize(); //fixes a bug in modal overlay size ??

      },
      eventMouseover : function(calEvent, $event) {
      },
      
      eventMouseout : function(calEvent, $event) {
      },
      
      noEvents : function() {

      },
      data : function(start, end, callback) {
        $.getJSON('/private_lessons.json', function(res){
          callback(res);
        });
      }
    });

    function resetForm($dialogContent) {
      $dialogContent.find("input").val("");
      $dialogContent.find("textarea").val("");
    }

    /*
    * Sets up the start and end time fields in the calendar event
    * form for editing based on the calendar event being edited
    */
    function setupStartAndEndTimeFields($startTimeField, $endTimeField, calEvent, timeslotTimes) {

      $startTimeField.empty();
      $endTimeField.empty();

      for (var i = 0; i < timeslotTimes.length; i++) {
        var startTime = timeslotTimes[i].start;
        var endTime = timeslotTimes[i].end;
        var startSelected = "";
        if (startTime.getTime() === calEvent.start.getTime()) {
          startSelected = "selected=\"selected\"";
        }
        var endSelected = "";
        if (endTime.getTime() === calEvent.end.getTime()) {
          endSelected = "selected=\"selected\"";
        }
        $startTimeField.append("<option value=\"" + startTime + "\" " + startSelected + ">" + timeslotTimes[i].startFormatted + "</option>");
        $endTimeField.append("<option value=\"" + endTime + "\" " + endSelected + ">" + timeslotTimes[i].endFormatted + "</option>");

        $timestampsOfOptions.start[timeslotTimes[i].startFormatted] = startTime.getTime();
        $timestampsOfOptions.end[timeslotTimes[i].endFormatted] = endTime.getTime();

      }
      $endTimeOptions = $endTimeField.find("option");
      $startTimeField.trigger("change");
    }

    var $endTimeField = $("select[name='end']");
    var $endTimeOptions = $endTimeField.find("option");
    var $timestampsOfOptions = {start:[],end:[]};

    //reduces the end time options to be only after the start time options.
    $("select[name='start']").change(function() {
      var startTime = $timestampsOfOptions.start[$(this).find(":selected").text()];
      var currentEndTime = $endTimeField.find("option:selected").val();
      $endTimeField.html(
        $endTimeOptions.filter(function() {
          return startTime < $timestampsOfOptions.end[$(this).text()];
        })
      );

      var endTimeSelected = false;
      $endTimeField.find("option").each(function() {
        if ($(this).val() === currentEndTime) {
          $(this).attr("selected", "selected");
          endTimeSelected = true;
          return false;
        }
      });

      if (!endTimeSelected) {
        //automatically select an end date 2 slots away.
        $endTimeField.find("option:eq(1)").attr("selected", "selected");
      }

    });

  });
