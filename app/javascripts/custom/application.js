function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".phone_number").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

 $(document).ready(function() {
 	$(".state_select_dropdown").change(function(){
		$.get('/admin/students/' + $(this).prev('input').val() + '/transition?transition=' + $(this).val());
 	});
 });
