// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

	$("#sendmsg").hide('fast');

	$(".actions").click(function() {
		if ($("#offer").attr("checked")) {
			$("#sendmsg").show('fast');
			$("#footerlinks").hide('fast');
			$(".center").hide('fast');
		}
	});

	$("#no_webpage").change(function() {
		if ($("#no_webpage").val() == "false") {
			$("#no_webpage").val("true");
			$("#concert_webpage").val("Group Website");
		} else {
			$("#no_webpage").val("false");
			$("#concert_webpage").val("http://");
		}
	});

});