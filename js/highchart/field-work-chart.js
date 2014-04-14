
    Highcharts.setOptions({
    //Green - #1abc9c //Blue - #428bca // Orange - #f0ad4e // Red - #d9534f //
     colors: ['#1abc9c','#d9534f','#428bca']
    });

$('#block-work-order-type-analysis-chart').highcharts({
    chart: {
        type: 'bar',
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
        }
    },
    series: [ {
        name: 'Travel time',
        data: [5, 4, 4]
    },{
        name: 'Expected working time',
        data: [5, 3, 4]
    }, {
        name: 'Actual working time',
        data: [5, 2, 3]
    }]
});
