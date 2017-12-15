
var myapp = angular.module('myapp', []);

myapp.controller('ProRataRegistrationController', function ($scope, $http) {

    $scope.searchItem;
    $scope.Semester_Id;
    $scope.ProRata_Registration_Start_Date = new Date(); //new Date("2003-09-17");
    $scope.ProRata_Registration_End_Date = new Date(); //new Date("09/17/2012");
    $scope.ProRata_Fee;
    $scope.Last_Payment_Date_From = new Date(); //new Date("03-09-2017");
    $scope.Last_Payment_Date_To = new Date(); //new Date("03-09-2017");
    $scope.Late_Payment_Fee;
    $scope.MIT;
    $scope.FCS;
    $scope.IPE;
    $scope.ST1;
    $scope.CF;
    $scope.ELS2;
    $scope.English1;
    $scope.DBMS1;
    $scope.DCCN1;
    $scope.ITA;
    $scope.LoginStatus;

    $scope.CheckUserAuth = function () {

        $scope.LoginStatus = localStorage.getItem('UserLoginState');

        if ($scope.LoginStatus == "Success") {
            return true;
        }
        else{
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
                                   url: AutocompleteProrataRegistrationData,
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
            url: LoadProrataRegistrationData,
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
            $scope.ProRata_Registration_Start_Date = new Date(data[0].Pro_Rata_Registration_Start_Date);
            $scope.ProRata_Registration_End_Date = new Date(data[0].Pro_Rata_Registration_End_Date);
            $scope.ProRata_Fee = data[0].Pro_Rata_Fee;
            $scope.Last_Payment_Date_From = new Date(data[0].Last_Payment_Date_From);
            $scope.Last_Payment_Date_To = new Date(data[0].Last_Payment_Date_To);
            $scope.Late_Payment_Fee = data[0].Late_Payment_Fee;

            $scope.MIT = "";
            $scope.FCS = "";
            $scope.IPE = "";
            $scope.ST1 = "";
            $scope.CF = "";
            $scope.ELS2 = "";
            $scope.English1 = "";
            $scope.DBMS1 = "";
            $scope.DCCN1 = "";
            $scope.ITA = "";

            for(var i = 0;i<data.length;i++){
                switch (data[i].Date_Time) {
                    case "MIT":
                        $scope.MIT = true;
                        break;
                    case "FCS":
                        $scope.FCS = true;
                        break;
                    case "IPE":
                        $scope.IPE = true;
                        break;
                    case "ST1":
                        $scope.ST1 = true;
                        break;
                    case "CF":
                        $scope.CF = true;
                        break;
                    case "ELS2":
                        $scope.ELS2 = true;
                        break;
                    case "English1":
                        $scope.English1 = true;
                        break;
                    case "DBMS1":
                        $scope.DBMS1 = true;
                        break;
                    case "DCCN1":
                        $scope.DCCN1 = true;
                        break;
                    case "ITA":
                        $scope.ITA = true;
                        break;
                    default:
                        break;
                }
            }

            $('#saveData').attr('disabled', true);
        }).error(function (data) {
            $("#errorModal").modal('show');
        });
    };
    //END

    $scope.clearData = function () {
        $scope.searchItem = "";
        $scope.Semester_Id = "";
        $scope.ProRata_Registration_Start_Date = new Date();
        $scope.ProRata_Registration_End_Date = new Date();
        $scope.ProRata_Fee = "";
        $scope.Last_Payment_Date_From = new Date();
        $scope.Last_Payment_Date_To = new Date();
        $scope.Late_Payment_Fee = "";
        $scope.MIT = "";
        $scope.FCS = "";
        $scope.IPE = "";
        $scope.ST1 = "";
        $scope.CF = "";
        $scope.ELS2 = "";
        $scope.English1 = "";
        $scope.DBMS1 = "";
        $scope.DCCN1 = "";
        $scope.ITA = "";
        $('#saveData').attr('disabled', false);
    };

    $scope.validateOnAction = function () {

        var validated = true;

        if ($scope.commonRequiredValidator('Semester_Id')) { validated = true; } else { $scope.showValidated(); return false; }
        if ($scope.commonRequiredValidator('ProRata_Fee')) { validated = true; } else { $scope.showValidated(); return false; }
        if ($scope.commonRequiredValidator('Late_Payment_Fee')) { validated = true; } else { $scope.showValidated(); return false; }
        //if ($scope.commonRequiredValidator('Late_Payment_Fee')) { validated = true; } else { $scope.showValidated(); return false; }

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
            var modelData = [];

            data.Semester_Id = $scope.Semester_Id;
            data.Pro_Rata_Registration_Start_Date = $('#ProRata_Registration_Start_Date').val();
            data.Pro_Rata_Registration_End_Date = $('#ProRata_Registration_End_Date').val(); //$scope.ProRata_Registration_End_Date.value;
            data.Pro_Rata_Fee = $scope.ProRata_Fee;
            data.Last_Payment_Date_From = $('#Last_Payment_Date_From').val(); //$scope.Last_Payment_Date_From.value;
            data.Last_Payment_Date_To = $('#Last_Payment_Date_To').val(); //$scope.Last_Payment_Date_To.value;
            data.Late_Payment_Fee = $scope.Late_Payment_Fee;
            data.Status = val;

            //for Model details data

            if ($scope.MIT != "" && $scope.MIT != undefined && $scope.MIT != null) {
                var obj = {
                    Allow_Subject_Name: "MIT",
                };
                modelData.push(obj);
            }
            if ($scope.FCS != "" && $scope.FCS != undefined && $scope.FCS != null) {
                var obj = {
                    Allow_Subject_Name: "FCS",
                };
                modelData.push(obj);
            }
            if ($scope.IPE != "" && $scope.IPE != undefined && $scope.IPE != null) {
                var obj = {
                    Allow_Subject_Name: "IPE",
                };
                modelData.push(obj);
            }
            if ($scope.ST1 != "" && $scope.ST1 != undefined && $scope.ST1 != null) {
                var obj = {
                    Allow_Subject_Name: "ST1",
                };
                modelData.push(obj);
            }
            if ($scope.CF != "" && $scope.CF != undefined && $scope.CF != null) {
                var obj = {
                    Allow_Subject_Name: "CF",
                };
                modelData.push(obj);
            }
            if ($scope.ELS2 != "" && $scope.ELS2 != undefined && $scope.ELS2 != null) {
                var obj = {
                    Allow_Subject_Name: "ELS2",
                };
                modelData.push(obj);
            }
            if ($scope.English1 != "" && $scope.English1 != undefined && $scope.English1 != null) {
                var obj = {
                    Allow_Subject_Name: "English1",
                };
                modelData.push(obj);
            }
            if ($scope.DBMS1 != "" && $scope.DBMS1 != undefined && $scope.DBMS1 != null) {
                var obj = {
                    Allow_Subject_Name: "DBMS1",
                };
                modelData.push(obj);
            }
            if ($scope.DCCN1 != "" && $scope.DCCN1 != undefined && $scope.DCCN1 != null) {
                var obj = {
                    Allow_Subject_Name: "DCCN1",
                };
                modelData.push(obj);
            }
            if ($scope.ITA != "" && $scope.ITA != undefined && $scope.ITA != null) {
                var obj = {
                    Allow_Subject_Name: "ITA",
                };
                modelData.push(obj);
            }

            data.Pro_Rata_Registration_Subject_List = modelData;

            $http({

                url: SaveProRataRegistrationData,
                method: 'POST',
                data: $.param(data),
                dataType: "",
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                    //'Authorization': 'Bearer '
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
