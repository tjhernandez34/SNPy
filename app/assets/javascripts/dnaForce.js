// $(document).ready(function(){
//         var width = 1500,
//             height = 1500;
        
//         var svg = d3.select('#dna_force')
//           .append('svg')
//             .attr('width', width)
//             .attr('height', height);


//         var force = d3.layout.force()
//             .charge(-120)
//             .linkDistance(30)
//             .size([width, height])

//     d3.json('/welcome/force', function(json){
//         console.log(json);
//         force.nodes(json.nodes)
//             .links(json.links)
//             .start();

//         // draw the graph nodes
//         var node = svg.selectAll("circle.node")
//           .data(json.nodes)
//           .enter()
//           .append("circle")
//             .attr("class", "node")
//             .attr("r", 12);
        
//         // draw the graph edges
//         var link = svg.selectAll("line.link")
//           .data(json.links)
//           .enter().append("line")
//             .style('stroke','black');
        
//         // create the layout

        
//         // define what to do one each tick of the animation
//         force.on("tick", function(d) {
//             console.log(d);
//             link.attr("x1", function(d) { return d.source.x; })
//                 .attr("y1", function(d) { return d.source.y; })
//                 .attr("x2", function(d) { return d.target.x; })
//                 .attr("y2", function(d) { return d.target.y; });
            
//             node.attr("cx", function(d) { return d.x; })
//                 .attr("cy", function(d) { return d.y; });

//                 console.log(d);
//             });

//         // bind the drag interaction to the nodes
//         node.call(force.drag);
//     });
// });
//         