var url = 'http://localhost:8080/';

var app = angular.module('myApp', ['ngResource', 'ui.grid', 'ngTouch', 'ngRoute']);

//Factories
app.factory('TeamFactory', function ($resource) {
    return $resource(url + 'druzyny/:id', {id: '@id'}, {
        'update': {method: 'PUT'}
    });
});
app.factory('Factory', function ($resource) {
    return $resource(url + '/:id', {id: '@id'}, {});
});

app.factory('PlayerFactory', function ($resource) {
    return $resource(url + 'pilkarze/:id', {id: '@id'}, {
        'update': {method: 'PUT'}
    });
});

//Templatki
var editTemplate = {
    name: 'edit',
    displayName: 'Edycja',
    enableSorting: false,
    enableFiltering: false,
    enableHiding: false,
    cellTemplate: '<button id="editBtn" type="button" class="btn-small" ng-click="grid.appScope.edit(row.entity)" >Edytuj</button> '
};

var delTemplate = {
    name: 'delete',
    displayName: 'Usuwanie',
    enableSorting: false,
    enableFiltering: false,
    enableHiding: false,
    cellTemplate: '<button id="deleteBtn" type="button" class="btn-small" ng-click="grid.appScope.delete(row.entity)" >Usun</button> '
};

//CRUD
var addF = function (entry, Factory, reload) {
    entry.id = 0;
    entry = copyOf(entry);
    Factory.save(angular.toJson(entry),
        reload(),
        alert(resp));
};

var deleteF = function (entry, Factory, reload) {
    Factory.delete(entry,
        reload(),
        alert(resp));
};

var updateF = function (entry, Factory, reload) {
    entry = copyOf(entry);
    var json = angular.toJson(entry);
    Factory.update({id: entry.id}, json,
        reload(),
        alert(resp));
};

var maxId = function (data) {
    var max = 0;
    data.forEach(function (entry) {
        max = (max > entry.id) ? max : entry.id;
    });
    return max + 1;
};

var copyOf = function (object) {
    return angular.copy(object);
};

//Controlers
app.controller('indexCtrl', function ($scope, $rootScope, $route, $window) {

    $scope.strony = [
        {name: 'Druzyny', url: 'data/teams.html', hidden: false},
        {name: 'Zawodnicy', url: 'data/players.html', hidden: false},
        {name: 'Pusta Strona', url: 'data/empty.html', hidden: true}
    ];

    $scope.updateView = function (src) {
        $scope.view = src;
    };

    var alert = function (msg) {
        $window.alert(msg);
    }
});


app.controller('teamCtrl', function ($scope, TeamFactory) {
    //required vars
    var columns = [
        {
            name: 'id',
            width: '6%',
            enableFiltering: false
        },
        {
            name: 'nazwa',
            enableCellEdit: true,
            enableFiltering: true
        },
        editTemplate,
        delTemplate
    ];
    var Factory = TeamFactory;

    function empty() {
        return {id: 0, nazwa: ''}
    }

    $scope.showEdit = false;
    $scope.entry = empty();
    $scope.edited = empty();

    var data = [empty()];

    var reload = function () {
        data = Factory.query(function () {
            $scope.grid.data = data;
        }, function (resp) {
            console.log(resp);
        });
    };

    reload();

    $scope.grid = {
        enableFiltering: true,
        enableSorting: true,
        enableCellSelection: true,
        enableCellEditOnFocus: true,
        columnDefs: columns,
        data: data
    };

    //CRUD
    $scope.add = function (row) {
        row.id = 0;
        addF(row, Factory, reload);
        $scope.entry = empty();
    };

    $scope.edit = function (row) {
        $scope.showEdit = true;
        $scope.edited = copyOf(row);
    };

    $scope.delete = function (row) {
        deleteF(row, Factory, reload);
    };

    $scope.update = function (row) {
        updateF(row, Factory, reload);
        $scope.showEdit = false;
        $scope.edited = empty();
    };

});

app.controller('playerCtrl', function ($scope, PlayerFactory) {
    var Factory = PlayerFactory;
    var columns = [
        {
            field: 'id',
            displayName: 'Id',
            width: "*",
            enableFiltering: false
        },
        {
            field: 'pesel',
            displayName: 'Pesel',
            width: "*"
        },
        {
            field: 'imie',
            displayName: 'Imie',
            width: "*",
        },
        {
            field: 'nazwisko',
            displayName: 'Nazwisko',
            width: "*"
        },
        editTemplate,
        delTemplate
    ];

    function empty() {
        return {
            id: 0,
            pesel: '',
            imie: '',
            nazwisko: ''
        }

    }

    $scope.showEdit = false;
    $scope.entry = empty();
    $scope.edited = empty();

    var data = [empty()];

    var reload = function () {
        data = Factory.query(function () {
            $scope.grid.data = data;
        }, function (resp) {
            console.log(resp);
        });
    };

    reload();

    $scope.grid = {
        enableFiltering: true,
        enableSorting: true,
        enableCellSelection: true,
        enableCellEditOnFocus: true,
        columnDefs: columns,
        data: data
    };

    //CRUD
    $scope.add = function (row) {
        row.id = 0;
        addF(row, Factory, reload);
        $scope.entry = empty();
    };

    $scope.edit = function (row) {
        $scope.showEdit = true;
        $scope.edited = copyOf(row);
    };

    $scope.delete = function (row) {
        deleteF(row, Factory, reload);
    };

    $scope.update = function (row) {
        updateF(row, Factory, reload);
        $scope.showEdit = false;
        $scope.edited = empty();
    };

});