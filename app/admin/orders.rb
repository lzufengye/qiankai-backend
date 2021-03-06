ActiveAdmin.register Order do
  menu parent:'订单管理'
  permit_params :state, :handle_state, :logistical, :logistical_number, :ship_fee, :comment, :invoice_title

  actions :all, except: [:destroy, :new]

  index do
    selectable_column
    column :sn
    column :line_items do |order|
      truncate(order.line_items.map{|line_item| "#{line_item.try(:product).try(:name)} X #{line_item.quantity}, "}.reduce('+'))
      # order.line_items.group_by(&:customer).map{|customer, line_items| "#{customer.name}: #{line_items.map{|line_item| "#{line_item.try(:product).try(:name)} X #{line_item.quantity}, "}.reduce('+')}"}.reduce(&:+)
    end
    column '商家' do |order|
      customers = order.line_items.map{|line_item| "#{line_item.try(:product).try(:customer).try(:name)}: #{line_item.try(:product).try(:customer).try(:phone)},"}.reduce('+')
      order.customer ? (link_to truncate(order.customer.try(:name)), admin_customer_path(order.customer)) : customers
    end
    column :consumer do |order|
      truncate(order.consumer.openid ? "微信用户：#{order.consumer.nickname}" : order.consumer.email) if order.consumer.present?
    end
    column :address do |order|
      link_to order.address.city_name, admin_address_path(order.address) if order.address.present?
    end
    column :payment_method
    column :state
    column :handle_state
    column :total_price
    column :ship_fee
    column :invoice_title
    column :comment
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :sn
      row :consumer_id do
        link_to order.consumer.try(:email), admin_consumer_path(order.consumer)
      end
      row :address_id do
        link_to order.address.try(:human_read_address), admin_address_path(order.address)
      end
      row :state
      row :handle_state
      row :ship_fee
      row :total_price
      row :comment
      row :invoice_title
      row :payment_method_id
      row :payment_method_name
      row :logistical
      row :logistical_number
      row :customer_id do
        customers = order.line_items.map{|line_item| "#{line_item.try(:product).try(:customer).try(:name)}: #{line_item.try(:product).try(:customer).try(:phone)},"}.reduce('+')
        order.customer ? (link_to order.customer.try(:name), admin_customer_path(order.customer)) : customers
      end
      row :created_at
      row :updated_at
    end

    panel('订单项详情') do
      table_for(order.line_items) do
        column :id do |line_item|
          link_to line_item.id, admin_line_item_path(line_item)
        end
        column :product do |line_item|
          line_item.product ? (link_to line_item.product.name, admin_product_path(line_item.product)) : ''
        end
        column :sku_id do |line_item|
          line_item.sku.try(:name)
        end
        column :unit_price
        column :quantity
      end
    end
  end


  form do |f|
    f.inputs "订单详情" do
      f.input :state, as: :select, collection: ['未支付', '支付中', '已支付']
      f.input :handle_state, as: :select, collection: ['未处理', '正在处理', '已发货', '已完成', '已收货']
      f.input :logistical
      f.input :logistical_number
      # f.input :total_price
      f.input :ship_fee
    end
    f.actions
  end

  filter :created_at
  filter :payment_method
  filter :state
  filter :sn
  filter :handle_state
  filter :products
  filter :customer

  sidebar :export do
    link_to '<button type="button">导出订单</button>'.html_safe, export_order_admin_orders_path
  end

  collection_action :export_order, method: :get do
    filter = Order.ransack(session['filter'])

    order_list = Spreadsheet::Workbook.new
    sheet = order_list.create_worksheet name: 'Sheet-1'

    header = ['序号', '订单日期', '订单号', '购买物品', '商家', '顾客姓名', '联系电话', '收货地址', '商品价格', '运费', '支付方式', '处理状态', '发票抬头', '备注信息']

    sheet.insert_row(0, ['', '', '', '', '', '', '开街网订单处理详细信息表', '', '', '', '', '', '', ''])
    sheet.insert_row(1, header)

    orders = filter.result.includes(:address).includes(:consumer).includes(:payment_method).includes(:line_items).includes(:products).includes(:customers).where(deleted: false).order('created_at DESC')

    orders = orders.where(customer_id: current_admin_user.customer_id) unless current_admin_user.admin?

    orders.each_with_index do |order, index|
      order_detail = order.line_items.map do |line_item|
         "#{line_item.try(:product).try(:name)}[#{line_item.try(:sku).try(:name)}] X #{line_item.quantity}, "
      end.reduce('+')

      customers = order.line_items.map do |line_item|
        "#{line_item.try(:product).try(:customer).try(:name)} - #{line_item.try(:product).try(:customer).try(:phone)}"
      end.uniq.reduce('+')

      consumer = order.consumer.openid ? "微信用户：#{order.consumer.nickname}" : order.consumer.email if order.consumer.present?

      new_row_index = sheet.last_row_index + 1
      row = [index + 1, order.created_at.strftime('%m/%d/%Y'), order.sn, order_detail, customers, order.address.try(:receiver), order.address.try(:phone), order.address.try(:receiver_address_detail), order.total_price, order.ship_fee, order.payment_method.try(:name), order.handle_state, order.invoice_title, order.comment]
      sheet.insert_row(new_row_index, row)
    end

    spreadsheet = StringIO.new
    order_list.write spreadsheet
    send_data spreadsheet.string, :filename => "orders-#{Time.now.strftime('%F')}.xls", :type =>  "application/vnd.ms-excel"
  end

  controller do
    before_filter -> do
      session['filter'] = {}
      session['filter'] = params['q'] if params['controller'] == 'admin/orders' && params['commit'] == '过滤'
    end, only: :index

    def scoped_collection
      (super.includes :address, :consumer, :payment_method, :line_items, :products, :customers).where(deleted: false)
    end
  end

end
