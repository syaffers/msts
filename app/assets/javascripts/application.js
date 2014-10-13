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
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).ready( function() {
	var mPrice = parseFloat($('#member_price-display').text());
	var nmPrice = parseFloat($('#non_member_price-display').text());

	setTimeout(function () {
		$("#notice").fadeOut(500);
	}, 2000)

	$("#ticket_qty").attr('type', 'number');

	$("#non_member_price-display").hide();

	$("#ticket_event_id").bind('railsAutocomplete.select', function(event, data) {
		/* Do something here */
		$("#member_price-display").text(parseFloat(data.item.member_price).toFixed(2));
		$("#non_member_price-display").text(parseFloat(data.item.non_member_price).toFixed(2));
		mPrice = parseFloat(data.item.member_price)
		nmPrice = parseFloat(data.item.non_member_price)
		if($("#ticket_member").is(":checked")) {
			$("#member_price-display").show()
			$("#non_member_price-display").hide();
		}
		else {
			$("#member_price-display").hide()
			$("#non_member_price-display").show();
		}
	});

	$("#ticket_member").change( function() {
		if($(this).is(":checked")) {
			$("#member_price-display").show()
			$("#non_member_price-display").hide();
		}
		else {
			$("#member_price-display").hide()
			$("#non_member_price-display").show();
		}
	});

	$("#ticket_qty").on( 'keyup click', function() {
		if( $(this).val() != '' ) {
			$("#member_price-display").text( (mPrice * parseFloat($(this).val())).toFixed(2) );
			$("#non_member_price-display").text( (nmPrice * parseFloat($(this).val())).toFixed(2) );
		}
		else {
			$("#member_price-display").text( mPrice.toFixed(2) );
			$("#non_member_price-display").text( nmPrice.toFixed(2) );
		}
		if( parseInt($(this).val()) < 1 || isNaN(parseInt($(this).val())) ) {
			$(this).val("1");
		}
	});

	$('#student-search-btn').click(function () {
		if($('#student-search-box').val() != "") {
			$('#student-search-btn').css("margin-bottom", "20px");
			$(".pagination").hide();
		}
	})

	$("#clear-search-button").click( function() {
		$("#student-search-box").val('');
		$("#student-search-btn").removeAttr("style");
		$(".pagination").show();
		$("#search-form").submit();
	});

	$(".role-selector").on('change', function() {
		this.form.submit();
	});
})
