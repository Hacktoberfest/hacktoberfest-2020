window.setupEventMap = function () {
    // data from MLH events parsed out manually - E.D. is a champ.
    var locations = [
        {lat: -9.767623, lng: -52.911903},
        {lat: 28.594217, lng: 77.206051},
        {lat: 30.339781, lng: 76.386879},
        {lat: 42.407970, lng: -77.223793},
        {lat: 20.296059, lng: 85.824539},
        {lat: 51.455040, lng: -0.969090},
        {lat: 52.3804323, lng: 4.860566},
        {lat: 29.8689982, lng: -97.997212},
        {lat: 30.0595581, lng: 31.2233592},
        {lat: 17.4126272, lng: 78.2676197},
        {lat: 28.4230905, lng: 76.919538},
        {lat: 9.9179196, lng: 78.0877185},
        {lat: 25.6081107, lng: 85.1079378},
        {lat: -1.2726586, lng: -48.6006922},
        {lat: 9.6032803, lng: 6.485359},
        {lat: 28.2298557, lng: 83.8864072},
        {lat: -2.8922263, lng: -79.0069325},
        {lat: 14.5965392, lng: 120.9620073},
        {lat: -23.6820347, lng: -46.7357242},
        {lat: 40.4380637, lng: -3.7497476},
        {lat: 40.7153042, lng: -74.1038361},
        {lat: 48.8589101, lng: 2.3119548},
        {lat: 9.0835957, lng: 5.9928921},
        {lat: 22.7241158, lng: 75.7936387},
        {lat: 33.7678357, lng: -84.490815},
        {lat: 50.9577899, lng: 6.8971116},
        {lat: 1.3141707, lng: 103.7740388},
        {lat: 28.4230905, lng: 76.919538},
        {lat: 25.4024021, lng: 81.7313734},
        {lat: 22.6762514, lng: 88.189303},
        {lat: -8.042177, lng: -35.0088466},
        {lat: 28.4230905, lng: 76.919538},
        {lat: 23.1757701, lng: 79.9336477},
        {lat: 25.6081107, lng: 85.1079378},
        {lat: -19.9025411, lng: -44.0342612},
        {lat: -15.7748875, lng: -47.9375144},
        {lat: 19.3910036, lng: -99.2840385},
        {lat: 22.7841037, lng: 86.1406656},
        {lat: 20.3010312, lng: 85.750242},
        {lat: 55.9412514, lng: -3.2404438},
        {lat: -27.6158, lng: -48.6231002},
        {lat: 55.8555366, lng: -4.3026692},
        {lat: 26.448285, lng: 87.236702},
        {lat: 49.4361839, lng: 11.0628265},
        {lat: 16.5719805, lng: 80.3533226},
        {lat: 9.0544966, lng: 7.3241455},
        {lat: 45.5581964, lng: -73.8707268},
        {lat: 22.6762514, lng: 88.189303},
        {lat: 26.6187064, lng: -81.8674031},
        {lat: -22.9137528, lng: -43.5864071},
        {lat: 48.1358735, lng: 17.0457063},
        {lat: 49.2577862, lng: -123.1590091},
        {lat: 38.893709, lng: -77.084787},
        {lat: 9.4267521, lng: -0.8923849},
        {lat: -18.8875029, lng: 47.4423029},
        {lat: 39.0921013, lng: -94.7161443},
        {lat: 48.1550039, lng: 11.471625},
        {lat: 37.5639714, lng: 126.9038753},
        {lat: 0.5236994, lng: 25.17457},
        {lat: -19.9025411, lng: -44.0342612},
        {lat: 45.5428118, lng: -122.7245379},
        {lat: 41.7657461, lng: -72.7151921},
        {lat: -21.4041719, lng: -48.5135392},
        {lat: 5.1167137, lng: 7.3318406},
        {lat: 10.3789257, lng: 123.7760835},
        {lat: -3.5370953, lng: 39.8264247},
        {lat: 32.8247626, lng: -117.2494037},
        {lat: 32.1560359, lng: -110.9540161},
        {lat: 43.7882893, lng: -69.8957294},
        {lat: 59.4717921, lng: 24.5978184},
        {lat: 40.6976633, lng: -74.1201057},
        {lat: 52.0842343, lng: 5.0473864},
        {lat: 25.4624755, lng: 68.2600292},
        {lat: 59.8939224, lng: 10.714906},
        {lat: -25.8961772, lng: 32.5755784},
        {lat: 40.5567676, lng: -105.1378629},
        {lat: 31.4831565, lng: 74.193964},
        {lat: 48.8589101, lng: 2.3119548},
        {lat: 33.3861641, lng: -82.1611285},
        {lat: 1.3141707, lng: 103.7740388},
        {lat: -16.5206271, lng: -68.1591826},
        {lat: 51.2385412, lng: 6.7441395},
        {lat: -35.2812958, lng: 149.1248113},
        {lat: 31.8359749, lng: 35.8072055},
        {lat: 27.9946163, lng: -82.5244916},
        {lat: 34.0206838, lng: -118.5521576},
        {lat: 0.8375067, lng: 103.9126891},
    ];

    var center = new google.maps.LatLng(19.8968, 155.5828);
    var styledMapType = new google.maps.StyledMapType([
            {
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#f5f5f5"
                    }
                ]
            },
            {
                "elementType": "labels.icon",
                "stylers": [
                    {
                        "visibility": "off"
                    }
                ]
            },
            {
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#616161"
                    }
                ]
            },
            {
                "elementType": "labels.text.stroke",
                "stylers": [
                    {
                        "color": "#f5f5f5"
                    }
                ]
            },
            {
                "featureType": "administrative.land_parcel",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#bdbdbd"
                    }
                ]
            },
            {
                "featureType": "poi",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#eeeeee"
                    }
                ]
            },
            {
                "featureType": "poi",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#757575"
                    }
                ]
            },
            {
                "featureType": "poi.park",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#e5e5e5"
                    }
                ]
            },
            {
                "featureType": "poi.park",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#9e9e9e"
                    }
                ]
            },
            {
                "featureType": "road",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#ffffff"
                    }
                ]
            },
            {
                "featureType": "road.arterial",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#757575"
                    }
                ]
            },
            {
                "featureType": "road.highway",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#dadada"
                    }
                ]
            },
            {
                "featureType": "road.highway",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#616161"
                    }
                ]
            },
            {
                "featureType": "road.local",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#9e9e9e"
                    }
                ]
            },
            {
                "featureType": "transit.line",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#e5e5e5"
                    }
                ]
            },
            {
                "featureType": "transit.station",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#eeeeee"
                    }
                ]
            },
            {
                "featureType": "water",
                "elementType": "geometry",
                "stylers": [
                    {
                        "color": "#c9c9c9"
                    }
                ]
            },
            {
                "featureType": "water",
                "elementType": "labels.text.fill",
                "stylers": [
                    {
                        "color": "#9e9e9e"
                    }
                ]
            }
        ],
        {name: 'Map'});

    var map = new google.maps.Map(document.getElementById('eventmap'), {
        zoom: 2,
        center: center,
        // mapTypeId: google.maps.MapTypeId.ROADMAP,
        mapTypeId: "styled_map",
        disableDefaultUI: true
    });

    map.mapTypes.set('styled_map', styledMapType);
    map.setMapTypeId('styled_map');

    var generateMarker = function (location) {
        var latLng = new google.maps.LatLng(location.lat, location.lng);
        var marker = new google.maps.Marker({
            position: latLng,
            icon: "https://prismic-io.s3.amazonaws.com/www-static/2a31a6f0-5d0d-4823-b27e-6d110c411d69_marker.svg",
            map: map,
        });
        return marker;
    }

    locations.map(generateMarker);
};

