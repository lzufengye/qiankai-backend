ActiveAdmin = {
  dashboard: {}
}

ActiveAdmin.dashboard.index = function() {

  $('#users').highcharts({
    chart: {
      type: 'line'
    },
    title: {
      text: '注册用户数'
    },
    xAxis: {
      categories: $.map($("#users-data").data('registering'), function(data) {return data.date})
    },
    yAxis: {
      title: {
        text: '注册用户数'
      }
    },
    series: [{
      name: '月份',
      data: $.map($("#users-data").data('registering'), function(data) {return data.count})
   }]
  });
}
