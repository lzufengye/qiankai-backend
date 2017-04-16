class PingPPService
  def self.create_payment(order, client_ip, channel, success_url=nil)
    charge_body = (order.line_items.map { |line_item| line_item.product.name }).to_json

    Pingpp::Charge.create(
        order_no: order.sn,
        amount: (order.total_price + order.ship_fee) * 100,
        subject: '开街网订单',
        body: charge_body.length < 128 ? charge_body : '多件开街网商品',
        channel: channel,
        currency: 'cny',
        client_ip: client_ip,
        extra: extra_field(order, success_url)[channel.to_sym],
        app: {id: ENV['PING_PP_KEY'] || "app_0qbv1GTurPWP9Gq1"}
    )
  end

  def self.extra_field(order, success_url=nil)
    {
        wx_pub: {open_id: order.consumer.openid},
        wx_pub_qr: {product_id: order.sn},
        alipay_pc_direct: {success_url: success_url},
        alipay_wap: {success_url: success_url},
        wx: {success_url: success_url}
    }
  end

  def self.create_payment_for_multiple_orders(order_sns, client_ip, channel, success_url=nil)
    return nil unless order_sns.present?

    order_group = OrderGroup.create(order_sns: order_sns.join(','))

    orders = order_group.orders
    total_amount = orders.map {|order| order.need_to_be_charged}.reduce(:+)

    Pingpp::Charge.create(
        order_no: "ORDERGROUP#{order_group.id}",
        amount: total_amount * 100,
        subject: '开街网订单',
        body: order_sns.to_json,
        channel: channel,
        currency: 'cny',
        client_ip: client_ip,
        extra: extra_field_for_order_group(order_group, success_url)[channel.to_sym],
        app: {id: ENV['PING_PP_KEY'] || "app_0qbv1GTurPWP9Gq1"}
    )
  end

  def self.extra_field_for_order_group(order_group, success_url=nil)
    {
        wx_pub: {open_id: order_group.orders[0].try(:consumer).try(:openid)},
        wx_pub_qr: {product_id: order_group.id},
        alipay_pc_direct: {success_url: success_url},
        wx: {success_url: success_url}
    }
  end
end