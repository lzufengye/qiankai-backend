ActiveAdmin.register Order, as: 'CustomerOrder' do
  menu parent: '订单管理'

  actions :index

  index do
    div class: 'panel' do
      orders = Order.where(customer_id: Customer.last.id)

      if params['q']
        orders = params['q']['customer_id_eq'] ? Order.where(customer_id: params['q']['customer_id_eq']) : orders
        orders = params['q']['line_items_product_id_eq'] ? orders.joins(:line_items).where('line_items.product_id = ?', params['q']['line_items_product_id_eq']) : orders
        orders = params['q']['created_at_gteq'] ? orders.where('created_at >= ?', params['q']['created_at_gteq']) : orders
        orders = params['q']['created_at_lteq'] ? orders.where('created_at >= ?', params['q']['created_at_lteq']) : orders
      end

      h3 "销售金额合计: #{orders.map(&:total_price).reduce(&:+)}"
    end
    column '商户名称' do |order|
      truncate(order.customer.try(:name))
    end
    column '销售日期' do |order|
      order.created_at
    end
    column :sn
    column '商品名称' do |order|
      table do
        order.line_items.each do |line_item|
          tr do
            td do
              line_item.try(:product).try(:name)
            end
          end
        end
      end
    end
    column '数量' do |order|
      table do
        order.line_items.each do |line_item|
          tr do
            td do
              line_item.quantity
            end
          end
        end
      end
    end
    column '单价' do |order|
      table do
        order.line_items.each do |line_item|
          tr do
            td do
              line_item.unit_price
            end
          end
        end
      end
    end
    column '销售金额' do |order|
      order.total_price
    end
    actions
  end

  filter :created_at
  filter :products
  filter :customer

  controller do
    def scoped_collection
      if params['controller'] == 'admin/customer_orders' && params['action'] == 'index'
        params['q'] && params['q']['customer_id_eq'] ? super.includes(:products, :line_items) : super.includes(:products, :line_items).where(customer: Customer.last)
      else
        super.includes(:products, :line_items)
      end
    end
  end
end
