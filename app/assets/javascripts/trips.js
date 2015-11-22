$(function() {
	$('#toggle_trips').change(function(e) {
	  if (this.checked) {
	    $('.trips_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.trips_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-trips').click(function(){
	  if ($(".trips_table input:checked").length < 1)
	  {
	    swal("You have not selected any trips to be deleted.");
	    return false;
	  }
	  else
	  {
	    trips_array = []
	    $(".trips_table input:checked").each(function(){
	      trips_array.push($(this).attr('value'))
	    });
	    $('#delete_trips').val(trips_array);
	    // contact_num = ("#trips_table input:checked").length;
	    $('#delete_trip_modal #lbl-msg').html('You are about to delete '+String(trips_array.length)+' trips');
	    $('#delete_trip_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	var truck_id = $('#trip-truck').val()
	$('select[name="trip[truck_id]"] option[value="'+ truck_id +'"]').attr('selected', 'selected').change();

	var editPage = window.location.pathname.indexOf("edit") >= 0 && window.location.pathname.indexOf("trips") >= 0
	if (window.location.pathname === "/trips/new" || editPage) {
		if (editPage) {
			var truck_id = $('#trip-truck').val()
			$('select[name="trip[truck_id]"] option[value="'+ truck_id +'"]').attr('selected', 'selected').change();
			var consignee_id = $('#trip-consignee').val()
			$('select[name="trip[consignee_id]"] option[value="'+ consignee_id +'"]').attr('selected', 'selected').change();
			var depot_id = $('#trip-depot').val()
			$('select[name="trip[depot_id]"] option[value="'+ depot_id +'"]').attr('selected', 'selected').change();
			var destination_id = $('#trip-destination').val()
			$('select[name="trip[destination_id]"] option[value="'+ destination_id +'"]').attr('selected', 'selected').change();
			var product_id = $('#trip-product').val()
			$('select[name="trip[product_id]"] option[value="'+ product_id +'"]').attr('selected', 'selected').change();
		};
		$.get('/trucks/' + $('select[name="trip[truck_id]"]').val() + '.json', function(data) {
			$('select[name="trip[driver_id]"] option[value="'+ data.driver.id +'"]').attr('selected', 'selected');	
			$('select[name="trip[turn_boy_id]"] option[value="'+ data.turn_boy.id +'"]').attr('selected', 'selected');	
		})

		$('select[name="trip[truck_id]"]').change(function() {
			$.get('/trucks/' + $('select[name="trip[truck_id]"]').val() + '.json', function(data) {
				$('select[name="trip[driver_id]"] option[value="'+ data.driver.id +'"]').attr('selected', 'selected');	
				$('select[name="trip[turn_boy_id]"] option[value="'+ data.turn_boy.id +'"]').attr('selected', 'selected');	
			})
		})

		$.get('/products/' + $('select[name="trip[product_id]"]').val() + '.json', function(data) {
			$('#trip_rate').val(data.price);	
		})

		$('select[name="trip[product_id]"]').change(function() {
			$.get('/products/' + $('select[name="trip[product_id]"]').val() + '.json', function(data) {
				$('#trip_rate').val(data.price);	
			})
		})
	}

	$('#trip_quantity, #trip_rate').on("propertychange change click keyup input paste", function(evt) {
		var amount = $('#trip_quantity').val() * $('#trip_rate').val();
		$('#trip_amount').val(amount);
	})

	$('#edit-trip').click(function(){
	  if ($(".trips_table input:checked").length < 1)
	  {
	    swal("You have not selected any trip to be edited.");
	    return false;
	  }
	  else if ($(".trips_table input:checked").length > 1)
	  {
	    swal("You have selected more than one trip. You can only edit one trip at a time.");
	    return false;
	  }
	  else
	  {
	    trips_array = []
	    $(".trips_table input:checked").each(function(){
	      trips_array.push($(this).attr('value'))
	    });
	  	var id = trips_array[0];
	  	document.location = '/trips/' + id + '/edit'
	  }
	});
});