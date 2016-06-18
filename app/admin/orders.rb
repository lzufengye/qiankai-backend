ActiveAdmin.register Order do
  menu parent:'订单管理'
  permit_params :state, :handle_state, :logistical, :logistical_number, :total_price, :ship_fee, :comment, :invoice_title

  index do
    selectable_column
    column :sn
    column :line_items do |order|
      order.line_items.map{|line_item| "#{line_item.try(:product).try(:name)} X #{line_item.quantity}, "}.reduce('+')
    end
    column '商家' do |order|
      order.line_items.map{|line_item| "#{line_item.try(:product).try(:customer).try(:name)}: #{line_item.try(:product).try(:customer).try(:phone)},"}.reduce('+')
    end
    column :consumer do |order|
      order.consumer.openid ? "微信用户：#{order.consumer.nickname}" : order.consumer.email if order.consumer.present?
    end
    column :address do |order|
      link_to order.address.city_name, admin_address_path(order.address) if order.address.present?
    end
    column :state
    column :handle_state
    column :total_price
    # column :ship_fee
    column :comment
    column :deleted
    column :created_at
    actions
  end

  form do |f|
    f.inputs "订单详情" do
      f.input :state, as: :select, collection: ['未支付', '支付中', '已支付']
      f.input :handle_state, as: :select, collection: ['未处理', '正在处理', '已发货', '已完成', '已收货']
      f.input :logistical
      f.input :logistical_number
      f.input :total_price
      f.input :ship_fee
    end
    f.actions
  end

  filter :created_at
  filter :state
  filter :sn
  filter :handle_state
  filter :products
  filter :customers
  filter :deleted
end
