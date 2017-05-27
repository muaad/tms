// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require app
//= require trucks
//= require jquery.slimscroll.min
//= require jquery.dataTables
//= require dataTables.bootstrap
//= require slick.min
//= require sweetalert.min
//= require jquery.checkboxes
//= require bootstrap-datepicker
//= require_tree .
//= require_self

$(function() {
	$('#example').dataTable( {
	    "aoColumnDefs" : [ {
	        "bSortable" : false,
	        "aTargets" : [ "no-sort" ]
	    } ]
	} );

	// var neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight();
	// var window_height = $(window).height();
	// $(".content-area, .content-wrapper").css('height', window_height - neg);
	// $(window).bind('resize', function(event) {
	// 	var window_height = $(window).height();
	// 	$(".content-area, .content-wrapper").css('height', window_height - neg);
	// });

	var neg = $('.main-header').outerHeight() + $('.main-footer').outerHeight();
	var window_height = $(window).height();
	$(".content-area, .content-wrapper").css('height', window_height - neg);
	$(window).bind('resize', function(event) {
		var window_height = $(window).height();
		$(".content-area, .content-wrapper").css('height', window_height - neg);
	});

	var formattedDate = new Date();
	var d = formattedDate.getDate();
	var m =  formattedDate.getMonth();
	m += 1;  // JavaScript months are 0-11
	var y = formattedDate.getFullYear();

	if ($(".datepicker").val() === "") {
		// $(".datepicker").val(d + "/" + m + "/" + y);
	};
	$('.datepicker').datepicker();

	$('.slick-list').slick({
	  dots: true,
	    infinite: false,
	    speed: 300,
	    slidesToShow: 3,
	    slidesToScroll: 3,
	    responsive: [
	      {
	        breakpoint: 1024,
	        settings: {
	          slidesToShow: 3,
	          slidesToScroll: 3,
	          infinite: true,
	          dots: true
	        }
	      },
	      {
	        breakpoint: 600,
	        settings: {
	          slidesToShow: 2,
	          slidesToScroll: 2
	        }
	      },
	      {
	        breakpoint: 480,
	        settings: {
	          slidesToShow: 1,
	          slidesToScroll: 1
	        }
	      }
	      // You can unslick at a given breakpoint now by adding:
	      // settings: "unslick"
	      // instead of a settings object
	    ]
	});
	// $('.alert.alert-success').fadeOut('slowly', 5000);
	// $('#owner_phone_number').select2();
	// $('#driver_phone_number').select2();
	// $('#turn_boy_phone_number').select2();
})//= require serviceworker-companion
