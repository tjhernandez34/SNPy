jQuery(document).ready(function($) {

    var root = window.sunburstBottomData;
    console.log("data for bottom:", root);
    var width = 960,
        height = 740,
        radius = Math.min(width, height) / 2;

    var x = d3.scale.linear()
        .range([0, 2 * Math.PI]);

    var y = d3.scale.sqrt()
        .range([0, radius]);


    var colorGroup0 = ["#FFE1F4", "#FFBFE8", "#FF99D9", "#FF82D0", "#FF6FC9", "#FF4DBC", "#FF2BAF", "#FF009F", "#F7009A", "#EC0094", "#DF008B"];
    var colorGroup1 = ["#0000F7", "#3131C6", "#0000FF", "#3232CD", "#2B2BFF", "#5555D5", "#4D4DFF", "#7070DC", "#6F6FFF", "#8B8BE2", "#8282FF", "#9A9AE7", "#9999FF", "#ADADEB", "#BFBFFF", "#CCCCF2", "#E1E1FF"];
    var colorGroup2 = ["#006060", "#007171", "#007D7D", "#00A4A4", "#00B0B0", "#00D0D0", "#00DFDF", "#00ECEC", "#00F7F7", "#00FFFF", "#2BFFFF", "#4DFFFF"];
    var colorGroup3 = ["#E7F3FA", "#CCE6F2", "#ADD7EB", "#9ACEE7", "#8BC6E2", "#70B9DC", "#54ABD6", "#329BCD", "#3096C7", "#2E8FBE", "#2E8FBE"];
    var colorGroup4 = ["#DFDF00", "#ECEC00", "#F7F700", "#FFFF00", "#FFFF2B", "#FFFF4D", "#FFFF6F", "#FFFF82", "#FFFF99", "#FFFFBF", "#FFFFE1"];
    var colorGroup5 = ["#FFF0E1", "#FFDFBF", "#FFCC99", "#FFC082", "#FFB76F", "#FFA64D", "#FF8000", "#F77B00", "#EC7600", "#DF7000"];
    var colorGroup6 = ["#E7E9FA", "#CACEF4", "#AAB0EE", "#979FEA", "#8791E7", "#6A76E1", "#4E5BDC", "#2B3CD5", "#2939CD", "#2737C5", "#2534BA"];
    var colorGroup7 = ["#E8F9ED", "#CCF2D9", "#ADEBC1", "#9BE6B4", "#55D57E", "#8BE2A8", "#71DB94", "#33CC65", "#30BC5E", "#2DB358", "#2BA653"];
    var colorGroup8 = ["#FBE6E6", "#F5C9C9", "#F0A8A8", "#ED9494", "#EB8383", "#E66666", "#E14848", "#DB2424", "#D32323", "#CB2121", "#BF2020"];
    var colorGroup9 = ["#F0EDF3", "#DFD8E7", "#CCBFD9", "#C0B0D0", "#B7A5C9", "#A68FBC", "#957AAF", "#80609F", "#7B5C9A", "#765894", "#70548B"];
    var colorGroup10 = ["#FFE6E1", "#FFC9BF", "#FFA899", "#FF9582", "#FF846F", "#FF674D", "#FF4A2B", "#FF2600", "#F72500", "#EC2300", "#DF2200"];

    var colorGroups = [colorGroup0, colorGroup1, colorGroup2, colorGroup3, colorGroup4, colorGroup5, colorGroup6, colorGroup7, colorGroup8, colorGroup9, colorGroup10];

    var BASE_COLOR = "#2C2C28";
    var POSITIVE_COLOR = "#007D00";
    var NEGATIVE_COLOR = "#7D1300";

    createSunburst();
    // Reference: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random
    // Returns a random integer between min (included) and max (excluded)
    // Using Math.round() will give you a non-uniform distribution!
    function getRandomInt(min, max) {
        return Math.floor(Math.random() * (max - min)) + min;
    }

    function randomColorFromGroup(groupNumber) {
        var colorArray = colorGroups[groupNumber];
        var index = getRandomInt(0, colorGroups.length - 1);
        return colorArray[index];
    }

    function setNodeColor(node) {
        var color;
        if (node.depth === 0) {
            color = BASE_COLOR;
        } else {
            switch (node.group) {
                case "Positive":
                    color = POSITIVE_COLOR;
                    break;
                case "Negative":
                    color = NEGATIVE_COLOR;
                    break;
                default:
                    color = randomColorFromGroup(node.group);
            }
        }
        return (node.nodeColor = color);
    }


    // $(".chartbutton").on("click", function() {
    //     event.preventDefault();
    //     var chartUrl = $(this).attr("href")
    //     $(".tooltip").remove();
    //     d3.selectAll("svg").transition()
    //         .duration(1000)
    //         .style('opacity', 0.2)
    //         .remove();
    //     createSunburst();

    // });

    $("#search-button").on('click', function(event) {
        event.preventDefault();

        $(".tooltip").remove();
        d3.selectAll("svg").transition()
            .duration(1000)
            .style('opacity', 0.2)
            .remove();
        var searchTerm = $("#box").val().replace(/ /g, '+');
        var searchUrl = "/search?utf8=✓&search=" + searchTerm + "&commit=Search";

        console.log("search url:", searchUrl);
        createSunburst(searchUrl);
    });

    function createSunburst(url) {

        var svg = d3.select("#zoomable_sunburst_angular_bottom").append("svg")
            .attr("width", width)
            .attr("class", "sunburstgraph")
            .attr("height", height)
            .append("g")
            .attr("transform", "translate(" + ((width / 2) - 100) + "," + (height / 2) + ")");

        var partition = d3.layout.partition()
            .value(function(d) {
                return d.size;
            });

        arc = d3.svg.arc()
            .startAngle(function(d) {
                return Math.max(0, Math.min(2 * Math.PI, x(d.x)));
            })
            .endAngle(function(d) {
                return Math.max(0, Math.min(2 * Math.PI, x(d.x + d.dx)));
            })
            .innerRadius(function(d) {
                return Math.max(0, y(d.y));
            })
            .outerRadius(function(d) {
                return Math.max(0, y(d.y + d.dy));
            });

        var tooltip = d3.select("#zoomable_sunburst_angular_bottom")
            .append("div")
            .attr("class", "tooltip")
            .style("border-radius", 5)
            .style("position", "absolute")
            .style("z-index", "10")
            .style("opacity", 0);

        function formatNumber(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }


        function formatName(d) {
            var name = d.name;
            return '<b>' + name + '</b><br>';
        }


        // d3.json(url, function(root) {

        console.log("data:", root);

        var path = svg.selectAll("path")
            .data(partition.nodes(root))
            .enter().append("path")
            .attr("d", arc)
            .attr("id", function(d, i) {
                d.id = "" + i + "";
                return "path-" + i + "";
            })
            .style("stroke", "#2C2C28")
            .style("fill", setNodeColor)
            .style("opacity", .9)
            .on("click", click)
            .on("mouseover", function(d) {
                $(this).css("stroke-width", 5);
                // $(".legend #rect-" + d.id + "").css("stroke", "white");
                // $(".legend #text-" + d.id + "").css("stroke", "black");
                tooltip.html(function() {
                    var name = formatName(d);
                    return name;
                });
                return tooltip.transition()
                    .duration(50)
                    .style("opacity", 0.95);
            })
            .on("mousemove", function(d) {
                return tooltip
                    .style("top", (d3.event.pageY - 10) + "px")
                    .style("left", (d3.event.pageX - 120) + "px");
            })
            .on("mouseout", function(d) {
                $(this).css("stroke-width", 1);
                // $(".legend #rect-" + d.id + "").css("stroke", "none");
                // $(".legend #text-" + d.id + "").css("stroke", "none");
                return tooltip.style("opacity", 0);
            });

        buildLegend(root);

        function buildLegend(clickedObject) {

            $(".legend").remove();

            console.log(clickedObject);

            // I want to build the legend with only clickedObject's children whose value is not 0????

            var legendContainer = d3.select("#zoomable_sunburst_angular_bottom")
                .insert("svg")
                .attr("class", "legend")
                .attr("position", "absolute")
                .attr("margin-top", "-30%")
                .attr("width", 200)
                .attr("height", 700);
            var kids = []
            if (clickedObject.chidlren != null) {}
            for (var i = 0; i < clickedObject.children.length; i++) {
                //add it if number is >0
                if (clickedObject.children[i].value > 0) {
                    kids.push(clickedObject.children[i])
                }
            }
            console.log('heres the kids ', clickedObject.children)
            var legend = legendContainer.selectAll("rect")
                .data(kids)
                .enter()
                .append("rect")
                .attr("transform", function(d, i) {
                    return "translate(0," + i * 32 + ")";
                })
                .attr("id", function(d, i) {
                    // d.id = "" + i + "";
                    return "rect-" + i + "";
                })
                .attr("width", 200)
                .attr("margin-bottom", 1)
                .attr("margin-top", 1)
                .attr("height", 30)
                .style("fill", function(d) {
                    return d.nodeColor;
                })
                .on("click", click)
                .on("mouseover", function(d) {
                    console.log(this);
                    $(this).css("stroke", "white");
                    $(".legend #text-" + d.id + "").css("stroke", "black");
                    $("g #path-" + d.id + "").css("stroke-width", 5);
                })
                .on("mouseout", function(d) {
                    $(this).css("stroke", "none");
                    $(".legend #text-" + d.id + "").css("stroke", "none");
                    $("g #path-" + d.id + "").css("stroke-width", 1);
                });



            legendContainer.selectAll("text")
                .data(kids)
                .enter()
                .append("text")
                .attr("dy", ".35em")
                .attr("id", function(d, i) {
                    // d.id = "" + i + "";
                    return "text-" + i + "";
                })
                .attr("transform", function(d, i) {
                    return "translate(100," + ((i * 32) + 15) + ")";
                })
                .style("text-anchor", "middle")
                .style("fill", "black")
                .text(function(d) {
                    return d.name;
                })
                .on("click", click)
                .on("mouseover", function(d) {
                    console.log(this);
                    $(this).css("stroke", "black");
                    $(".legend #rect-" + d.id + "").css("stroke", "white");
                    $("g #path-" + d.id + "").css("stroke-width", 5);
                })
                .on("mouseout", function(d) {
                    $(this).css("stroke", "none");
                    $(".legend #text-" + d.id + "").css("stroke", "none");
                    $("g #path-" + d.id + "").css("stroke-width", 1);
                    $("g #path-" + d.id + "").css("opacity", 1.2);
                });
        }


        function click(d) {

            path.transition()
                .duration(750)
                .attrTween("d", arcTween(d));

            d3.select(".legend").transition()
                .duration(100)
                .style('opacity', 0.2)
                .remove();

            buildLegend(d);
        }

        // });



        d3.select(self.frameElement).style("height", height + "px");

        // Interpolate the scales!
        function arcTween(d) {
            var xd = d3.interpolate(x.domain(), [d.x, d.x + d.dx]),
                yd = d3.interpolate(y.domain(), [d.y, 1]),
                yr = d3.interpolate(y.range(), [d.y ? 20 : 0, radius]);
            return function(d, i) {
                return i ? function(t) {
                    return arc(d);
                } : function(t) {
                    x.domain(xd(t));
                    y.domain(yd(t)).range(yr(t));
                    return arc(d);
                };
            };
        }

    }

});
