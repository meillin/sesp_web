function drawDeviceAssetProjectionPerMonth() {
        $('#device-assets-projections-per-month-view').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: 'Device assets projections per month'
            },
            xAxis: {
                categories: ['March, 2013', 'April, 2013', 'May, 2013', 'June, 2013', 'July, 2013']
            },
            yAxis: {
                min: 0,
                title: {
                    text: ''
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
            text: 'Total device asset projection'
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
                ['Concerntrator installation',   45.0],
                ['Direct measured',       26.8],
                {
                    name: 'Troubleshoot measurepoint',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['CT measured',    8.5]]
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
                categories: ['March, 2013', 'April, 2013', 'May, 2013', 'June, 2013', 'July, 2013']
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'Resource projection per month'
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
            text: 'Total resource projection'
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
                ['Concerntrator installation',   45.0],
                ['Direct measured',       26.8],
                {
                    name: 'Troubleshoot measurepoint',
                    y: 12.8,
                    sliced: true,
                    selected: true
                },
                ['CT measured',    8.5]
                ]
        }]
    });
}
function drawResourceProjectionKPI(){
            $('#resource-projections-kpi').highcharts({
            chart: {
                type: 'column'
            },
            title: {
                text: 'Total available and planned hours'
            },
            xAxis: {
                gridLineWidth: 0,
                 labels: {
                    enabled: false
                 }
            },
            yAxis: {
                 gridLineWidth: 0,
                 labels: {
                    enabled: false
                 }
            },
            tooltip: {
                headerFormat: '',
                pointFormat: '{series.name}: ' +
                    '<b>{point.y:1f}hours</b><br/>',
                footerFormat: '',
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
                name: 'Planned hours',
                data: [340]

            }, {
                name: 'Total avaiable hours',
                data: [980]

            }]
        });
}
drawResourceProjectionKPI();
drawDeviceAssetProjectionPerMonth();
drawTotalDeviceAssetProjection();
drawResourceProjectionPerMonth();
drawTotalResourceProjection();
