 var vm = this;
            vm.currentPage = 0;
            vm.status = 'ALL';
            vm.dir = 'ASC';
            vm.type = 'page';
            vm.rpp = 10;
            vm.searchParams = {};
            vm.params = {
                name        : '',
                author      : '',
                keyword     : '',
                min_ch      : 0,
                max_ch      : 400,
                tags_add    : '',
                tags_remove : '',
                status      : ''
            };
            vm.search = search;
            vm.orderBy = 'name';
            vm.isAdv = false;
            vm.toggleAdv = toggleAdv;
            vm.genres = fictionGenres;
            vm.includedGenres = [];
            vm.isIncluded = isIncluded;
            vm.excludedGenres = [];
            vm.isExcluded = isExcluded;
            vm.toggleGenre = toggleGenre;
            vm.additionalTags = {};
            vm.showAddTags = false;
            vm.toggleAddTags = toggleAddTags;
            vm.showMature = vm.isExcluded('mature')? false : true;
            vm.showFanfic = vm.isExcluded('fanfic')? false : true;
            vm.toggleOptional = toggleOptional;
            vm.chapterRange = {
                min     : 0,
                max     : 400,
                floor   : 0,
                ceil    : 400
            };
            vm.orderOptions = [
                {
                    label   : 'Title',
                    value   : 'name'
                },
                {
                    label   : 'Chapters',
                    value   : 'chapters'
                },
                {
                    label   : 'Last Updated',
                    value   : 'last_update'
                },
                {
                    label   : 'Popularity',
                    value   : 'popularity'
                },
                {
                    label   : 'Status',
                    value   : 'status'
                },
                {
                    label   : 'Followers',
                    value   : 'follows'
                },
                {
                    label   : 'Favorites',
                    value   : 'favorites'
                }
            ];

            fictionFactory.getAddTags()
                .then(function(data){
                    vm.additionalTags = data;
                });

            $scope.$on('$locationChangeSuccess', function(){
                processParams();
            });
            if($state.is('search.params')){
                processParams();
            }
            function processParams(){
                console.log(!!$location.url().split('/search/')[1]);
                if(!!$location.url().split('/search/')[1]){
                    var par = decodeURIComponent($location.url()).split('/search/')[1].split('/');
                    console.log(par);
                    for (var i = 0; i <= par.length; i += 2) {
                        if (par[i] == 'rpp') vm.rpp = par[i + 1];
                        if (par[i] == 'order_by') vm.orderBy = par[i + 1];
                        if (par[i] == 'name') vm.searchParams.name = par[i + 1];
                        if (par[i] == 'page') vm.currentPage = par[i + 1] - 1;
                        if (par[i] == 'dir') vm.dir = par[i + 1];
                        if (par[i] == 'min_ch') vm.chapterRange.min = par[i + 1];
                        if (par[i] == 'max_ch') vm.chapterRange.max = par[i + 1];
                        if (par[i] == 'tags_add') vm.includedGenres = par[i + 1].split(',');
                        if (par[i] == 'tags_remove') vm.excludedGenres = par[i + 1].split(',');
                        if (par[i] == 'author') vm.searchParams.author = par[i + 1];
                        if (par[i] == 'keyword') vm.searchParams.keyword = par[i + 1];
                        if (par[i] == 'status') vm.status = par[i + 1];
                        if (['min_ch', 'max_ch', 'tags_add', 'tags_remove', 'author', 'keyword', 'name', 'status'].indexOf(par[i]) > -1) {
                            vm.type = 'search';
                            if (par[i] != 'name') vm.isAdv = true;
                            vm.params[par[i]] = par[i + 1];
                        }
                    }
                }else{
                    vm.params = {
                        name        : '',
                        author      : '',
                        keyword     : '',
                        min_ch      : 0,
                        max_ch      : 400,
                        tags_add    : '',
                        tags_remove : '',
                        status      : ''
                    };
                }
                vm.showMature = vm.isExcluded('mature')? false : true;
                vm.showFanfic = vm.isExcluded('fanfic')? false : true;
            }

            function serializeParams (){
                var url = "/";
                angular.forEach(vm.searchParams,function(val, key){
                   url += (!!val)? key + "/" + val + "/" : "";
                    vm.type = (!!val)? 'search' : 'page';
                });
                url += (vm.chapterRange.min > 0) ? "min_ch/" + vm.chapterRange.min + "/" : "";
                url += (vm.chapterRange.max < 400) ? "max_ch/" + vm.chapterRange.max + "/" : "";
                url += (vm.includedGenres.length > 0)? "tags_add/" + vm.includedGenres.join(',') + "/" : "";
                url += (vm.excludedGenres.length > 0)? "tags_remove/" + vm.excludedGenres.join(',') + "/" : "";
                url += (vm.orderBy != 'name') ? "order_by/" + ((vm.orderBy == "")? 'popularity' : vm.orderBy) + "/" : "";
                url += (vm.rpp != 10)? "rpp/" + vm.rpp + "/" : "";
                url += (vm.dir != "ASC") ? "dir/" + vm.dir + "/" : "";
                url += (vm.currentPage != 0) ? "page/" + (vm.currentPage + 1) + "/" : "";
                url += (vm.status != 'ALL') ? "status/" + vm.status + "/" : "";
                return url;
            }

            function isIncluded(name){
                return vm.includedGenres.indexOf(name) != -1;
            }

            function search(){
                var params = serializeParams();
                $location.url('/search' + params);
            }

            function isExcluded(name){
                return vm.excludedGenres.indexOf(name) != -1;
            }

            function toggleAddTags(){
                vm.showAddTags = !vm.showAddTags;
            }

            function toggleOptional(name, value){
                if(value){
                    vm.excludedGenres.splice(vm.excludedGenres.indexOf(name), 1);
                }else{
                    vm.excludedGenres.push(name);
                }
            }

            function toggleGenre(name){
                if(isIncluded(name)){
                    vm.includedGenres.splice(vm.includedGenres.indexOf(name), 1);
                    vm.excludedGenres.push(name);
                }else if(isExcluded(name)){
                    vm.excludedGenres.splice(vm.excludedGenres.indexOf(name), 1);
                }else{
                    vm.includedGenres.push(name);
                }
                serializeParams();
            }

            function toggleAdv(){
                vm.isAdv = !vm.isAdv;
                vm.type = (vm.type == 'page')? 'search' : 'page';
            }