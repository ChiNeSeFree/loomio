moment = require 'moment'

EventBus = require 'shared/services/event_bus'

{ calendarMonth, calendarStyle, daysOfTheWeek } = require 'shared/helpers/calendar'

angular.module('loomioApp').directive 'lmoCalendar', ->
  scope: {selected: '=', enablePast: '=?'}
  templateUrl: 'generated/components/lmo_calendar/lmo_calendar.html'
  controller: ['$scope', ($scope) ->
    $scope.today     = moment()
    $scope.current   = $scope.today.clone()
    $scope.dayNames  = moment.weekdaysShort()

    $scope.changeMonth = (diff = 0) ->
      $scope.current.add(diff, 'month')
      $scope.weeks = calendarMonth $scope.current
    $scope.changeMonth()

    $scope.isSelected = (date) ->
      _.contains $scope.selected, date

    $scope.styleFor = (date) ->
      calendarStyle(date, $scope.selected)

    $scope.selectDate = (date) ->
      EventBus.emit $scope, 'dateSelected', date
  ]
