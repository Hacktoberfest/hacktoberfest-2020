window.setupPRsOpenedChart = function () {
    var data = [
        {x: new Date(2012, 0, 1), y: 50},
        {x: new Date(2012, 1, 1), y: 225},
        {x: new Date(2012, 2, 1), y: 135},
        {x: new Date(2012, 3, 1), y: 200},
        {x: new Date(2012, 4, 1), y: 450},
        {x: new Date(2012, 5, 1), y: 325},
        {x: new Date(2012, 6, 1), y: 480},
        {x: new Date(2012, 7, 1), y: 480},
        {x: new Date(2012, 8, 1), y: 775},
        {x: new Date(2012, 9, 1), y: 600},
        {x: new Date(2012, 10, 1), y: 675},
        {x: new Date(2012, 11, 1), y: 915},
        {x: new Date(2012, 12, 1), y: 800}
    ];

    var maxValue = 915;

    var pink = "#ff00aa";
    var text = "#c3cce2";
    var lightGrey = "#37476F";
    var darkGrey = "#1d2c4e";

    var chart = new CanvasJS.Chart("prsOpenedChart", {
        backgroundColor: "transparent",
        axisX: {
            gridThickness: 0,
            lineThickness: 0,
            tickThickness: 0,
            labelFormatter: function () {
                return "";
            }
        },
        axisY: {
            minimum: 0,
            maximum: maxValue * 1.1,
            interval: maxValue / 5,
            valueFormatString: "#,###,###,###",
            gridColor: lightGrey,
            gridThickness: 2,
            lineThickness: 0,
            tickThickness: 0,
            labelFontColor: lightGrey,
            labelFontWeight: "bold",
            labelFontFamily: "sans-serif"
        },
        toolTip: {
            borderThickness: 3,
            backgroundColor: darkGrey,
            fontColor: text,
            fontStyle: "normal",
            fontFamily: "sans-serif"
        },
        data: [
            {
                type: "spline",
                toolTipContent: "{y} PRs",
                markerSize: 10,
                markerColor: darkGrey,
                markerBorderColor: pink,
                markerBorderThickness: 3,
                highlightEnabled: false,
                color: pink,
                lineThickness: 3,
                dataPoints: data
            }
        ]
    });

    chart.render();
};
