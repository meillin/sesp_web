
$(function () {

    Highcharts.setOptions({colors: ['#1abc9c','#d9534f','#428bca']});
    // Define a custom symbol path
    Highcharts.SVGRenderer.prototype.symbols.cross = function (x, y, w, h) {
        return ['M', x, y-20, 'L', x , y + h+30,'z'];
    };
    if (Highcharts.VMLRenderer) {
        Highcharts.VMLRenderer.prototype.symbols.cross = Highcharts.SVGRenderer.prototype.symbols.cross;
    }

    $('#block-work-order-type-analysis-chart').highcharts({
    chart: {
        height: 280
    },
    title: {
        text: ''
    },
    xAxis: {
        categories: ['Meter rollout', 'Concentrator installation', 'Meter change']
    },
    yAxis: {
    },
    legend: {
        backgroundColor: '#FFFFFF'
    },
    plotOptions: {
        series: {
            stacking: 'normal'
        },
        scatter: {
            color: '#428bca',
        },
    },
    series: [ {
        type: 'bar',
        name: 'Travel time',
        data: [5, 4, 4]
    },{
        type: 'scatter',
        name: 'Expected working time',
        data: [5, 3, 4],
         marker: {
                symbol: 'cross',
                lineColor: null,
                lineWidth: 2,

            }
    }, {
        type: 'bar',
        name: 'Actual working time',
        data: [5, 2, 3]
    }]
},function(chart){
        $.each(chart.series[1].data,function(i,point){
            point.angle = 90;
            this.graphic.attr({
                rotation:point.angle
            })
            .translate(10,-10);
        });
    });

});


