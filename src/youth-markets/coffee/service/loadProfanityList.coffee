angular.module('ahaLuminateApp')
    .factory('dataService', ['$http', function ($http) {
        var serviceBase = '/api/dataservice/',
            dataFactory = {};

        dataFactory.checkUniqueValue = function (id, property, value) {
            if (!id) id = 0;
            return $http.get(serviceBase + 'checkUnique/' + id + '?property=' + 
              property + '&value=' + escape(value)).then(
                function (results) {
                    return results.data.status;
                });
        };

        return dataFactory;

}]);
