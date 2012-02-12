// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function() {

    $("#genre_select").change(function() {
	var gid=$(this).val();
	var vid=$("#venue_select").val();
	window.location= "/venues/" + vid.toString() + "/concerts_near?genre=" + gid.toString();
      });


  $("#venue_select").change(function() {
    var vid = $(this).val();
    var gid=$("#genre_select").val();
    
    window.location =   "/venues/" + vid.toString() + "/concerts_near?genre=" + gid.toString();
   });

  $("#offer").change(function() {

		       if ($("#offer").attr('checked')) {
			 $("#notoffer").hide('slow');
		       } else {
			 $("#notoffer").show('slow');
		       }
		     } );

    if ($("#offer").attr('checked')) {
      $("#notoffer").hide('slow');
    }

});






