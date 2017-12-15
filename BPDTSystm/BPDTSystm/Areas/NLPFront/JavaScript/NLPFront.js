
var myapp = angular.module('myapp', ['nlpCompromise','ngRoute']);
myapp.controller('NLPFrontController', function ($scope, $http, nlp) {

    $scope.TextField = "";
    $scope.AnswerString = "This only gives the best match for your question asked above. so inorder to get a quick and rilayable answer, please provide a meaningful question";

    //START
    var vm = this;
    vm.text = "Hai hoe are you";

    vm.nouns = null;
    vm.adjectives = null;
    vm.adverbs = null;
    vm.verbs = null;
    vm.values = null;

    //This is to check on login auth
    //START
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
    //END

    //$scope.$watch('vm.text', function (text) {
    $scope.Functionwatch = function (text) {
        if (!text) {
            vm.nouns = null;
            vm.adjectives = null;
            vm.adverbs = null;
            vm.verbs = null;
            vm.values = null;
            return;
        }

        var pos = nlp.pos(text)

        vm.nouns = pos.nouns().map(function (ele) {
            return ele.normalised;
        });
        vm.nouns = _.uniq(vm.nouns);
        vm.nouns = vm.nouns.join(', ');

        vm.adjectives = pos.adjectives().map(function (ele) {
            return ele.normalised;
        });
        vm.adjectives = _.uniq(vm.adjectives);
        vm.adjectives = vm.adjectives.join(', ');

        vm.adverbs = pos.adverbs().map(function (ele) {
            return ele.normalised;
        });
        vm.adverbs = _.uniq(vm.adverbs);
        vm.adverbs = vm.adverbs.join(', ');

        vm.verbs = pos.verbs().map(function (ele) {
            return ele.normalised;
        });
        vm.verbs = _.uniq(vm.verbs);
        vm.verbs = vm.verbs.join(', ');

        vm.values = pos.values().map(function (ele) {
            return ele.normalised;
        });
        vm.values = _.uniq(vm.values);
        vm.values = vm.values.join(', ');
    };
    //});
    //END

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

    $scope.NLPFrontClicked = function (val) {

        vm.text = $scope.TextField;

        $scope.Functionwatch($scope.TextField);

        $scope.ContainedNouns = vm.nouns;
        $scope.ContainedAbjectives =  vm.adjectives ;
        $scope.ContainingAdcerbs = vm.adverbs;
        $scope.ContainedVerbs = vm.verbs;
        $scope.ContainedValues = vm.values;
        $scope.ContainedPeople = "";

        $scope.AnswerString = "Your Question contains \n Nouns of: " + $scope.ContainedNouns + "\n Abjectives of: " + $scope.ContainedAbjectives + "\n Verbs of: " + $scope.ContainedVerbs + "\n Values of: "+$scope.ContainedValues;

        var data = {};

        data.TextField = $scope.TextField;
        data.Status = val;
        data.ContainedNouns = $scope.ContainedNouns;
        data.ContainedAbjectives = $scope.ContainedAbjectives;
        data.ContainingAdcerbs = $scope.ContainingAdcerbs;
        data.ContainedVerbs = $scope.ContainedVerbs;
        data.ContainedValues = $scope.ContainedValues;
        data.ContainedPeople = $scope.ContainedPeople;

        var str = $scope.ContainedNouns;
        
        var str02 = $scope.ContainedAbjectives;
        var str03 = $scope.ContainedVerbs;
        var res = str + " , " + str02 + " , " + str03;
        data.Semester_Id = res; // this is used at the controller level as the parameterOne
        data.Semester_Name = data.ContainedVerbs; // this is used at the controller level as the parameterTwo 

        $http({

            url: GetNLPAnswer,
            method: 'POST',
            data: $.param(data),
            dataType: "",
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',

            }
        })
                .success(function (data) {
                    if (data.Semester_Id != null || data.Semester_Id != undefined || data.Semester_Id != "") {
                        $scope.AnswerStringPara = data.Semester_Id;
                    } else {
                        $scope.AnswerStringPara = "There are no data related this query";
                    }
                }).error(function (data) {
                    $scope.AnswerStringPara = "There are no data related this query";
                });
    
    };
})
