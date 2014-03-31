var areaStyle = new OpenLayers.Style({
    fillColor: "#00ff00",
    strokeColor: "#029803", //lentostyle
    strokeWidth: 2,
    fontColor: "#333333",
    fontFamily: "sans-serif",
    fontWeight: "bold",
    fillOpacity: "0.05"
});

var projections = {};
projections['SWEREF99TM']={projection: new OpenLayers.Projection("EPSG:3021")};
projections['RT90']={projection: new OpenLayers.Projection("EPSG:900913")};
projections['WGS84']={projection: new OpenLayers.Projection("EPSG:4326")};
//projections['EPSG2393']={projection: new OpenLayers.Projection("EPSG:2393")};
//projections['EPSG3006']={projection: new OpenLayers.Projection("EPSG:4326")};
projections['KKJ3']={projection: new OpenLayers.Projection("EPSG:900913")};
projections['UTM32N']={projection: new OpenLayers.Projection("UTM32N")};
projections['NAD87']={projection:'value'};
var toProjection   = new OpenLayers.Projection("EPSG:900913"); // to Spherical Mercator Projection
//var toProjection   = new OpenLayers.Projection("EPSG:4326"); // to Spherical WGS84 Projection

var toMercator = OpenLayers.Projection.transforms['EPSG:4326']['EPSG:3857'];
var center = toMercator({x:-0.05,y:51.5});

var popup = null;

var resolutionArray =
[
     156543.0339280410,
     78271.51696402048,
     39135.75848201023,
     19567.87924100512,
     9783.939620502561,
     4891.969810251280,
     2445.984905125640,
     1222.992452562820,
     611.4962262814100,
     305.7481131407048,
     152.8740565703525,
     76.43702828517624,
     38.21851414258813,
     19.10925707129406,
     9.554628535647032,
     4.777314267823516,
     2.388657133911758,
     1.194328566955879,
     0.5971642834779395
];

function createAreaJSON(json) {
	var layers = map.getLayersByName("AreasLayer");
	for(var i = 0; i<layers.length; i++) {
		var layer = layers[i];
		layer.destroy();
	}

	if(json == "[]") {
		return;
	}

	var features = [];
	var areas = eval(json);
	for(var i=0; i<areas.length; i++) {
		area = areas[i];
		var areaPoints = [];

//		xCoord = '';
//		yCoord = '';
		for(var j = 0; j<area.areaCoordinates.length; j++) {
//			xCoord = xCoord + area.areaCoordinates[j].x + ", ";
//			yCoord = yCoord + area.areaCoordinates[j].y + ", ";

			point = new OpenLayers.Geometry.Point(area.areaCoordinates[j].y, area.areaCoordinates[j].x);
			point.transform(
				projections[area.areaCoordinates[j].coordinateSystem].projection,
				toProjection // to Spherical Mercator Projection
			);
			areaPoints.push(point);
		}



		var linear_ring = new OpenLayers.Geometry.LinearRing(areaPoints);
		var polygonFeature = new OpenLayers.Feature.Vector(
				new OpenLayers.Geometry.Polygon([linear_ring]),
				null,
				null
		);
		polygonFeature.attributes = {
	             name: area.areaName,
	             closed:''
		};
		features.push(polygonFeature);
	}
	var areaVector =     	new OpenLayers.Layer.Vector(
    		"AreasLayer",
    		{styleMap: new OpenLayers.StyleMap(areaStyle)}
    );
    map.addLayer(areaVector);
    areaVector.addFeatures(features);
    map.setCenter(new OpenLayers.LonLat(7054044,936672), 19);
}

