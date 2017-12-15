

var myapp = angular.module('myapp', []);
myapp.controller('NewsFeedController', function ($scope, $http) {
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

    //This is to run Delete all data function
    //START
    $scope.DeleteAllData = function () {

        var data = {};
        data.Semester_Id = "";

        $http({

            url: DeleteAllData,
            method: 'POST',
            data: $.param(data),
            dataType: "",
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',

            }
        })
                .success(function (data) {
                    $("#DeleteAllDataModal").modal('hide');
                    $scope.AnswerString = data.AnswerString;
                    if (data.Semester_Id != null || data.Semester_Id != undefined || data.Semester_Id != "") {
                        $("#sucessModal").modal('show');
                    }
                }).error(function (data) {
                    $("#errorModal").modal('show');
                });
    };
    //END
});