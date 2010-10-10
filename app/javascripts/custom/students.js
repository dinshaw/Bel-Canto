$(document).ready(function() {
	$(".state_select_dropdown").change(function(){
		$.get('/admin/students/' + $(this).prev('input').val() + '/transition?transition=' + $(this).val());
	});
});