function createTestAreas() {
	createAreaJSON(
			"[" +
			"{\"areaName\":\"Area1\",\"areaCoordinates\":[{\"x\":\"13.31\",\"y\":\"52.52\",\"coordinateSystem\":\"WGS84\"},{\"x\":\"13.51\",\"y\":\"52.62\",\"coordinateSystem\":\"WGS84\"},{\"x\":\"13.41\",\"y\":\"52.52\",\"coordinateSystem\":\"WGS84\"}]}" +
//			"{\"areaName\":\"Sverige\",\"areaCoordinates\":[{\"x\":\"6166984\",\"y\":\"1322751\",\"coordinateSystem\":\"RT90\"},{\"x\":\"6167984\",\"y\":\"1322851\",\"coordinateSystem\":\"RT90\"},{\"x\":\"6167984\",\"y\":\"1322951\",\"coordinateSystem\":\"RT90\"}]}" +
			"]"
	);
}
function createTestPoints() {
	addPoints(
			"[" +
			"{\"id\":\"1\",\"x\":\"13.31\",\"y\":\"52.52\",\"coordinateSystem\":\"WGS84\"}," +
			"{\"id\":\"2\",\"x\":\"13.41\",\"y\":\"52.53\",\"coordinateSystem\":\"WGS84\"}," +
			"{\"id\":\"3\",\"x\":\"13.51\",\"y\":\"52.54\",\"coordinateSystem\":\"WGS84\"}," +
			"{\"id\":\"4\",\"x\":\"13.61\",\"y\":\"52.53\",\"coordinateSystem\":\"WGS84\"}" +
//			"{\"areaName\":\"Sverige\",\"areaCoordinates\":[{\"x\":\"6166984\",\"y\":\"1322751\",\"coordinateSystem\":\"RT90\"},{\"x\":\"6167984\",\"y\":\"1322851\",\"coordinateSystem\":\"RT90\"},{\"x\":\"6167984\",\"y\":\"1322951\",\"coordinateSystem\":\"RT90\"}]}" +
			"]",
			"TestLayer"
	);
}
function createPointsCollection(unselectedImageURL, selectedImageURL) {
	var pointCollection = [];
	pointCollection.unselectedImageURL = unselectedImageURL;
	pointCollection.selectedImageURL = selectedImageURL;
	pointCollection.features = [];
	return pointCollection;
}
function createPointsJSON(json, getPointCollectionFunc, pointCollections) {
	var	boundingBox = [];
	boundingBox.maxX = null;
	boundingBox.maxY = null;
	boundingBox.minX = null;
	boundingBox.minY = null;

	var points = eval(json);
	for(var i=0; i<points.length; i++) {
		var pointObject = points[i];
		point = new OpenLayers.Geometry.Point(pointObject.y, pointObject.x);
		var pointCollection = getPointCollectionFunc(pointObject, pointCollections);
		point.transform(
			projections[pointObject.coordinateSystem].projection,
			toProjection // to Spherical Mercator Projection
		);

		if(boundingBox.minX == null) {
			boundingBox.minX = point.x;
		} else if(boundingBox.minX > point.x) {
			boundingBox.minX = point.x;
		}

		if(boundingBox.minY == null) {
			boundingBox.minY = point.y;
		} else if(boundingBox.minY > point.y) {
			boundingBox.minY = point.y;
		}

		if(boundingBox.maxX == null) {
			boundingBox.maxX = point.x;
		} else if(boundingBox.maxX < point.x) {
			boundingBox.maxX = point.x;
		}

		if(boundingBox.maxY == null) {
			boundingBox.maxY = point.y;
		} else if(boundingBox.maxY > point.y) {
			boundingBox.maxY = point.y;
		}

		vector = new OpenLayers.Feature.Vector(point);
		vector.object_id = pointObject.id;
		vector.object_woid = pointObject.idCase;
		vector.object_wostatus = pointObject.status;
		vector.object_address = pointObject.idWoAddress;
		pointCollection.features.push(vector);
	}
	return boundingBox;
}
function addPoints(json, getPointCollectionFunc, pointCollections, clickCallback, infoDataCallback) {
	if(popup != null) {
		map.removePopup(popup);
		popup.destroy();
		popup = null;
	}

	var controls = map.getControlsByClass("OpenLayers.Control.SelectFeature");
	for(var i = 0; i<controls.length; i++) {
		var control = controls[i];
		control.destroy();
	}

	var layers = map.getLayersByName("PointsLayer");
	for(var i = 0; i<layers.length; i++) {
		var layer = layers[i];
		layer.destroy();
	}

	if(json == "[]" || json == "") {
		return;
	}

	boundingBox = createPointsJSON(json, getPointCollectionFunc, pointCollections);
	var renderer = OpenLayers.Util.getParameters(window.location.href).renderer;
	renderer = (renderer) ? [renderer] : OpenLayers.Layer.Vector.prototype.renderers;
	var pointVectors = [];



	for(var i=0; i<pointCollections.objectlist.length; i++) {
		var pointCollection = pointCollections.objectlist[i];
		var vector =
	    	new OpenLayers.Layer.Vector("PointsLayer", {
	        renderers: renderer,
	        styleMap: new OpenLayers.StyleMap({
	            "default":
	            	new OpenLayers.Style(
	            		OpenLayers.Util.applyDefaults({
	            			externalGraphic: pointCollection.unselectedImageURL,
	            			graphicOpacity: 1,
	            			//rotation: 45,
	            			pointRadius: 10
	            		}, OpenLayers.Feature.Vector.style["default"]),
	            		{
						    rules: [
						        new OpenLayers.Rule({
						            minScaleDenominator: 20000000,
						            symbolizer: {
						                pointRadius: 5,
						                fontSize: "9px"
						            }
						        }),
						        new OpenLayers.Rule({
						            maxScaleDenominator: 20000000,
						            minScaleDenominator: 10000000,
						            symbolizer: {
						                pointRadius: 8,
						                fontSize: "12px"
						            }
						        }),
						        new OpenLayers.Rule({
						        	maxScaleDenominator: 10000000,
						            minScaleDenominator: 1000000,
						            symbolizer: {
						                pointRadius: 9,
						                fontSize: "15px"
						            }
						        }),
						        new OpenLayers.Rule({
						            maxScaleDenominator: 1000000,
						            symbolizer: {
						                pointRadius: 10,
						                fontSize: "15px"
						            }
						        })
						    ]
						}
	            	),
	            "select": new OpenLayers.Style({
	                externalGraphic: pointCollection.selectedImageURL
	            })
	        })
	    });
		map.addLayer(vector);
		pointVectors.push(vector);
		vector.addFeatures(pointCollection.features);
	}

	selectControlClick = new OpenLayers.Control.SelectFeature(
	    		pointVectors,
	           {
	               clickout: true,
	               toggle: false,
	               multiple: false,
	               hover: false,
	               toggleKey: "ctrlKey", // ctrl key removes from selection
	               multipleKey: "shiftKey" // shift key adds to selection
	           	  , eventListeners: {
	            	  featurehighlighted: function(e) {
	            		  clickCallback(e.feature.object_id);
				      },
				      featureunhighlighted: function(e) {
				    	  removePopup();
				    	  clickCallback(null);
				      }
	               }
	           }
	    );

		function removePopup() {
			if(popup != null) {
				map.removePopup(popup);
				popup.destroy();
				popup = null;
			}
		}


	    selectControlHover = new OpenLayers.Control.SelectFeature(
	    		pointVectors,
	           {
	               hover: true,
	               highlightOnly: true,
	               renderIntent: "frick",
	               eventListeners: {
	                   // beforefeaturehighlighted: ,
	                    featurehighlighted: function(e) {
	                    	var feature = e.feature;
	                    	removePopup();
	                    	var pix = map.getPixelFromLonLat(OpenLayers.LonLat.fromString(feature.geometry.toShortString()));
	                    	var newpix = pix.add(-10,10);
	                    	/* popup = new OpenLayers.Popup.FramedCloud("popup",
	                    			OpenLayers.LonLat.fromString(feature.geometry.toShortString()),
	                                null,
	                                infoDataCallback(feature.object_id),
	                                null,
	                                true
	                            );*/
	                    	var anchor = {'size': new OpenLayers.Size(0,0), 'offset': new OpenLayers.Pixel(-5,5)};

	                    	popup = new OpenLayers.Popup.FramedCloud("popup",
	                    		OpenLayers.LonLat.fromString(feature.geometry.toShortString()),
	                    		//map.getLonLatFromPixel(newpix),
                                null,
                                infoDataCallback(feature.object_id, feature.object_woid,feature.object_wostatus,feature.object_address),
                                //null,
                                anchor,
                                false
                            );
	                    	popup.autoSize=true;
	                    	popup.calculateRelativePosition = function () {
	                    	    return 'bl';
	                    	};

	                    	feature.popup = popup;
                            map.addPopup(popup);

	                    },
	                    featureunhighlighted: function(e) {
	                    	var feature = e.feature;
	                    	removePopup();
	                   }
	                }
	           }
	    );
	    map.addControl(selectControlHover);
	    selectControlHover.activate();


	    map.addControl(selectControlClick);
	    selectControlClick.activate();


	    var positionX = boundingBox.minX + (boundingBox.maxX - boundingBox.minX) /2;
	    var positionY = boundingBox.minY + (boundingBox.maxY - boundingBox.minY) /2;
	    var zoom           = 10;
	    var xResolution = (boundingBox.maxX - boundingBox.minX) / document.getElementById("map-wrapper").offsetWidth;
	    var yResolution =  (boundingBox.maxY - boundingBox.minY) / document.getElementById("map-wrapper").offsetHeight
	    var resolution = Math.max(xResolution, yResolution);

	    var scale = 10;
	    for(var i = 0; i<resolutionArray.length; i++) {
	    	if(i == resolutionArray.length -1) {
	    		scale = resolutionArray.length -1;
	    		break;
	    	}
	    	if(resolution > resolutionArray[i]) {
	    		if(i == 0) {
	    			scale = 0;
	    		} else if (i == 1) {
	    			scale = 0;
	    		} else {
	    			scale = i -2;
	    		}
	    		break;
	    	}
	    }


	    map.setCenter( new OpenLayers.LonLat(positionX, positionY), scale);
}

