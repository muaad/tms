// $(function() {
// 	if (window.location.href != "/") {
// 		var source = new EventSource("/notifications/events")
// 		source.addEventListener('message', function(e) {
// 			var notification = $.parseJSON(e.data);
// 			$('#unread-count').val($('#unread-count').val() + 1)
// 			console.log(notification)
// 			$.ajax({
// 				type: "GET",
// 				url: "/attachments/" + notification.attachment_id + ".json",
// 				dataType: "json",
// 				success: function(data) {
// 					var doc = data.long_name
// 					if (notification.resolved) {
// 						var circle = 'circle-thin'
// 					} else {
// 						var circle = 'circle'
// 					}

// 					var notif = '<li><a href="/notifications/' + notification.id + '"><h3>' + doc + '<small class="pull-right"><i class="fa fa-' + circle + '"></i></small></h3><small><em>' + notification.notification_type + '</em></small></a></li>'
// 					$('#notification-list').append(notif);
// 				}
// 			});
// 		})
// 	}

// 	// $('.favorite').click(function() {
// 	// 	var contact = $(this).data('contact');
// 	// 	var star = $(this);
// 	// 	console.log(contact);
// 		// $.ajax({
// 		// 	type: "POST",
// 		// 	url: "/toggle_favorite",
// 		// 	dataType: "json",
// 		// 	data: {contact: contact},
// 		// 	success: function(data) {
// 		// 		if (data.status) {
// 		// 			star.addClass('starred');
// 		// 		}
// 		// 		else {
// 		// 			star.removeClass('starred');
// 		// 		}
// 		// 	}
// 		// });
// 	// })
// });
