// $(function() {
document.addEventListener("turbolinks:load", function() {
	$('#toggle_cities').change(function(e) {
	  if (this.checked) {
	    $('.cities_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.cities_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-cities').click(function(){
	  if ($(".cities_table input:checked").length < 1)
	  {
	    swal("You have not selected any cities to be deleted.");
	    return false;
	  }
	  else
	  {
	    cities_array = []
	    $(".cities_table input:checked").each(function(){
	      cities_array.push($(this).attr('value'))
	    });
	    $('#delete_cities').val(cities_array);
	    // contact_num = ("#cities_table input:checked").length;
	    $('#delete_city_modal #lbl-msg').html('You are about to delete '+String(cities_array.length)+' cities');
	    $('#delete_city_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-city').click(function(){
	  if ($(".cities_table input:checked").length < 1)
	  {
	    swal("You have not selected any city to be edited.");
	    return false;
	  }
	  else if ($(".cities_table input:checked").length > 1)
	  {
	    swal("You have selected more than one city. You can only edit one city at a time.");
	    return false;
	  }
	  else
	  {
	    cities_array = []
	    $(".cities_table input:checked").each(function(){
	      cities_array.push($(this).attr('value'))
	    });
	  	var id = cities_array[0];
	  	document.location = '/cities/' + id + '/edit'
	  }
	});
});