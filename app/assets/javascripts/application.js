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
//= require jquery-ui
//= require autocomplete-rails
//= require bootstrap
//= require turbolinks
//= require_tree .

$(document).ready( function() {
	$("#ticket_event_id").bind('railsAutocomplete.select', function(event, data) {
		/* Do something here */
		$("#member_price-display").text(data.item.member_price);
		$("#non_member_price-display").text(data.item.non_member_price);
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
})