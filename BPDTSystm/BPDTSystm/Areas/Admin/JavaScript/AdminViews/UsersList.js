
var myapp = angular.module('myapp', []);
//var myapp = angular.module('myapp', ["ngRoute", 'ngAnimate', "ui.bootstrap", 'directives.customvalidation.customValidationTypes']);
myapp.controller('UserListController', function ($scope, $http) {

    $scope.AllUserListCollection = [];
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

    //$scope.LogOutClicked() = function () {
    //    localStorage.setItem('UserLoginState', "Failed");
    //    window.location.assign("http://localhost:18449/Home/Index");
    //};


    //To Load all the users in the page load
    //START
    angular.element(document).ready(function () {
        $scope.GetAllUserData();
    });
    //END

    $scope.clearData = function () {
        $scope.Index_No = "";
        $scope.Student_Name = "";
        $scope.Course = "";
        $scope.Email = "";
       $scope.Student_Type = "";
    };

    //This gets user list in the load data
    //START
    $scope.GetAllUserData = function (val) {
        var data = {};
        data.Status = val;

        $http({

            url: GetAllUserData,
            method: 'POST',
            data: $.param(data),
            dataType: "",
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        })
                .success(function (data) {
                    $scope.AllUserListCollection = [];
                    for (var i = 0; i < data.length; i++) {
                        $scope.AllUserListCollection.push({
                            'Index_No': data[i].Index_No,
                            'Student_Name': data[i].Student_Name,
                            'Student_Type': data[i].Student_Type,
                            'Course': data[i].Course,
                            'Email': data[i].Email
                        });
                    }

                }).error(function (data) {
                    //$('#loaderwrapper').hide();
                    //var errorMessage = data.Payload.Message;
                    //document.getElementById("errormessage").innerHTML = errorMessage;
                    $("#errorModal").modal('show');
                });
    };
    //END

    //This is used to save user
    //START
    $scope.SaveData = function (val) {
        var data = {};
        data.Status = val;
        data.Index_No = $scope.Index_No;
        data.Student_Name = $scope.Student_Name;
        data.Course = $scope.Course;
        data.Email = $scope.Email;
        data.Student_Type = $scope.Student_Type;

        $http({

            url: SaveUserData,
            method: 'POST',
            data: $.param(data),
            dataType: "",
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            }
        })
                .success(function (data) {
                    $("#sucessModal").modal('show');
                    $scope.clearData();

                }).error(function (data) {
                    //$('#loaderwrapper').hide();
                    //var errorMessage = data.Payload.Message;
                    //document.getElementById("errormessage").innerHTML = errorMessage;
                    $("#errorModal").modal('show');
                });
    };
    //END
});
