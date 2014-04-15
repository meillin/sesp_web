$(function () {
	Highcharts.setOptions({
	//Green - #1abc9c //Blue - #428bca // Orange - #f0ad4e // Red - #d9534f //
     colors: ['#1abc9c', '#428bca', '#d9534f', '#f0ad4e', '#5bc0de', '#1d2939']
    });

	function drawHalfGaugeChart(divId, height){
		$( '#'+divId ).highcharts({

		  chart: {
		      type: 'gauge',
		      plotBackgroundColor: null,
		      plotBackgroundImage: null,
		      plotBorderWidth: 0,
		      plotShadow: false,
		      height: height
		  },

		  title: {
		      text: 'CPU',
     			style: {
                fontWeight: 'bold',
                color: '#000'
          }
		  },

		  pane: {
		      startAngle: -90,
		      endAngle: 90,
		      background: [{
		          backgroundColor: 'transparent',
		          borderWidth: 0,
		          outerRadius: '50%',
		          innerRadius: '50%'
		      }]
		  },

		  // the value axis
		  yAxis: {
		      min: 0,
		      max: 100,

		      minorTickInterval: 'auto',
		      minorTickWidth: 0,
		      minorTickLength: 10,
		      minorTickPosition: 'inside',
		      minorTickColor: '#f0f0f0',

		      tickPixelInterval: 30,
		      tickWidth: 0,
		      tickPosition: 'inside',
		      tickLength: 30,
		      tickColor: '#f0f0f0',
		      labels: {
		          step: 10,
		          rotation: 'auto',
		          enabled: true
		      },
		      title: {
		          text: ''
		      },
		      plotBands: [{
					from: 0,
					to: 30,
					innerRadius: '85%',
					outerRadius: '135%',
					color: '#1abc9c' // green
		      }, {
					from: 30,
					to: 70,
					innerRadius: '85%',
					outerRadius: '135%',
					color: '#f0ad4e' // yellow
		      }, {
					from: 70,
					to: 100,
					innerRadius: '85%',
					outerRadius: '135%',
					color: '#d9534f' // red
		      }]
		  },

		  series: [{
		      name: '',
		      data: [80],
				dataLabels: {
				formatter: function () {
				return '<span style="color:#000"> '+this.y+' %</span>';
				}
			},
		      tooltip: {
		          valueSuffix: '%'
		      }
		  }]
			},
		// Add some life
		function (chart) {
			if (!chart.renderer.forExport) {
			    setInterval(function () {
			        var point = chart.series[0].points[0],
			            newVal,
			            inc = Math.round((Math.random() - 0.5) * 20);

			        newVal = point.y + inc;
			        if (newVal < 0 || newVal > 100) {
			            newVal = point.y - inc;
			        }

			        point.update(newVal);

			    }, 3000);
			}
		});
	}
	function drawStackedColumnChart(divId, height, title){
		        $( '#'+divId ).highcharts({
            chart: {
                type: 'column',
                height: height
            },
            title: {
                text: title,
                style: {
                      fontWeight: 'bold',
                      color: '#000'
                }
            },
            xAxis: {
                categories: ['Import server #1', 'Import server #2']
            },
            yAxis: {
            		title: '',
                min: 0,
                gridLineWidth: 0,
                labels: {
                    enabled: false
                },
                stackLabels: {
                    enabled: true,
                    style: {
                        color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                    }
                }
            },
            legend: {
                align: 'center',
                verticalAlign: 'bottom',
                y: 10,
                backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColorSolid) || 'white',
                borderWidth: 0,
                shadow: false
            },
            tooltip: {
                formatter: function() {
                    return '<b>'+ this.x +'</b><br/>'+
                        this.series.name +': '+ this.y +'<br/>'+
                        'Total: '+ this.point.stackTotal;
                }
            },
            plotOptions: {
                column: {
                    stacking: 'normal',
                    dataLabels: {
                        enabled: true,
                        color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
                        style: {
                            //textShadow: '0 0 3px black, 0 0 3px black'
                        }
                    }
                }
            },
            series: [{
                name: 'In progress',
                data: [3, 3]
            }, {
                name: 'Scheduled',
                data: [1, 2]
            }, {
                name: 'Waiting',
                data: [3, 4]
            }]
		});
	}
	function drawDonutChart(divId, data, title) {
    	// Build the chart
        $('#' + divId ).highcharts({
            chart: {
                plotBackgroundColor: null,
                plotBorderWidth: null,
                plotShadow: false,
                height: 220
            },
            legend: {
	            layout: 'vertical',
	            backgroundColor: '#FFFFFF',
	            align: 'right',
	            verticalAlign: 'top',
	            floating: true,
	            x: 0,
	            y: 60,
	            padding: 0,
	            borderWidth: 0
	        	},
            title: {
                text: title,
                style: {
					fontWeight: 'bold',
					color: '#000'
                }
            },
            tooltip: {
        	    pointFormat: '<b>{point.percentage:.1f}%</b>'
            },
            plotOptions: {
                pie: {
                    allowPointSelect: true,
                    cursor: 'pointer',
                    dataLabels: {
                        enabled: false
                    },
                    showInLegend: true,
                    center: ['20%', '50%']

                }
            },
            series: [{
                type: 'pie',
                name: '',
                innerSize: '50%',
                data: data
            }]
        });
	}
	function drawStackedBarChart(divId, title, data, cat, boo) {
		$('#' + divId).highcharts({
			chart: {
			      type: 'bar',
			      height: 200
			  },
			title: {
			    text: title,
         	style: {
                fontWeight: 'bold',
                color: '#000'
          }
			},
			xAxis: {
					title: '',
			    categories: cat
			},
			yAxis: {
				title: ''
			},
			legend: {
			    backgroundColor: '#FFFFFF',
			    borderWidth:0,
			    enabled: boo
			},
			plotOptions: {
			    series: {
			        stacking: 'normal'
			    }
			},
			series: data,
		});
	}

	var userCat = ['Users'];
	var errorCat = ['Warning', 'Medium', 'Severe', 'Fatal'];
	var userData = [
									{
										name: 'Total users in system',
										data: [70]
									},{
										name: 'Total locked users in system',
										data: [15]
									}
								];
	//Green - #1abc9c //Blue - #428bca // Orange - #f0ad4e // Red -#d9534f //
	var errorData = [{data : [{y:50,color:'#1abc9c'}, {y:30,color:'#428bca'}, {y:20,color:'#f0ad4e'}, {y:10,color:'#d9534f'}]}];

	var messageData = [
			                ['Import ready',   45.0],
			                ['Import error',       26.8],
			                ['Import error ignored', 12.8],
			            	];
	var fileData = [
	                ['Manual Import parsed',   45.0],
	                ['Import parsed',       26.8],
	                ['Import started', 12.8],
	                ['Import error ignored',    8.5],
	                ['Manual import error',     6.2],
	                ['Import message error',   0.4],
	                ['Import parse error', 0.3]
	            	];
	drawHalfGaugeChart('import-servers', 150);
	drawHalfGaugeChart('export-servers', 150);
	drawHalfGaugeChart('transaction-servers', 150);
	drawStackedColumnChart('import-servers-threads', 170, 'Import threads');
	drawStackedColumnChart('export-servers-threads', 170, 'Export threads');
	drawDonutChart('import-files', fileData, 'File');
	drawDonutChart('export-files', fileData, 'File');
	drawDonutChart('import-messages', messageData, 'Message');
	drawDonutChart('export-messages', messageData, 'Message');
	drawStackedBarChart('users-system-chart', 'Users in system', userData, userCat, true);
	drawStackedBarChart('users-authentifications-chart', 'Authentifications today', userData, userCat, true);
	drawStackedBarChart('errors', ' ', errorData, errorCat, false);

});