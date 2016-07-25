function getNumber(){
	$.ajax({
		url: '/number',
		dataType: 'JSON',
		type: 'GET',
		success: function(data) {$('#total_links').html(data)}
	});
}

$(document).ready(function(){
	setInterval(function(){ getNumber() }, 1000);
	$("form#form").on('submit', function(event){ //'event' is a variable
		event.preventDefault();
		$.ajax({
			cache: false, //send to controller
			url: '/',
			dataType: 'JSON',
			type: 'POST',
			data: $(this).serialize(), //serialize converts the info inside form into hash. 'this' refers to form
			success: function(data) { //'data' is also a variable
				if (data.long_url == 'invalid url') { //when receive from controller
					$('#ohno').html('this url is invalid!')
				} 
				else {
					$('#result').html("<a href='"+data.short_url+"' target='_blank' >" +data.short_url+ "</a>  " + data.count_short_url);
					$('#ohno').html('it works!')
				}
			},
			error: function(data){
				$('#ohno').html('this is a computer error. unable to convert to json')}
		})
	})
});


$(document).ready(function(){
  $('.aboutme').click(function(){
  	$('#text_inside').fadeToggle();
  });
});


