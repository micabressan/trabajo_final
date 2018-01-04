//When evey DOM tree is loaded
$(document).ready(function(){
 
    //File path
    var data_path = "data/UW_2006_2014.csv";
 
    var width = $(window).width();
    $("#content").css("left", (width-1000)/2);
    $("#content").css("top", "50px");
 
    d3.csv(data_path, function(error, data) {
        if (error) throw error;
        else{
            console.log(data);
            //Write your code here
 
 
            var margins = {top: 20, right: 20, bottom: 30, left: 40},
                legendPanel = {
                    width: 180
                },
                width = 920 - margins.left - margins.right - legendPanel.width,
                height = 500 - margins.top - margins.bottom,
                
                series = dataset.map(function (d) {
                    return d.name;
                }),
                dataset = dataset.map(function (d) {
                    return d.data.map(function (o, i) {
                        // Structure it so that your numeric
                        // axis (the stacked amount) is y
                        return {
                            y: o.count,
                            x: o.year
                        };
                    });
                }),
                stack = d3.layout.stack();
 
            stack(dataset);
 
            var dataset = dataset.map(function (group) {
                return group.map(function (d) {
                    // Invert the x and y values, and y0 becomes x0
                    return {
                        x: d.y,
                        y: d.x,
                        x0: d.y0
                    };
                });
            }),
                svg = d3.select('svg')
                    .append('svg')
                    .attr('width', width + margins.left + margins.right + legendPanel.width)
                    .attr('height', height + margins.top + margins.bottom)
                    .append('g')
                    .attr('transform', 'translate(' + margins.left + ',' + margins.top + ')'),
                xMax = d3.max(dataset, function (group) {
                    return d3.max(group, function (d) {
                        return d.x + d.x0;
                    });
                }),
                xScale = d3.scale.linear()
                    .domain([0, xMax])
                    .range([0, width]),
                months = dataset[0].map(function (d) {
                    return d.y;
                }),
                yScale = d3.scale.ordinal()
                    .domain(months)
                    .rangeRoundBands([0, height], .1),
                xAxis = d3.svg.axis()
                    .scale(xScale)
                    .orient('bottom'),
                yAxis = d3.svg.axis()
                    .scale(yScale)
                    .orient('left'),
                colours = d3.scale.category10(),
                groups = svg.selectAll('g')
                    .data(dataset)
                    .enter()
                    .append('g')
                    .style('fill', function (d, i) {
                        return colours(i);
                    }),
                rects = groups.selectAll('rect')
                    .data(function (d) {
                        return d;
                    })
                    .enter()
                    .append('rect')
                    .attr('x', function (d) {
                        return xScale(d.x0);
                    })
                    .attr('y', function (d, i) {
                        return yScale(d.y);
                    })
                    .attr('height', function (d) {
                        return yScale.rangeBand();
                    })
                    .attr('width', function (d) {
                        return xScale(d.x);
                    })
                    .on('mouseover', function (d) {
                        var xPos = parseFloat(d3.select(this).attr('x')) / 2 + width / 2;
                        var yPos = parseFloat(d3.select(this).attr('y')) + yScale.rangeBand() / 2;
 
                        d3.select('#tooltip')
                            .style('left', xPos + 'px')
                            .style('top', yPos + 'px')
                            .select('#value')
                            .text(d.x);
 
                        d3.select('#tooltip').classed('hidden', false);
                    })
                    .on('mouseout', function () {
                        d3.select('#tooltip').classed('hidden', true);
                    })
 
            svg.append('g')
                .attr('class', 'axis')
                .attr('transform', 'translate(0,' + height + ')')
                .call(xAxis);
 
            svg.append('g')
                .attr('class', 'axis')
                .call(yAxis);
 
            svg.append('rect')
                .attr('fill', 'white')
                .attr('width', 200)
                .attr('height', 30 * dataset.length)
                .attr('x', width + margins.left)
                .attr('y', 0);
 
            series.forEach(function (s, i) {
                svg.append('text')
                    .attr('fill', 'black')
                    .attr('x', width + margins.left - 22)
                    .attr('y', i * 24 + 24)
                    .text(s);
                svg.append('rect')
                    .attr('fill', colours(i))
                    .attr('width', 60)
                    .attr('height', 20)
                    .attr('x', width + margins.left + 90)
                    .attr('y', i * 24 + 6);
            });
 
                
        }
        
    }); 
});