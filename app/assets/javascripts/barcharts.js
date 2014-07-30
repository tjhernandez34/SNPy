// $(document).ready(function() {

//     var disease_id = $(".disease_bar_chart").attr("id");

//     // Kick it off
//     var margin = {
//             top: 20,
//             right: 20,
//             bottom: 30,
//             left: 40
//         },
//         width = 260 - margin.left - margin.right,
//         height = 350 - margin.top - margin.bottom;

//     var x = d3.scale.ordinal()
//         .rangeRoundBands([0, width], .1);

//     var y = d3.scale.linear()
//         .range([height, 0]);

//     var xAxis = d3.svg.axis()
//         .scale(x)
//         .orient("bottom");

//     var yAxis = d3.svg.axis()
//         .scale(y)
//         .orient("left")
//         .ticks(10, "%");

//     var svg = d3.select(".disease_bar_chart").append("svg")
//         .attr("width", width + margin.left + margin.right)
//         .attr("height", height + margin.top + margin.bottom)
//         .append("g")
//         .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

//     d3.json("/barchart/" + disease_id + "", function(data) {
//         console.log(data);
//         var data = data[0];
//         x.domain(data.map(function(d) {
//             return d.group;
//         }));
//         y.domain([0, d3.max(data, function(d) {
//             return d.value;
//         })]);

//         svg.append("g")
//             .attr("class", "x axis")
//             .attr("transform", "translate(0," + height + ")")
//             .call(xAxis);

//         svg.append("g")
//             .attr("class", "y axis")
//             .call(yAxis)
//             .append("text")
//             .attr("transform", "rotate(-90)")
//             .attr("y", 6)
//             .attr("dy", ".71em")
//             .style("text-anchor", "end")
//             .text("Frequency");

//         svg.selectAll(".bar")
//             .data(data)
//             .enter().append("rect")
//             .attr("class", "bar")
//             .attr("x", function(d) {
//                 return x(d.group);
//             })
//             .attr("width", x.rangeBand())
//             .attr("y", function(d) {
//                 return y(d.value);
//             })
//             .attr("height", function(d) {
//                 return height - y(d.value);
//             });

//     });

//     function type(d) {
//         d.value = +d.value;
//         return d;
//     }

// });
