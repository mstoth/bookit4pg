// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


$(document).ready(function() {
		
		$('#dateandtime').datetimepicker({
			ampm: true
		});
	
	$(function(){
		var slide_int = null;

		function update_slider(){
			var offset = $('.ui-slider-handle').offset();
			var value = $('#slider').slider('option', 'value');
			$('#distance').val(value);
			$('#current_value').text('Range: '+ value + " miles.").animate({top:offset.top }, 1000 );
			$('#current_value').fadeIn();
		}

		$('#slider').slider({
			animate: true,
			step: 10,
			min: 10,
			value: $("#distance").val(),
			orientation: 'horizontal',
			max: 100,
			start: function(event, ui){
			$('#current_value').empty();
				slide_int = setInterval(update_slider, 10);	
			},
			slide: function(event, ui){
				setTimeout(update_slider, 10);  
			},
			stop: function(event, ui){
				clearInterval(slide_int);
				slide_int = null;
			}
		});	
	});
	
	$("#slider").slider("value",$("#distance"));
	$("#current_value").text("Range: "+$("#distance").val()+" miles");
	
	$("#profile").mouseover(function() {
		$(this).attr("src","/assets/profile_sel.png");
	});
	
	$("#profile").mouseout(function() {
		$(this).attr("src","/assets/profile.png");
	});
	
	$("#venues_near_me").mouseover(function() {
		$(this).attr("src","/assets/venues_near_me_sel.png");
	});
	
	$("#venues_near_me").mouseout(function() {
		$(this).attr("src","/assets/venues_near_me.png");
	});
	
	$("#groups_near_me").mouseover(function() {
		$(this).attr("src","/assets/groups_near_me_sel.png");
	});
	
	$("#groups_near_me").mouseout(function() {
		$(this).attr("src","/assets/groups_near_me.png");
	});
	
	$("#concerts_near_me").mouseover(function() {
		$(this).attr("src","/assets/concerts_near_me_sel.png");
	});
	
	$("#concerts_near_me").mouseout(function() {
		$(this).attr("src","/assets/concerts_near_me.png");
	});
	
	$("#join_group").mouseover(function() {
		$(this).attr("src","/assets/join_group_sel.png");
	});
	
	$("#join_group").mouseout(function() {
		$(this).attr("src","/assets/join_group.png");
	});
	
	$("#manage_concerts").mouseover(function() {
		$(this).attr("src","/assets/manage_concerts_sel.jpg");
	});
	
	$("#manage_concerts").mouseout(function() {
		$(this).attr("src","/assets/manage_concerts.jpg");
	});
	
	$("#manage_groups").mouseover(function() {
		$(this).attr("src","/assets/manage_groups_sel.png");
	});
	
	$("#manage_groups").mouseout(function() {
		$(this).attr("src","/assets/manage_groups.png");
	});
	
	$("#manage_venues").mouseover(function() {
		$(this).attr("src","/assets/manage_venues_sel.png");
	});
	
	$("#manage_venues").mouseout(function() {
		$(this).attr("src","/assets/manage_venues.png");
	});
	
	
    $("#genre_select").change(function() {
	var gid=$(this).val();
	var vid=$("#venue_select").val();
	window.location= "/venues/" + vid.toString() + "/concerts_near?genre=" + gid.toString();
      });

  //$("#sendmsg").hide()

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

	function over_join_group()
	    {
	        $("#join_group").attr("src","/assets/join_group_sel.png");
	    }
	function off_join_group()
	    {
	        $("#join_group").attr("src","/assets/join_group.png");
	    }

});






