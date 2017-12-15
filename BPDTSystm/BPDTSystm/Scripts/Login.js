
var myapp = angular.module('myapp', []);
myapp.controller('LoginController', function ($scope, $location, $http) {

    $scope.username = "";
    $scope.password = "";

    $scope.LoginClicked = function (val) {
        var data = {};

        data.Email = $scope.username,
        data.Temp_Password = $scope.password;
        data.Status = 1;

        $http({

            url: LoginAuthorization,
            method: 'POST',
            data: $.param(data),
            dataType: "",
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',

            }
        })
                .success(function (data) {
                    var rtn = data;
                    
                    if (data[0].Index_No == "ADMIN") {
                        localStorage.setItem('UserCode', "ADMIN");
                        localStorage.setItem('UserLoginState', "Success");
                        window.location.assign("http://localhost:18449/Admin/Admin/RegistrationDates/NLPFrontIndex");
                    }
                    else if (data[0].Index_No == "VALID") {
                        localStorage.setItem('UserCode', "VALID");
                        localStorage.setItem('UserLoginState', "Success");
                        window.location.assign("http://localhost:18449/NLPFront/NLPFront/NLPFrontIndex");
                    }
                    else {
                        $("#Warningmodal").modal('show');
                    }



                }).error(function (data) {
                    var rtn = data;
                    //$('#loaderwrapper').hide();
                    //var errorMessage = data.Payload.Message;
                    //document.getElementById("errormessage").innerHTML = errorMessage;
                    //$("#errorModal").modal('show');
                });
    };

    });