function init(mapServerURL) {
	var mapUrl = "http://portal.skvader.com/mapcache";
	if(mapServerURL!=null&&mapServerURL!='') {
		mapUrl = mapServerURL;
	}
	map = new OpenLayers.Map(
		"map-wrapper",
		{
			//controls: [new OpenLayers.Control.Attribution()],
			resolutions: resolutionArray,
			projection: "EPSG:900913"

		}
	);
	//map.projection = "EPSG:900913";
//  var mapLayer       = new OpenLayers.Layer.OSM();
//	var mapLayer = new OpenLayers.Layer.WMS(
//			"OpenLayers WMS",
//            "http://vmap0.tiles.osgeo.org/wms/vmap0",
//            {layers: 'basic'}
//	);
	//map.projection = toProjection;

	var options = {
		layers: 'cache'//,
		//srs: "EPSG:900913",
		//projection: "EPSG:900913"
	};

	var mapLayer = new OpenLayers.Layer.WMS(
			"Öystein WMS Cache",
			mapUrl,
			//"http://stargate.corp.capgemini.com/mapcache",
            options,
            {
				transitionEffect: "resize"//,
				,attribution: "&copy; <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> contributors"
            }
	);

//	var mapLayer = new OpenLayers.Layer.MapServer(
//			"Öystein MapServer",
//            "http://macgyver/cgi-bin/mapserv?map=/home/ok/osm-demo/mapserver-utils/osm-google.map",
//            {layers: 'all'}
//	);



//    var mapLayer = new OpenLayers.Layer.MapServer( "MapServer Layer",
//            "http://macgyver/cgi-bin/mapserv?map=/home/ok/osm-demo/mapserver-utils/osm-google.map&",
//            {layers: 'land0 borders0 places0 land1 borders1 places1 land2 borders2 places2 land3 borders3 places3 land4 landuse4 waterarea4 borders4 places4 land5 landuse5 waterarea5 roads5 borders5 places5 land6 landuse6 waterarea6 waterways6 roads6 borders6 places6 land7 landuse7 waterarea7 waterways7 roads7 borders7 places7 land8 landuse8 waterarea8 waterways8 railways8 roads8 borders8 places8 land9 landuse9 waterarea9 waterways9 railways9 roads9 borders9 places9 land10 landuse10 waterarea10 waterways10 railways10 roads10 aeroways10 borders10 places10 land11 landuse11 transport_areas11 waterarea11 waterways11 railways11 roads11 aeroways11 borders11 places11 land12 landuse12 transport_areas12 waterarea12 waterways12 railways12 roads12 aeroways12 borders12 places12 land13 landuse13 transport_areas13 waterarea13 waterways13 railways13 roads13 aeroways13 borders13 places13 land14 landuse14 transport_areas14 waterarea14 waterways14 railways14 roads14 aeroways14 borders14 places14 land15 landuse15 transport_areas15 waterarea15 waterways15 railways15 roads15 aeroways15 borders15 places15 land16 landuse16 transport_areas16 waterarea16 waterways16 railways16 roads16 aeroways16 borders16 places16 land17 landuse17 transport_areas17 waterarea17 waterways17 railways17 roads17 aeroways17 borders17 places17 land18 landuse18 transport_areas18 waterarea18 waterways18 railways18 roads18 aeroways18 borders18 places18'},
//            {singleTile: "true", ratio:1} );


//	var mapLayer = new OpenLayers.Layer.WMS(
//			"OpenLayers WMS",
//			 "http://macgyver/cgi-bin/mapserv?map=/home/ok/osm-demo/mapserver-utils/osm-google.map",
//            {layers: 'all'}
//	);
    var fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984

    //X: 9098493,5 Y: 1962764
   // var position       = new OpenLayers.LonLat(13.41,52.52).transform(fromProjection, toProjection);
    map.addLayer(mapLayer);
    map.setCenter(new OpenLayers.LonLat(1962764, 9098493), 4);
    //DEBUG
   // map.addControl(new OpenLayers.Control.MousePosition());
//    map.addControl(new OpenLayers.Control.LayerSwitcher());
//    map.addControl(new OpenLayers.Control.Attribution());
  }

