// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {

$("#sendmsg").hide('fast');

$(".actions").click(function() {
	$("#sendmsg").show('fast');
	$("#footerlinks").hide('fast');
	$(".center").hide('fast');
});

});