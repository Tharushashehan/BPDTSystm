
var myapp = angular.module('myapp', []);
//var myapp = angular.module('myapp', ["ngRoute", 'ngAnimate', "ui.bootstrap", 'directives.customvalidation.customValidationTypes']);
myapp.controller('RegistrationDatesController', function ($scope, $http) {

    $scope.searchItem;
    $scope.Semester_Id;
    $scope.Semester_Name;
    $scope.Payment_Start_Date = new Date();
    $scope.Payment_End_Date = new Date();
    $scope.Semester_Start_Date = new Date();
    $scope.Semester_End_Date = new Date();
    $scope.Semester_Fee;
    $scope.Late_Payment_Date_From = new Date();
    $scope.Late_Payment_Date_To = new Date();
    $scope.Late_Payment_Fee;
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

    //This is where autocomplete starts
    //START
    var ItemResponse = function (Semester_Id) {
        this.label = Semester_Id;
    }

    $scope.searchItemItemAutoComplete = function () {
        $('#searchItem').autocomplete(
                       {
                           source: function (request, response) {
                               if ($scope.searchItem == null) {
                                   $scope.searchItem = '';
                               }
                               var dataItem = {};
                               dataItem.Semester_Id = $scope.searchItem;
                               $.ajax({
                                   url: AutocompleteRegularRegistrationData,
                                   type: "POST",
                                   data: dataItem,
                                   headers: {
                                       'Content-Type': 'application/x-www-form-urlencoded'
                                   },
                                   dataType: "",
                                   success: function (data) {
                                       response($.map(data, function (resItem) {
                                           return new ItemResponse(resItem.Semester_Id);
                                       }));
                                   },
                                   error: function () {
                                       $("#errorModal").modal('show');
                                   }
                               });
                           },
                           minLength: 1,
                           select: function (event, ui) {
                               $scope.LoadData(ui.item.label);
                           }
                       })
                .autocomplete("instance")._renderItem = function (ul, item) {
                    return $("<li>")
                      .append("<a id='autocompleteHead'>" + item.label + "</a>")
                      .appendTo(ul);
                };
    };

    $scope.LoadData = function (val) {

        var data = {};
        data.Semester_Id = val;
        $http({
            url: LoadRegularRegistrationData,
            method: 'POST',
            data: $.param(data),
            dataType: "",
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            }
        })
        .success(function (data) {
            $scope.clearData();

            $scope.searchItem = data[0].Semester_Id;
            $scope.Semester_Id = data[0].Semester_Id;
            $scope.Semester_Name = data[0].Semester_Name;
            $scope.Payment_Start_Date = new Date(data[0].Payment_Start_Date);
            $scope.Payment_End_Date = new Date(data[0].Payment_End_Date);
            $scope.Semester_Start_Date = new Date(data[0].Semester_Start_Date);
            $scope.Semester_End_Date = new Date(data[0].Semester_End_Date);
            $scope.Semester_Fee = data[0].Semester_Fee;
            $scope.Late_Payment_Date_From = new Date(data[0].Late_Payment_Date_From);
            $scope.Late_Payment_Date_To = new Date(data[0].Late_Payment_Date_To);
            $scope.Late_Payment_Fee = data[0].Late_Payment_Fee;

            $('#saveData').attr('disabled', true);
        }).error(function (data) {
            $("#errorModal").modal('show');
        });
    };
    //END

    $scope.clearData = function () {
        $scope.searchItem = "";
        $scope.Semester_Id = "";
        $scope.Semester_Name = "";
        $scope.Payment_Start_Date = new Date();
        $scope.Payment_End_Date = new Date();
        $scope.Semester_Start_Date = new Date();
        $scope.Semester_End_Date = new Date();
        $scope.Semester_Fee = "";
        $scope.Late_Payment_Date_From = new Date();
        $scope.Late_Payment_Date_To = new Date();
        $scope.Late_Payment_Fee = "";
    };

    $scope.validateOnAction = function () {

        var validated = true;

        if ($scope.commonRequiredValidator('Semester_Id')) { validated = true; } else { $scope.showValidated(); return false; }
        if ($scope.commonRequiredValidator('Semester_Name')) { validated = true; } else { $scope.showValidated(); return false; }
        if ($scope.commonRequiredValidator('Semester_Fee')) { validated = true; } else { $scope.showValidated(); return false; }
        if ($scope.commonRequiredValidator('Late_Payment_Fee')) { validated = true; } else { $scope.showValidated(); return false; }

        return validated;
    };


    // Method to trigger all the validations if one input is invalidated on submission
    $scope.showValidated = function () {
        $('form[name=ItemForm] input').each(function (index, item) {
            if ($(item).hasClass('required') && ($.trim($(item).val()) == '' || $.trim($(item).val()) == undefined)) {
                $(item).addClass('redBorder').removeClass('grayBorder');
            }
        });
    }
    // Validation Methods
    // Required Field Validator
    $scope.commonRequiredValidator = function (elementId) {
        if ($.trim($('#' + elementId).val()) === "" || $.trim($('#' + elementId).val()) === undefined) {
            $('#' + elementId).addClass('redBorder').removeClass('grayBorder');
            return false;
        }
        else {
            $('#' + elementId).addClass('grayBorder').removeClass('redBorder');
            return true;
        }
    };

    $scope.saveData = function (val) {

        if ($scope.validateOnAction()) {

            var data = {};

            data.Semester_Id = $scope.Semester_Id;
            data.Semester_Name = $scope.Semester_Name;
            data.Payment_Start_Date = $('#Payment_Start_Date').val(); //Payment_Start_Date.value;
            data.Payment_End_Date = $('#Payment_End_Date').val(); //Payment_End_Date.value;
            data.Semester_Start_Date = $('#Semester_Start_Date').val(); //Semester_Start_Date.value;
            data.Semester_End_Date = $('#Semester_End_Date').val(); //Semester_End_Date.value;
            data.Semester_Fee = $scope.Semester_Fee;
            data.Late_Payment_Date_From = $('#Late_Payment_Date_From').val(); //Late_Payment_Date_From.value;
            data.Late_Payment_Date_To = $('#Late_Payment_Date_To').val(); //Late_Payment_Date_To.value;
            data.Late_Payment_Fee = $scope.Late_Payment_Fee;
            data.Status = val;

            $http({

                url: SaveRegularRegistrationData,
                method: 'POST',
                data: $.param(data),
                dataType: "",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',

                }
            })
                    .success(function (data) {
                        //$('#loaderwrapper').hide();
                        //var sucessMessage = data.Payload.Message;
                        //document.getElementById("sucessmessage").innerHTML = sucessMessage;
                        $("#sucessModal").modal('show');
                        //$scope.clearRBOMItemDetails();
                        $scope.clearData();

                    }).error(function (data) {
                        //$('#loaderwrapper').hide();
                        //var errorMessage = data.Payload.Message;
                        //document.getElementById("errormessage").innerHTML = errorMessage;
                        $("#errorModal").modal('show');
                    });
        }
    };

});
