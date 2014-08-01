// jQuery(document).ready(function($) {

describe('getRandomInt', function() {
  it("returns a random integer bewteen the min and max values it is passed", function() {
    expect(getRandomInt(1, 8)).toEqual(jasmine.any(Number));
  });
});

describe('randomColorFromGroup', function() {
  it("returns a hex color code", function() {
  	var colorGroup0 = ["#FFE1F4", "#FFBFE8", "#FF99D9", "#FF82D0", "#FF6FC9", "#FF4DBC", "#FF2BAF", "#FF009F", "#F7009A", "#EC0094", "#DF008B"];
    var colorGroups = [colorGroup0];
    expect(randomColorFromGroup(0)).toMatch(/#\w+/);
  });
});

// describe(function setNodeColor() {
//   it("cleans the number by removing spaces and dashes", function() {
//     expect(CreditCard.cleanNumber("123 4-5")).toEqual("12345");
//   });
// });

// describe(function createSunburst() {
//   it("cleans the number by removing spaces and dashes", function() {
//     expect(CreditCard.cleanNumber("123 4-5")).toEqual("12345");
//   });
// });

// describe(function format_number() {
//   it("cleans the number by removing spaces and dashes", function() {
//     expect(CreditCard.cleanNumber("123 4-5")).toEqual("12345");
//   });
// });

// describe(function format_name() {
//   it("cleans the number by removing spaces and dashes", function() {
//     expect(CreditCard.cleanNumber("123 4-5")).toEqual("12345");
//   });
// });

// describe(function buildLegend() {
//   it("cleans the number by removing spaces and dashes", function() {
//     expect(CreditCard.cleanNumber("123 4-5")).toEqual("12345");
//   });
// });

// describe(function click() {
//   it("cleans the number by removing spaces and dashes", function() {
//     expect(CreditCard.cleanNumber("123 4-5")).toEqual("12345");
//   });
// });

// describe(function arcTween() {
//   it("cleans the number by removing spaces and dashes", function() {
//     expect(CreditCard.cleanNumber("123 4-5")).toEqual("12345");
//   });
// });
// });