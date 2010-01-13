Screw.Unit(function() {
  describe("mocking ajax", function() {
    it("allows mocking ajax request", function() {
      Smoke.Ajax.mock("/giveMeNiceResponseBaby", "Nice Response", 200);
      var data, textStatus;
      $.ajax({
        url: "/giveMeNiceResponseBaby",
        success: function(data_, textStatus_) {
          data = data_;
          textStatus = textStatus_;
      }});
      wait(function() {
        expect(data).to(equal, "Nice Response");
        expect(textStatus).to(equal, "success");
      }, 50);
    });
    
    it("should allow to make more then one request", function() {
      Smoke.Ajax.mock("/giveMeNiceResponseBaby", "Nice Response", 200);
      Smoke.Ajax.mock("/giveMeUglyResponseBaby", "Ugly Response", 200);

      var niceData, niceTextStatus, uglyData, uglyTextStatus;
      $.ajax({
        url: "/giveMeNiceResponseBaby",
        success: function(data_, textStatus_) {
          niceData = data_;
          niceTextStatus = textStatus_;
      }});
      
      $.ajax({
        url: "/giveMeUglyResponseBaby",
        success: function(data_, textStatus_) {
          uglyData = data_;
          uglyTextStatus = textStatus_;
      }});

      wait(function() {
        expect(niceData).to(equal, "Nice Response");
        expect(niceTextStatus).to(equal, "success");
        expect(uglyData).to(equal, "Ugly Response");
        expect(uglyTextStatus).to(equal, "success");
      }, 50);
    });
    
    it("should work with json responses", function() {
      Smoke.Ajax.mock("/some.json", "{foo: 'bar'}", 200);
      var data, textStatus;
      $.ajax({
        url: "/some.json",
        dataType: "json",
        success: function(data_, textStatus_) {
          data = data_;
          textStatus = textStatus_;
      }});
      wait(function() {
        expect(data.foo).to(equal, "bar");
        expect(textStatus).to(equal, "success");
      }, 50);
    });
  });
});
