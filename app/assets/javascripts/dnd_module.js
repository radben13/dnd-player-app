/* global angular */

angular.module("lore.20", [])
.directive('loadingScreen', ["$rootScope", "$document", "$timeout", function ($rootScope, $document, $timeout) {
    return {
        link: function ($scope, $element, $attrs) {
            $document.ready(function(){
                $rootScope.$broadcast("$documentLoaded");
            });
            $scope.$on("$documentLoaded", function(){
                $timeout(function() {
                    $element.fadeOut();
                }, 500);
            });
        }
    };
}])
.controller("LoginCtrl", ["$scope", function ($scope) {
    $scope.requestToken = false
}])
.controller("BodyCtrl", ["$scope", function ($scope) {
    
}])
.controller("HeaderCtrl", ["$scope", "$timeout", function ($scope, $timeout) {
    $scope.mobileMenu = {
        active: false
    };
    $scope.toggleMobileMenu = function () {
        $scope.mobileMenu.active = !$scope.mobileMenu.active;
    };
    $scope.activeMobileMenuClass = function () {
        if($scope.mobileMenu.active) {
            return "active";
        }
        return "";
    }
}])
.service("PlayerService", ["$http", function ($http) {
}]);