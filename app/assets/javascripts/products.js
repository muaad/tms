// $(function() {
document.addEventListener("turbolinks:load", function() {
	$('#toggle_products').change(function(e) {
	  if (this.checked) {
	    $('.products_table').checkboxes('check');
	    e.preventDefault();
	  }
	  else {
	    $('.products_table').checkboxes('uncheck');
	    e.preventDefault();
	  }
	});

	$('#delete-products').click(function(){
	  if ($(".products_table input:checked").length < 1)
	  {
	    swal("You have not selected any products to be deleted.");
	    return false;
	  }
	  else
	  {
	    products_array = []
	    $(".products_table input:checked").each(function(){
	      products_array.push($(this).attr('value'))
	    });
	    $('#delete_products').val(products_array);
	    // contact_num = ("#products_table input:checked").length;
	    $('#delete_product_modal #lbl-msg').html('You are about to delete '+String(products_array.length)+' products');
	    $('#delete_product_modal')
	    .modal('setting', {
	      onApprove: function(){
	        $(this).find('form').submit();
	      }
	    })
	    .modal('show');
	  }
	});

	$('#edit-product').click(function(){
	  if ($(".products_table input:checked").length < 1)
	  {
	    swal("You have not selected any product to be edited.");
	    return false;
	  }
	  else if ($(".products_table input:checked").length > 1)
	  {
	    swal("You have selected more than one product. You can only edit one product at a time.");
	    return false;
	  }
	  else
	  {
	    products_array = []
	    $(".products_table input:checked").each(function(){
	      products_array.push($(this).attr('value'))
	    });
	  	var id = products_array[0];
	  	document.location = '/products/' + id + '/edit'
	  }
	});
});