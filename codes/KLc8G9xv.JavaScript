 public Filter = () => {
            var searchFilter = this.maps.GetApp().Components.searchbar.GetFilters();
            var iconsFilter = this.maps.GetApp().Components.iconbar.GetFilters();
            var typesMap = new Map<number, number>();
            if (iconsFilter != null) {
                iconsFilter.forEach((v) => {
                    typesMap.set(v.id, v.id);
                });
            }
            var hashMap = new Map<string, string>();
            if (searchFilter != null) {
                searchFilter.hashtags.forEach((v) => {
                    hashMap.set(v.toLowerCase(), v.toLowerCase());
                })
            }
        
            this.markersSettings.markers.forEach((m) => {
                m.setVisible(this.checkIfMarkerHasType(typesMap, m) == true && this.checkIfMarkerHasHashtags(hashMap, m) ==true && this.checkIfMarkerHasTitle(searchFilter,m)==true);
            })
         }