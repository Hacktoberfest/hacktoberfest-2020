window.setupPRsOpenedChart = function () {
    var data = [
        {x: new Date(2019, 9, 31), y: 10673},
        {x: new Date(2019, 10, 1), y: 40573},
        {x: new Date(2019, 10, 2), y: 54448},
        {x: new Date(2019, 10, 3), y: 74690},
        {x: new Date(2019, 10, 4), y: 91588},
        {x: new Date(2019, 10, 5), y: 104979},
        {x: new Date(2019, 10, 6), y: 117623},
        {x: new Date(2019, 10, 7), y: 132828},
        {x: new Date(2019, 10, 8), y: 148261},
        {x: new Date(2019, 10, 9), y: 164195},
        {x: new Date(2019, 10, 10), y: 180007},
        {x: new Date(2019, 10, 11), y: 195204},
        {x: new Date(2019, 10, 12), y: 207843},
        {x: new Date(2019, 10, 13), y: 218975},
        {x: new Date(2019, 10, 14), y: 234070},
        {x: new Date(2019, 10, 15), y: 249145},
        {x: new Date(2019, 10, 16), y: 263589},
        {x: new Date(2019, 10, 17), y: 278558},
        {x: new Date(2019, 10, 18), y: 291483},
        {x: new Date(2019, 10, 19), y: 303134},
        {x: new Date(2019, 10, 20), y: 314309},
        {x: new Date(2019, 10, 21), y: 327295},
        {x: new Date(2019, 10, 22), y: 341758},
        {x: new Date(2019, 10, 23), y: 357145},
        {x: new Date(2019, 10, 24), y: 373827},
        {x: new Date(2019, 10, 25), y: 388353},
        {x: new Date(2019, 10, 26), y: 398906},
        {x: new Date(2019, 10, 27), y: 407387},
        {x: new Date(2019, 10, 28), y: 419929},
        {x: new Date(2019, 10, 29), y: 433486},
        {x: new Date(2019, 10, 30), y: 448035},
        {x: new Date(2019, 10, 31), y: 457085}
    ];

    var maxValue = 457085;

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
