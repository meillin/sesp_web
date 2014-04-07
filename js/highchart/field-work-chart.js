
$('#block-work-order-type-analysis-chart').highcharts({
    chart: {
        type: 'bar'
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
        data: [3, 4, 4]
    },{
        name: 'Expected working time',
        data: [5, 3, 4]
    }, {
        name: 'Actual working time',
        data: [2, 2, 3]
    }]
});
