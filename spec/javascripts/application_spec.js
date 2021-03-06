require("spec_helper.js");
require("../../public/javascripts/jquery-1.3.2.js");
require("../../public/javascripts/jquery-ui-1.7.2.custom.min.js")
require("../../public/javascripts/application.js");

Screw.Unit(function(){
  describe("Your application javascript", function(){
    it("does something", function(){
      expect("hello").to(equal, "hello");
    });

    it("accesses the DOM from fixtures/application.html", function(){
      expect($('.select_me').length).to(equal, 2);
    });

		it("adds a hole to the bottom of the list", function(){
		  $("#add_hole").click();
			expect($('.hole_fields').length).to(equal, 2);
			expect($('.hole_fields:last .row:last input').attr("name")).to(equal, "course[holes_attributes][1][distance_in_ft]");
		});
		
		it("adds up scores", function(){
		  $(".shots:first").val("3");
			$(".shots:first").keyup();
			expect($("p.shot_total").html()).to(equal, "3");
		});
  });
});

