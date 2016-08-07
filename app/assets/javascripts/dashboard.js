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
   }],
    exporting: {
      enabled: false
    }
  });

  $('#customers-chart').highcharts({
    chart: {
      type: 'line'
    },
    title: {
      text: '入驻商家数'
    },
    xAxis: {
      categories: $.map($("#customers-chart-data").data('registering'), function(data) {return data.date})
    },
    yAxis: {
      title: {
        text: '入驻商家数'
      }
    },
    series: [{
      name: '月份',
      data: $.map($("#customers-chart-data").data('registering'), function(data) {return data.count})
    }],
    exporting: {
      enabled: false
    }
  });

  $('#products-chart').highcharts({
    chart: {
      type: 'line'
    },
    title: {
      text: '上架商品'
    },
    xAxis: {
      categories: $.map($("#products-chart-data").data('registering'), function(data) {return data.date})
    },
    yAxis: {
      title: {
        text: '上架商品数'
      }
    },
    series: [{
      name: '月份',
      data: $.map($("#products-chart-data").data('registering'), function(data) {return data.count})
    }],
    exporting: {
      enabled: false
    }
  })
}
