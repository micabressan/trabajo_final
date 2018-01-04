$scope.getTemplates = function() {
        $rootScope.templates = [];
        
        var list = $firebaseArray(ref);

        list.$loaded()
            .then(function(list) {
                list.forEach(function (item) {
                    var group = new fabric.Group();

                    group.set(item);

                    item.templatesObjects.forEach(function (item) {
                        var object;

                        switch (item.type) {
                            case 'i-text': {
                                object = new fabric.IText('');
                            } break;
                            case 'rect': {
                                object = new fabric.Rect();
                            } break;
                            case 'circle': {
                                object = new fabric.Circle();
                            } break;
                            case 'triangle': {
                                object = new fabric.Triangle();
                            } break;
                            case 'image': {
                                object = new fabric.Image(item.src);
                            } break;
                        }

                        object.set(item);
                        group.add(object);
                    });

                    $rootScope.templates.push(group);
                });
            })
            .catch(function(error) {
                console.log("Error:", error);
            });
    };