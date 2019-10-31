window.setupPRsOpenedChart = function () {
    var data = [
        {x: new Date(2019, 09, 30), y: 10673},
        {x: new Date(2019, 10, 01), y: 29900},
        {x: new Date(2019, 10, 02), y: 24548},
        {x: new Date(2019, 10, 03), y: 20242},
        {x: new Date(2019, 10, 04), y: 16898},
        {x: new Date(2019, 10, 05), y: 13391},
        {x: new Date(2019, 10, 06), y: 12644},
        {x: new Date(2019, 10, 07), y: 15205},
        {x: new Date(2019, 10, 08), y: 15433},
        {x: new Date(2019, 10, 09), y: 15934},
        {x: new Date(2019, 10, 10), y: 15812},
        {x: new Date(2019, 10, 11), y: 15197},
        {x: new Date(2019, 10, 12), y: 12639},
        {x: new Date(2019, 10, 13), y: 11132},
        {x: new Date(2019, 10, 14), y: 15095},
        {x: new Date(2019, 10, 15), y: 15075},
        {x: new Date(2019, 10, 16), y: 14444},
        {x: new Date(2019, 10, 17), y: 14969},
        {x: new Date(2019, 10, 18), y: 12925},
        {x: new Date(2019, 10, 19), y: 11651},
        {x: new Date(2019, 10, 20), y: 11175},
        {x: new Date(2019, 10, 21), y: 12986},
        {x: new Date(2019, 10, 22), y: 14463},
        {x: new Date(2019, 10, 23), y: 15387},
        {x: new Date(2019, 10, 24), y: 16682},
        {x: new Date(2019, 10, 25), y: 14526},
        {x: new Date(2019, 10, 26), y: 10553},
        {x: new Date(2019, 10, 27), y: 8481},
        {x: new Date(2019, 10, 28), y: 12542},
        {x: new Date(2019, 10, 29), y: 13557},
        {x: new Date(2019, 10, 30), y: 14549},
        {x: new Date(2019, 10, 31), y: 9050}
    ];

    var maxValue = 29900;

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
