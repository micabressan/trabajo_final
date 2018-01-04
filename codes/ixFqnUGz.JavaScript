$scope.addToTemplates = function () {
        var template = new fabric.Group();
        var objectForRemove = [];

        canvas.fabric
            .getObjects()
            .forEach(function (item) {
                if (item.name !== 'mainImage' && item.name !== 'template' && item.forTemplate) {
                    if (item.type !== 'image' && item.type !== 'path-group') {
                        var clone = item.clone();

                        clone.set({
                            editableObjects: item.editableObjects,
                            forTemplate: item.forTemplate,
                            editInTemplate: item.editInTemplate
                        });

                        template.add(clone);
                    } else {

                        item.clone(function (clone) {
                            clone.set({
                                editableObjects: item.editableObjects,
                                forTemplate: item.forTemplate,
                                editInTemplate: item.editInTemplate
                            });

                            console.log('addToTemplates', clone);


                            template.add(clone);
                        });
                    }
                    objectForRemove.push(item);
                }
            });

        objectForRemove.forEach(function (item) {
            canvas.fabric.remove(item).renderAll();
        });

        $timeout(save);

        function save() {
            template.getObjects().forEach(function (item) {
                if (item.type !== 'image' && item.type !== 'path-group')
                    item.bringToFront();
            });
            console.log('toObject(template)', toObject(template));

            list.$add(toObject(template)).then(function (response) {
                console.log('list.$add', 'success', response);
            }, function (response) {
                console.log('list.$add', 'failed', response);
            });
        }
    };

    function toObject(template) {
        var templatesObjects = [];
        var _template = {};
        var propertiesForRemove = [
            'group', 'oCoords', 'canvas'
        ];

        for (var key in template)
            if (template.hasOwnProperty(key))
                _template[key] = template[key];

        template.getObjects().forEach(function (templateObject) {
            var _templateObject = {};

            for (var key in templateObject)
                if (templateObject.hasOwnProperty(key)) {
                    if (typeof templateObject[key] === 'function') continue;
                    if (key.indexOf('_') !== -1) continue;
                    if (key.indexOf('__') !== -1) continue;
                    if (propertiesForRemove.indexOf(key) !== -1) continue;

                    _templateObject[key] = templateObject[key];
                }

            templatesObjects.push(_templateObject);
        });

        _template.templatesObjects = templatesObjects;

        delete _template._objects;
        delete _template.oCoords;

        return _template;
    }