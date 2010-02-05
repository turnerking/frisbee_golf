// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


function add_hole() {
	var current_index = new RegExp(/\d+/).exec($(".hole_fields:last .field_row:last input").attr("name"));
	var partial = $("div.hole_fields:last").clone(true).insertAfter("div.hole_fields:last");
	var new_index = (new Number(current_index) + 1).toString();
	var inputs = $("div.hole_fields:last .field_row input");
	var labels = $("div.hole_fields:last .field_row label");
	for(var i=0; i < inputs.length; i++) {
		$(labels[i]).attr("for", $(labels[i]).attr("for").replace(/\d+/, new_index));
		$(inputs[i]).attr("id", $(inputs[i]).attr("id").replace(/\d+/, new_index));
		$(inputs[i]).attr("name", $(inputs[i]).attr("name").replace(/\d+/, new_index));
	}
};

var scoreShots = function() {
	var total = 0;
	$(".shots").each(function() {
		total += new Number($(this).val());
	});
	$("p.shot_total").html(total);
}

$(document).ready(function() {
	scoreShots();
	$(".shots").keyup(scoreShots);
});

$(document).ready(function() {
	if($("div.notice, div.error")) {
		setTimeout("$(\"div.notice, div.error\").slideUp(500)", 2000);
	}
});