function initmap(mapServerURL) {
	var mapUrl = "http://portal.skvader.com/mapcache";
	if(mapServerURL!=null&&mapServerURL!='') {
		mapUrl = mapServerURL;
	}
	map = new OpenLayers.Map(
		"map-wrapper",
		{
			//controls: [new OpenLayers.Control.Attribution()],
			resolutions: resolutionArray,
			projection: "EPSG:900913"

		}
	);

	var options = {
		layers: 'cache'//,

	};

	var mapLayer = new OpenLayers.Layer.WMS(
			"Öystein WMS Cache",
			mapUrl,
			//"http://stargate.corp.capgemini.com/mapcache",
            options,
            {
				transitionEffect: "resize"//,
				,attribution: "&copy; <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> contributors"
				//opacity: .9
            }
	);

    var fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984


    map.addLayer(mapLayer);
    map.setCenter(new OpenLayers.LonLat(1962764, 9098493), 4);

    //Meilan added this for testing.
    //filter_submit();
}



function loadMapPoint(mapServerUrl, mapElementID, xcoord, ycoord) {
	var mapUrl = "http://portal.skvader.com/mapcache";

	// Img Path
	var imgPath = contextPath + "/images/marker-icon-blue.png";

	if(mapServerUrl!=null&&mapServerUrl!='') {
		mapUrl = mapServerUrl;
	}
	map = new OpenLayers.Map(
			mapElementID,
		{
			resolutions: resolutionArray,
			numZoomLevels: 19,
			projection: "EPSG:900913"
		}
	);
	var options = {
		layers: 'cache'
	};

	var mapLayer = new OpenLayers.Layer.WMS(
			"Öystein WMS Cache",
			mapUrl,
            options,
            {
				transitionEffect: "resize"
				,attribution: "&copy; <a href='http://www.openstreetmap.org/copyright'>OpenStreetMap</a> contributors"
            }
	);
	// Vector Layer
	var vectorLayer = new OpenLayers.Layer.Vector("Overlay");
	var point = new OpenLayers.Geometry.Point(ycoord, xcoord);

	var feature = new OpenLayers.Feature.Vector(point, {
		some : 'data'},
		{
		externalGraphic : imgPath,
		graphicHeight : 38,
		graphicWidth : 26
		},
	    {
		strategies : [ new OpenLayers.Strategy.BBOX(),
				new OpenLayers.Strategy.Save() ]
	});
	vectorLayer.addFeatures(feature);
    var position = new OpenLayers.LonLat(point.x,point.y);
    map.addLayers( [ mapLayer, vectorLayer ]);
    map.setCenter(position, 14);
  }