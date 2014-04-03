function drawDeviceAssetProjectionPerMonth() {
        $('#device-assets-projections-per-month-view').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Device assets projections per month'
            },
            xAxis: {
                categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Total fruit consumption'
                }
            },
            legend: {
                backgroundColor: '#FFFFFF',
                reversed: true
            },
            plotOptions: {
                series: {
                    stacking: 'normal'
                }
            },
                series: [{
                name: 'Concerntrator installation',
                data: [5, 3, 4, 7, 2]
            }, {
                name: 'Direct measured',
                data: [2, 2, 3, 2, 1]
            }, {
                name: 'Troubleshoot measurepoint',
                data: [3, 4, 4, 2, 5]
            },{
                name: 'CT measured',
                data: [3, 4, 4, 2, 5]
            }]
        });
    }
function drawTotalDeviceAssetProjection() {
     $('#device-assets-projections-total-view').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Browser market shares at a specific website, 2010'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Firefox',   45.0],
                ['IE',       26.8],
                {
                    name: 'Chrome',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['Safari',    8.5],
                ['Opera',     6.2],
                ['Others',   0.7]
            ]
        }]
    });
}
function drawResourceProjectionPerMonth() {
        $('#resource-projections-per-month-view').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Resource projection per month'
            },
            xAxis: {
                categories: ['Apples', 'Oranges', 'Pears', 'Grapes', 'Bananas']
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Total fruit consumption'
                }
            },
            legend: {
                backgroundColor: '#FFFFFF',
                reversed: true
            },
            plotOptions: {
                series: {
                    stacking: 'normal'
                }
            },
                series: [{
                name: 'Concerntrator installation',
                data: [5, 3, 4, 7, 2]
            }, {
                name: 'Direct measured',
                data: [2, 2, 3, 2, 1]
            }, {
                name: 'Troubleshoot measurepoint',
                data: [3, 4, 4, 2, 5]
            },{
                name: 'CT measured',
                data: [3, 4, 4, 2, 5]
            }]
        });
    }
function drawTotalResourceProjection() {
     $('#resource-projections-total-view').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: 'Browser market shares at a specific website, 2010'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                }
            }
        },
        series: [{
            type: 'pie',
            name: 'Browser share',
            data: [
                ['Firefox',   45.0],
                ['IE',       26.8],
                {
                    name: 'Chrome',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['Safari',    8.5],
                ['Opera',     6.2],
                ['Others',   0.7]
            ]
        }]
    });
}
drawDeviceAssetProjectionPerMonth();
drawTotalDeviceAssetProjection();
drawResourceProjectionPerMonth();
drawTotalResourceProjection();
