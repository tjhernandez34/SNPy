function createSunburst(url) {
    var url = url;
    var partition = d3.layout.partition()
        .value(function(d) {
            return d.size;
        });

    var arc = d3.svg.arc()
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
            .style("fill", function(d) {
                if (d.depth == 0) {
                    return "#2C2C28";
                } else if (d.depth == 3) {
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

        function click(d) {
            path.transition()
                .duration(750)
                .attrTween("d", arcTween(d));
        }

    });
};
