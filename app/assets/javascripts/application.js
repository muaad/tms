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
// require select2.full
// require select2
//= require jquery.slimscroll.min
//= require jquery.dataTables
//= require dataTables.bootstrap
//= require angular.min
//= require sweetalert.min
//= require jquery.checkboxes
//= require jquery.datetimepicker
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

	var formattedDate = new Date();
	var d = formattedDate.getDate();
	var m =  formattedDate.getMonth();
	m += 1;  // JavaScript months are 0-11
	var y = formattedDate.getFullYear();

	if ($(".datepicker").val() === null) {
		$(".datepicker").val(d + "/" + m + "/" + y);
	};
	$('.datepicker').datepicker();
	// $('.alert.alert-success').fadeOut('slowly', 5000);
	// $('#owner_phone_number').select2();
	// $('#driver_phone_number').select2();
	// $('#turn_boy_phone_number').select2();
})