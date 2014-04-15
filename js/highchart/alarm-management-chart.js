$(function () {
    function drawAlarmChart() {
        Highcharts.setOptions({
            colors: ['#1abc9c', '#428bca', '#d9534f', '#f0ad4e', '#5bc0de', '#1d2939']
        });
        $('#alarm-charts-view').highcharts({
            chart: {
                type: 'column',
                height: 503
            },
            title: {
                text: 'Product Comparison'
            },
            xAxis: {
                categories: [
                    'Product A',
                    'Product B',
                    'Product C',
                    'Product D',
                    'Product E'
                ]
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
                }
            },
            tooltip: {
                headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
                pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                    '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
                footerFormat: '</table>',
                shared: true,
                useHTML: true
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0
                }
            },
            series: [{
                name: '2007',
                data: [49.9, 71.5, 106.4, 129.2, 144.0]

            }, {
                name: '2008',
                data: [83.6, 78.8, 98.5, 93.4, 106.0]

            }, {
                name: '2009',
                data: [48.9, 38.8, 39.3, 41.4, 47.0]

            }]
        });
    }
    drawAlarmChart();

});



