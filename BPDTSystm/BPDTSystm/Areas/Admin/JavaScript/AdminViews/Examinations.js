

var myapp = angular.module('myApp', []);

myapp.controller('ExaminationsController', function ($scope, $http) {
    $scope.LoginStatus;

    $scope.CheckUserAuth = function () {

        $scope.LoginStatus = localStorage.getItem('UserLoginState');

        if ($scope.LoginStatus == "Success") {
            return true;
        }
        else {
            return false;
        }
    };

    $scope.CheckUserAuth();

});