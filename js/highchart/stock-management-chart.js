    function drawDeviceChart() {
        Highcharts.setOptions({
            colors: ['#1abc9c', '#428bca', '#d9534f', '#f0ad4e', '#5bc0de', '#1d2939']
        });
        $('#on-pallet-chart-view').highcharts({
            chart: {
                type: 'column',
                height: 410
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: ['Antenna', 'Antenna Model 1', 'Antenna Model 2', 'Com Module',
                'Concentrator GPRS B', 'Meter Combined GPRS A', 'Meter Combined B', 'Meter PLC B', 'SIM card'],
                labels: {
                    rotation: 45
                }
            },
            yAxis: {
                text: 'Number of devices'
            },
            legend: {
                backgroundColor: '#FFFFFF'
            },
            plotOptions: {
                series: {
                    stacking: 'normal'
                }
            },
            series: [{
                        name: 'KBA Stock 4',
                        data: [3, 4, 4, 3, 4, 4, 3, 4, 4]
                    },{
                        name: 'KBA Stock 3',
                        data: [5, 3, 4, 5, 3, 4, 5, 3, 4]
                    }, {
                        name: 'KBA Stock 2',
                        data: [2, 2, 3, 5, 3, 4, 2, 2, 3]
                    }, {
                        name: 'KBA Stock 1',
                        data: [5, 3, 2, 2, 2, 3, 5, 3, 2]
                    }, {
                        name: 'KBA Central Stock',
                        data: [4, 2, 3, 5, 3, 2, 4, 2, 3]
                    }]
                });
    }
    drawDeviceChart();
