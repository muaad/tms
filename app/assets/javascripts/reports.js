// $(function() {
document.addEventListener("turbolinks:load", function() {
	$('.from-date').val($('.from-selected').val())
	$('.to-date').val($('.to-selected').val())
	$('.filter-by-truck option[value="'+ $('.truck-selected').val() +'"]').attr('selected', 'selected');
	$('.range-search').click(function() {
		var query_param = "?from=" + $('.from-date').val() + '&to=' + $('.to-date').val()
		if ($('.filter-by-truck').val() != '0') {
			query_param += "&truck=" + $('.filter-by-truck').val()
		};
		window.location = query_param
	})
	$('.filter-by-truck').change(function() {
		var query_param = "?truck=" + $('.filter-by-truck').val()
		if ($('.from-date').val() != "" && $('.to-date').val() != "") {
			query_param += "&from=" + $('.from-date').val() + '&to=' + $('.to-date').val()
		};
		window.location = query_param;
	})

	$('.print-report').click(function(){
	     $("#account-reports").printThis();
	});
});
