ActiveAdmin = {
  dashboard: {}
}

ActiveAdmin.dashboard.index = function () {
  console.log('test');

  $('#users').highcharts({
    chart: {
      type: 'line'
    },
    title: {
      text: '注册用户数'
    },
    xAxis: {
      categories: $.map($("#users-data").data('registering'), function (data) {
        return data.date
      })
    },
    yAxis: {
      title: {
        text: '注册用户数'
      }
    },
    series: [{
      name: '月份',
      data: $.map($("#users-data").data('registering'), function (data) {
        return data.count
      })
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
      categories: $.map($("#customers-chart-data").data('registering'), function (data) {
        return data.date
      })
    },
    yAxis: {
      title: {
        text: '入驻商家数'
      }
    },
    series: [{
      name: '月份',
      data: $.map($("#customers-chart-data").data('registering'), function (data) {
        return data.count
      })
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
      categories: $.map($("#products-chart-data").data('registering'), function (data) {
        return data.date
      })
    },
    yAxis: {
      title: {
        text: '上架商品数'
      }
    },
    series: [{
      name: '月份',
      data: $.map($("#products-chart-data").data('registering'), function (data) {
        return data.count
      })
    }],
    exporting: {
      enabled: false
    }
  });

  $('#orders-chart').highcharts({
    chart: {
      type: 'line'
    },
    title: {
      text: '订单数'
    },
    xAxis: {
      categories: $.map($("#orders-chart-data").data('registering'), function (data) {
        return data.date
      })
    },
    yAxis: {
      title: {
        text: '订单数'
      }
    },
    series: [{
      type: 'line',
      name: '总数',
      data: $.map($("#orders-chart-data").data('registering'), function (data) {
        return data.count
      })
    },
      {
        type: 'column',
        name: '货到付款',
        data: $.map($("#orders-chart-data").data('registering'), function (data) {
          return data.cash_pay_count
        })
      },
      {
        type: 'column',
        name: '银行汇款',
        data: $.map($("#orders-chart-data").data('registering'), function (data) {
          return data.bank_pay_count
        })
      },
      {
        type: 'column',
        name: '在线支付',
        data: $.map($("#orders-chart-data").data('registering'), function (data) {
          return data.online_pay_count
        })
      }],
    exporting: {
      enabled: false
    }
  });

  $('#paid-orders-chart').highcharts({
    chart: {
      type: 'line'
    },
    title: {
      text: '已支付订单数'
    },
    xAxis: {
      categories: $.map($("#paid-orders-chart-data").data('registering'), function (data) {
        return data.date
      })
    },
    yAxis: {
      title: {
        text: '已支付订单数'
      }
    },
    series: [{
      type: 'line',
      name: '总数',
      data: $.map($("#paid-orders-chart-data").data('registering'), function (data) {
        return data.count
      })
    },
      {
        type: 'column',
        name: '货到付款',
        data: $.map($("#paid-orders-chart-data").data('registering'), function (data) {
          return data.cash_pay_count
        })
      },
      {
        type: 'column',
        name: '银行汇款',
        data: $.map($("#paid-orders-chart-data").data('registering'), function (data) {
          return data.bank_pay_count
        })
      },
      {
        type: 'column',
        name: '在线支付',
        data: $.map($("#paid-orders-chart-data").data('registering'), function (data) {
          return data.online_pay_count
        })
      }],
    exporting: {
      enabled: false
    }
  });

  $('#paid-orders-money-chart').highcharts({
    chart: {
      type: 'line'
    },
    title: {
      text: '已支付订单总额'
    },
    xAxis: {
      categories: $.map($("#paid-orders-money-chart-data").data('registering'), function (data) {
        return data.date
      })
    },
    yAxis: {
      title: {
        text: '已支付订单总额'
      }
    },
    series: [{
      type: 'line',
      name: '总额',
      data: $.map($("#paid-orders-money-chart-data").data('registering'), function (data) {
        return data.total_amount
      })
    },
      {
        type: 'column',
        name: '货到付款总额',
        data: $.map($("#paid-orders-money-chart-data").data('registering'), function (data) {
          return data.cash_pay_amount
        })
      },
      {
        type: 'column',
        name: '银行汇款总额',
        data: $.map($("#paid-orders-money-chart-data").data('registering'), function (data) {
          return data.bank_pay_amount
        })
      },
      {
        type: 'column',
        name: '在线支付总额',
        data: $.map($("#paid-orders-money-chart-data").data('registering'), function (data) {
          return data.online_pay_amount
        })
      }],
    exporting: {
      enabled: false
    }
  });

}
