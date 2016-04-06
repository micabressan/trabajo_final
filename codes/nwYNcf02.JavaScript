function onEachFeature(feature, layer) {
            layer.bindPopup(feature.properties.popupContent);
            (function(layer, properties) {
              layer.on("mouseover", function (e) {
                layer.openPopup();
              });
              layer.on("mouseout", function (e) {
                layer.closePopup();
              });
              layer.on("click", function (e) {
                doPopup(properties);
                var zmlvl = map.getZoom();
                if (zmlvl == 15) {
                    var setZoom = zmlvl + 3;
                } else {
                    var setZoom = zmlvl;
                }
                setTimeout(function(){
                    map.setView(layer.getLatLng(), setZoom);
                }, 1500
                );
              });
            })(layer, feature.properties);
        }