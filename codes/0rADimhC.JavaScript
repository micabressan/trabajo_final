            this.getAll = function () {
                var deferred = $q.defer();

                $http.get('/api/site')
                    .success(function (response) {
                        site.sites = response.items;
                        deferred.resolve(response.items);
                    }).error(function (err, status) {
                        deferred.reject(err);
                        $log.error(err, status);
                    });
                return deferred.promise;
            };