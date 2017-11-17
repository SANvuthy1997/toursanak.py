$(document).ready(function(){
	$('.Upcoming').click(function(){
		$('.Yellow').css( "display","block" );
		$('.Green').css( "display","none" );
	});
});

$(document).ready(function(){
	$('.Promotion').click(function(){
		$('.Green').css( "display","block" );
		$('.Yellow').css( "display","none" );
	});
});

$('.dropdown-button').dropdown({
  inDuration: 300,
  outDuration: 225,
  constrainWidth: false, // Does not change width of dropdown to that of the activator
  hover: false, // Activate on hover
  gutter: 0, // Spacing from edge
  belowOrigin: false, // Displays dropdown below the button
  alignment: 'left', // Displays dropdown with edge aligned to the left of button
  stopPropagation: false // Stops event propagation
}
);

$(document).ready(function(){

	$(".fa-search").on("click",function(){
		$(".formSearch").slideToggle(500);
	});

	$(".close").on("click",function(){
		$(".formSearch").slideUp(400);
	});
});

$('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 10, // Creates a dropdown of 15 years to control year,
    showOtherMonths: true,
    selectOtherMonths: true,
    changeMonth: true,
    changeYear: true,
    showButtonPanel: true,
    format: 'dd/mmm/yyyy', 
    clear: 'Clear',
    close: 'Ok',
    closeOnSelect: true, // Close upon selecting a date,
  });

// Phone screen
$(".button-collapse").sideNav();


// calculate 
// $(document).ready(function(){
// 	$('.filled-in').on("click",function(){
// 	  var total =0;

// 	  $('.filled-in:checked').each(function(){
// 	    total += parseInt($(this).val());
// 	  });

// 	  $("#total").html('$' + total); 

// 	});
	
// });


 $('.carousel.carousel-slider').carousel({fullWidth: true});

// Dropdown Li
$(document).ready(function(){
	$("#dropDown_Li").on("click",function(){
		$("#showUl").slideToggle(200);
	});
});

$(document).ready(function(){
    // the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
    $('.modal').modal();
  });






