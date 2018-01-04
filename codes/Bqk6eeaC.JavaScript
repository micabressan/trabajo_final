var config = {
			type: "line",
			data: {
				labels: [ 
					"01.01.2017 00:00",
					"02.01.2017 00:00",
					"03.01.2017 00:00"
				],
				datasets: [{
					label: "Dataset with point data",
					backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
					borderColor: window.chartColors.green,
					fill: false,
					data: [{
						x: "01.01.2017 00:00",
						y: 20
					}, {
						x: "02.01.2017 00:00",
						y: 25
					}, {
						x: "03.01.2017 00:00",
						y: 20
					}],
				}]
			},
			options: {
                title:{
                    text: "Chart.js Time Scale"
                },
				scales: {
					xAxes: [{
						type: "time",
						time: {
							parser: "DD.MM.YYYY HH:mm",
							tooltipFormat: "DD.MM.YYYY HH:mm",
							displayFormats: {
								second: "HH:mm:ss"
							}
						},
						scaleLabel: {
							display: true,
							labelString: "Date"
						}
					}, ],
					yAxes: [{
						scaleLabel: {
							display: true,
							labelString: "value"
						}
					}]
				},
			}
		};