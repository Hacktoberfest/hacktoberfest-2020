window.setupPRsOpenedChart = function () {
    var data = [
      {x: new Date(2019, 8, 30), y: 10693},
      {x: new Date(2019, 9, 1), y: 40617},
      {x: new Date(2019, 9, 2), y: 65207},
      {x: new Date(2019, 9, 3), y: 85467},
      {x: new Date(2019, 9, 4), y: 102392},
      {x: new Date(2019, 9, 5), y: 115797},
      {x: new Date(2019, 9, 6), y: 128450},
      {x: new Date(2019, 9, 7), y: 143669},
      {x: new Date(2019, 9, 8), y: 159123},
      {x: new Date(2019, 9, 9), y: 175086},
      {x: new Date(2019, 9, 10), y: 190917},
      {x: new Date(2019, 9, 11), y: 206130},
      {x: new Date(2019, 9, 12), y: 218781},
      {x: new Date(2019, 9, 13), y: 229928},
      {x: new Date(2019, 9, 14), y: 245036},
      {x: new Date(2019, 9, 15), y: 260126},
      {x: new Date(2019, 9, 16), y: 274596},
      {x: new Date(2019, 9, 17), y: 289585},
      {x: new Date(2019, 9, 18), y: 302536},
      {x: new Date(2019, 9, 19), y: 314206},
      {x: new Date(2019, 9, 20), y: 325395},
      {x: new Date(2019, 9, 21), y: 338409},
      {x: new Date(2019, 9, 22), y: 352890},
      {x: new Date(2019, 9, 23), y: 368316},
      {x: new Date(2019, 9, 24), y: 385029},
      {x: new Date(2019, 9, 25), y: 399583},
      {x: new Date(2019, 9, 26), y: 410150},
      {x: new Date(2019, 9, 27), y: 418652},
      {x: new Date(2019, 9, 28), y: 431227},
      {x: new Date(2019, 9, 29), y: 444830},
      {x: new Date(2019, 9, 30), y: 459462},
      {x: new Date(2019, 9, 31), y: 477308},
      {x: new Date(2019, 10, 1), y: 482182}
    ];

    var maxValue = 482182;

    var pink = '#ff00aa';
    var text = '#c3cce2';
    var lightGrey = '#37476F';
    var darkGrey = '#1d2c4e';

    var chart = new CanvasJS.Chart('prsOpenedChart', {
        backgroundColor: 'transparent',
        axisX: {
            gridThickness: 0,
            lineThickness: 0,
            tickThickness: 0,
            labelFormatter: function () {
                return '';
            }
        },
        axisY: {
            minimum: 0,
            maximum: maxValue * 1.1,
            interval: maxValue / 5,
            valueFormatString: '#,###,###,###',
            gridColor: lightGrey,
            gridThickness: 2,
            lineThickness: 0,
            tickThickness: 0,
            labelFontColor: lightGrey,
            labelFontWeight: 'bold',
            labelFontFamily: 'monospace'
        },
        toolTip: {
            borderThickness: 3,
            backgroundColor: darkGrey,
            fontColor: text,
            fontStyle: 'normal',
            fontFamily: 'Space Mono, monospace'
        },
        data: [
            {
                type: 'spline',
                toolTipContent: '{y} PRs',
                markerSize: 10,
                markerColor: darkGrey,
                markerBorderColor: pink,
                markerBorderThickness: 3,
                highlightEnabled: false,
                color: pink,
                lineThickness: 3,
                dataPoints: data
            }
        ],
        creditColor: lightGrey
    });

    chart.render();
    document.querySelector('.canvasjs-chart-credit').style.color = lightGrey;
    document.querySelector('.canvasjs-chart-credit').style.fontFamily = '';
};
