$(document).ready(function(){


	// $.post('/chart', function(response){
	// 	data = response;
	// 	console.log(data)
	// 	// chart(data)
	// });
	// console.log(flare.json)



	var width = 960,
	    height = 700,
	    radius = Math.min(width, height) / 2;

	var x = d3.scale.linear()
	    .range([0, 2 * Math.PI]);

	var y = d3.scale.sqrt()
	    .range([0, radius]);

	var color = d3.scale.category20c();

	var svg = d3.select("body").append("svg")
	    .attr("width", width)
	    .attr("height", height)
	  .append("g")
	    .attr("transform", "translate(" + width / 2 + "," + (height / 2 + 10) + ")");

	var partition = d3.layout.partition()
	    .value(function(d) { return d.size; });


	var arc = d3.svg.arc()
	    .startAngle(function(d) { return Math.max(0, Math.min(2 * Math.PI, x(d.x))); })
	    .endAngle(function(d) { return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx))); })
	    .innerRadius(function(d) { return Math.max(0, y(d.y)); })
	    .outerRadius(function(d) { return Math.max(0, y(d.y + d.dy)); });

	d3.json("chart", function(error, root) {
		console.log(root);
	  var path = svg.selectAll("path")
	      .data(partition.nodes(root))
	    .enter().append("path")
	      .attr("d", arc)
	      .style("fill", function(d) { return color((d.children ? d : d.parent).name); })
	      .on("click", click);

	  function click(d) {
	    path.transition()
	      .duration(750)
	      .attrTween("d", arcTween(d));
	  }
	});

	d3.select(self.frameElement).style("height", height + "px");

	// Interpolate the scales!
	function arcTween(d) {
	  var xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
	      yd = d3.interpolate(y.domain(), [d.y, 1]),
	      yr = d3.interpolate(y.range(), [d.y ? 20 : 0, radius]);
	  return function(d, i) {
	    return i
	        ? function(t) { return arc(d); }
	        : function(t) { x.domain(xd(t)); y.domain(yd(t)).range(yr(t)); return arc(d); };
	  };
	}
})
// var data = [4,8,15,16,23,42];

// var x = d3.scale.linear()
// 	.domain([0, d3.max(data)])
// 	.range(["0px", "420px"]);

// var y = d3.scale.ordinal()
// 	.domain(data)
// 	.rangeBands([0,120]);


//   var chart = d3.select("body")
//     .append("svg:svg")
//       .attr("class", "chart")
//       .attr("width", 440)
//       .attr("height", 140)
//     .append("svg:g")
//     	.attr("transform", "translate(10,15)");


//   chart.selectAll("line")
//       .data(x.ticks(10))
//     .enter().append("svg:line")
//       .attr("x1", x)
//       .attr("x2", x)
//       .attr("y1", 0)
//       .attr("y2", 120)
//       .attr("stroke", "#ccc");


//   chart.selectAll("div")
//   		.data(data)
//   	.enter().append("svg:rect")
//   		.attr("y", y)
//   		.attr("width", x)
//   		.attr("height", y.rangeBand());

//   chart.selectAll("text")
//      .data(data)
//     .enter().append("svg:text")
//       .attr("x", x)
//       .attr("y", function(d) { return y(d) + y.rangeBand() / 2; })
//       .attr("dx", -3) // padding-right
//       .attr("dy", ".35em") // vertical-align: middle
//       .attr("text-anchor", "end") // text-align: right
//       .text(String);

//   chart.selectAll("text.rule")
//       .data(x.ticks(10))
//     .enter().append("svg:text")
//       .attr("class", "rule")
//       .attr("x", x)
//       .attr("y", 0)
//       .attr("dy", -3)
//       .attr("text-anchor", "middle")
//       .text(String);


//   chart.append("svg:line")
//       .attr("y1", 0)
//       .attr("y2", 120)
//       .attr("stroke", "#000");

