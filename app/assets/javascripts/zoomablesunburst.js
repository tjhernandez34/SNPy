$(document).ready(function() {
    // Start of sunburst code on click of the search button
    var width = 960,
        height = 740,
        radius = Math.min(width, height) / 2;

    var x = d3.scale.linear()
        .range([0, 2 * Math.PI]);

    var y = d3.scale.sqrt()
        .range([0, radius]);

    var color = d3.scale.category20c();
    var colorCat = d3.scale.category20();
    var colorRisk = d3.scale.category10();


    createSunburst("/sunburst");


    function simulateClick(target) {
        var event = document.createEvent("MouseEvents");
        event.initMouseEvent("click", true, true, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
        !target.dispatchEvent(event);
    };

    $("#zoombutton").on("click", function() {
        d3.select("svg").transition()
            .duration(1000)
            .style('opacity', .2)
            .remove();
        createSunburst("/sunburst");
    });

    $("#search-button").on('click', function(event) {
        event.preventDefault();
        console.log(event);
        console.log($("g path:last-child")[0]);
        var d = $("g path:last-child")[0];
        d3.select("svg").transition()
            .duration(750)
            .style('opacity', .2)
            .remove();

        var searchTerm = $("#box").val().replace(/ /g, '+');
        var searchUrl = "/search?utf8=✓&search=" + searchTerm + "&commit=Search";

        // $.get(searchUrl, function(result) {
        //     console.log(result);;
        // })

        console.log("search url:", searchUrl);
        createSunburst(searchUrl);
        simulateClick($("g path:nth-child(1)")[0]);
    });

    function createSunburst(url) {
        var url = url;


        var svg = d3.select("#zoomable_sunburst").append("svg")
            .attr("width", width)
            .attr("height", height)
            .append("g")
            .attr("transform", "translate(" + width / 2 + "," + (height / 2) + ")");

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


        var tooltip = d3.select("#zoomable_sunburst")
            .append("div")
            .attr("class", "tooltip")
            .style("position", "absolute")
            .style("z-index", "10")
            .style("opacity", 0);

        function format_number(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
        }


        function format_name(d) {
            console.log(d);
            var name = d.name;
            return '<b>' + name + '</b><br>';
            // (' + format_number(d.size) + ')'
        }

        var searchTerm = $("#box").val().replace(/ /g, '+');

        d3.json(url, function(error, root) {

            console.log("xhr search data:", root);

            var path = svg.selectAll("path")
                .data(partition.nodes(root))
                .enter().append("path")
                .attr("d", arc)
                .attr("class", function(d) {
                    if (d.depth === 3) {
                        return "allele";
                    }
                })
                .style("fill", function(d) {
                    if (d.depth === 0) {
                        return "#2C2C28";
                    } else if (d.depth === 3) {
                        var c = ["#ee8e8e", "#d84343", "#69d488", "#51bc55"]
                        return c[(Math.floor((Math.random() * 3) + 1))];
                    } else {
                        return colorCat((d).name);
                    }
                })
                .on("click", click)
                .on("mouseover", function(d) {
                    tooltip.html(function() {
                        var name = format_name(d);
                        return name;
                    });
                    return tooltip.transition()
                        .duration(50)
                        .style("opacity", 0.9);
                })
                .on("mousemove", function(d) {
                    return tooltip
                        .style("top", (d3.event.pageY - 10) + "px")
                        .style("left", (d3.event.pageX + 10) + "px");
                })
                .on("mouseout", function() {
                    return tooltip.style("opacity", 0);
                });

            // $(".allele").hide();

            function click(d) {
                // d.attr("id")
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
                return i ? function(t) {
                    return arc(d);
                } : function(t) {
                    x.domain(xd(t));
                    y.domain(yd(t)).range(yr(t));
                    return arc(d);
                };
            };
        }

    };


})
