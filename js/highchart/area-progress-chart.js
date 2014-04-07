function drawWorkOrderProgress() {
    // Build the chart
    $('#work-order-chart-view').highcharts({
        chart: {
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false,
            height: 300
        },
        legend: {
            layout: 'vertical',
            backgroundColor: '#FFFFFF',
            align: 'right',
            verticalAlign: 'top',
            floating: true,
            x: -20,
            y: 80
        },
        title: {
            text: ''
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: false
                },
                center: [100, 110],
                showInLegend: true
            }
        },
        series: [{
            type: 'pie',
            name: 'Work order progress',
            size: '60%',
            data: [
                ['Performed within plan', 2100],
                ['Unplanned', 500],
                {
                    name: 'Performed after plan',
                    y: 150,
                    sliced: true,
                    selected: true
                },
                ['Not yet performed after plan', 201],
                ['Not yet performed within plan', 1200]
            ]
        }]
    });
}
function drawDetailedProgress() {
    $('#detailed-progress').highcharts({
        chart: {
            height: 300
        },
        title: {
            text: ''
        },
        xAxis: [{
            categories: ['Week11', 'Week12', 'Week13', 'Week14', 'Week15', 'Week16',
                'Week17', 'Week18', 'Week19', 'Week20']
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value}',
                style: {
                    color: '#89A54E'
                }
            },
            title: {
                text: 'Planned work orders',
                style: {
                    color: '#89A54E'
                }
            }
        }, { // Secondary yAxis
            title: {
                text: 'Available resources',
                style: {
                    color: '#4572A7'
                }
            },
            labels: {
                format: '{value}',
                style: {
                    color: '#4572A7'
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 120,
            verticalAlign: 'top',
            y: 100,
            floating: true,
            backgroundColor: '#FFFFFF'
        },
        series: [{
            name: 'Available resources',
            color: '#4572A7',
            type: 'column',
            yAxis: 1,
            data: [49.9, 71.5, 106.4, 129.2, 144.0, 176.0, 135.6, 148.5, 216.4, 194.1],
            tooltip: {
                valueSuffix: ' mm'
            }

        }, {
            name: 'Planned work orders',
            color: '#89A54E',
            type: 'spline',
            data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3],
            tooltip: {
                valueSuffix: '°C'
            }
        }]
    });
}
var colors = Highcharts.getOptions().colors;
function drawWorkOrderStatus() {
       var categories = ['Performed', 'Not performed', 'Not planned', 'Not performed final', 'Opera'],
        name = '',
        data = [{
                y: 10000,
                color: colors[0],
                drilldown: {
                    name: 'Performed versions',
                    categories: ['Performed'],
                    data: [10000],
                    color: colors[0]
                }
            }, {
                y: 1000,
                color: colors[1],
                drilldown: {
                    name: 'Not performed versions',
                    categories: ['Not performed'],
                    data: [1000],
                    color: colors[1]
                }
            }, {
                y: 1000,
                color: colors[2],
                drilldown: {
                    name: 'Not planned versions',
                    categories: ['Not planned versions'],
                    data: [1000],
                    color: colors[2]
                }
            }, {
                y: 5470,
                color: colors[3],
                drilldown: {
                    name: 'Not performed final versions',
                    categories: ['With time reservation', 'Missed time reservation', 'Planned', 'Saved with errors', 'Undefined'],
                    data: [2500, 2000, 470, 300, 200],
                    color: colors[3]
                }
            }];
    // Build the data arrays
    var browserData = [];
    var versionsData = [];
    for (var i = 0; i < data.length; i++) {

        // add browser data
        browserData.push({
            name: categories[i],
            y: data[i].y,
            color: data[i].color
        });

        // add version data
        for (var j = 0; j < data[i].drilldown.data.length; j++) {
            var brightness = 0.2 - (j / data[i].drilldown.data.length) / 5 ;
            versionsData.push({
                name: data[i].drilldown.categories[j],
                y: data[i].drilldown.data[j],
                color: Highcharts.Color(data[i].color).brighten(brightness).get()
                });
            }
    }
    // Create the chart
    $('#work-order-status').highcharts({
        chart: {
            type: 'pie',
            height: 300,
            width: ''
        },
        title: {
            text: ''
        },
        yAxis: {
            title: {
                text: 'Total percent market share'
            }
        },
        plotOptions: {
            pie: {
                shadow: false,
                center: ['50%', '50%']
            }
        },
        tooltip: {
            valueSuffix: ''
        },
        series: [{
            name: 'Work Order',
            data: browserData,
            size: '60%',
            dataLabels: {
                formatter: function() {
                    //return this.y > 5 ? this.point.name : null;
                },
                color: 'white',
                distance: -30
            }
        }, {
            name: 'Versions',
            data: versionsData,
            size: '80%',
            innerSize: '60%',
            dataLabels: {
                formatter: function() {
                    // display only if larger than 1
                    return this.y > 1 ? '<b>'+ this.point.name +':</b> '+ this.y +''  : null;
                }
            }
        }]
    });
}
 drawWorkOrderProgress();
    drawDetailedProgress();
        drawWorkOrderStatus();

$('#block-work-order-tab2').click(function(){
    $('.show').hide();
    $('.hide').show();
});
$('#block-work-order-tab1').click(function(){
    $('.hide').hide();
    $('.show').show();

});














