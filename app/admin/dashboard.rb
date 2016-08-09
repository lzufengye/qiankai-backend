ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      # span class: "blank_slate" do
        # span I18n.t("active_admin.dashboard_welcome.welcome")
        # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      # end
    end

    paid_order_data = Order.alive.paid.group_by{ |order| order.created_at.beginning_of_month }.map do |key, orders_by_month|
      {
          date: key.strftime('%Y-%m'),
          count: orders_by_month.count,
          cash_pay_count: orders_by_month.select{|order| order.payment_method_name == '货到付款' || !order.payment_method_name.present?}.count,
          bank_pay_count: orders_by_month.select{|order| order.payment_method_name == '银行汇款'}.count,
          online_pay_count: orders_by_month.select{|order| order.payment_method_name == '在线支付'}.count,
          total_amount: orders_by_month
                            .map(&:total_price)
                            .reduce(&:+).to_f
                            .round(2),
          cash_pay_amount: orders_by_month.select{|order| order.payment_method_name == '货到付款' || !order.payment_method_name.present?}
                               .map { |order| order.total_price}
                               .reduce(&:+).to_f
                               .round(2),
          bank_pay_amount: orders_by_month.select{|order| order.payment_method_name == '银行汇款'}
                               .map { |order| order.total_price}
                               .reduce(&:+).to_f
                               .round(2),
          online_pay_amount: orders_by_month.select{|order| order.payment_method_name == '在线支付'}
                                 .map { |order| order.total_price}
                                 .reduce(&:+).to_f
                                 .round(2)
      }
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do
      column do
        panel "注册用户" do
          ul do
            "总注册用户: #{Consumer.count}"
          end
          text_node %{<div id="users" width="500" height="300"></div>}.html_safe
          text_node %{<div id="users-data" data-registering='#{ Consumer.all.group_by{ |t| t.created_at.beginning_of_month }.map {|key, consumers_by_month| {"date" => key.strftime('%Y-%m'), "count" => consumers_by_month.count}}.to_json}'></div>}.html_safe
        end
      end

      column do
        panel "入驻商家" do
          ul do
            "总入驻商家数: #{Customer.count}"
          end
          text_node %{<div id="customers-chart" width="500" height="300"></div>}.html_safe
          text_node %{<div id="customers-chart-data" data-registering='#{ Customer.all.group_by{ |t| t.created_at.beginning_of_month }.map {|key, customers_by_month| {"date" => key.strftime('%Y-%m'), "count" => customers_by_month.count}}.to_json}'></div>}.html_safe
        end
      end
    end

    columns do
      column do
        panel "上架商品" do
          ul do
            "总上架商品: #{Product.count}"
          end
          text_node %{<div id="products-chart" width="500" height="300"></div>}.html_safe
          text_node %{<div id="products-chart-data" data-registering='#{ Product.all.group_by{ |t| t.created_at.beginning_of_month }.map {|key, products_by_month| {"date" => key.strftime('%Y-%m'), "count" => products_by_month.count}}.to_json}'></div>}.html_safe
        end
      end

      column do
        panel "订单" do
          table do
            tr do
              td do
                "订单总数: #{Order.alive.count}"
              end
              td do
                "在线支付订单数: #{Order.alive.online_payment.count}"
              end
              td do
                "货到付款订单数: #{Order.alive.cash_on_delivery.count}"
              end
              td do
                "银行汇款订单数: #{Order.alive.bank_payment.count}"
              end
            end
          end

          order_data = Order.alive.group_by{ |order| order.created_at.beginning_of_month }.map do |key, orders_by_month|
                              {
                                  date: key.strftime('%Y-%m'),
                                  count: orders_by_month.count,
                                  cash_pay_count: orders_by_month.select{|order| order.payment_method_name == '货到付款' || !order.payment_method_name.present?}.count,
                                  bank_pay_count: orders_by_month.select{|order| order.payment_method_name == '银行汇款'}.count,
                                  online_pay_count: orders_by_month.select{|order| order.payment_method_name == '在线支付'}.count,
                                  total_amount: orders_by_month
                                                  .map(&:total_price)
                                                  .reduce(&:+).to_f
                                                  .round(2),
                                  cash_pay_amount: orders_by_month.select{|order| order.payment_method_name == '货到付款' || !order.payment_method_name.present?}
                                                       .map { |order| order.total_price}
                                                       .reduce(&:+).to_f
                                                       .round(2),
                                  bank_pay_amount: orders_by_month.select{|order| order.payment_method_name == '银行汇款'}
                                                                                     .map { |order| order.total_price}
                                                                                     .reduce(&:+).to_f
                                                                                     .round(2),
                                  online_pay_amount: orders_by_month.select{|order| order.payment_method_name == '在线支付'}
                                                                                     .map { |order| order.total_price}
                                                                                     .reduce(&:+).to_f
                                                                                     .round(2)
                              }
                            end

          text_node %{<div id="orders-chart" width="500" height="300"></div>}.html_safe
          text_node %{<div id="orders-chart-data" data-registering='#{ order_data.to_json }'></div>}.html_safe
        end
      end
    end

    columns do
      column do
        panel "已支付订单" do
          table do
            tr do
              td do
                "已支付订单总数: #{Order.alive.paid.count}"
              end
              td do
                "在线支付订单数: #{Order.alive.paid.online_payment.count}"
              end
              td do
                "货到付款订单数: #{Order.alive.paid.cash_on_delivery.count}"
              end
              td do
                "银行汇款订单数: #{Order.alive.paid.bank_payment.count}"
              end
            end
          end

          text_node %{<div id="paid-orders-chart" width="500" height="300"></div>}.html_safe
          text_node %{<div id="paid-orders-chart-data" data-registering='#{ paid_order_data.to_json }'></div>}.html_safe
        end
      end

      column do
        panel "已支付订单总额" do
          table do
            tr do
              td do
                "已支付订单总额: #{Order.alive.paid.map(&:total_price).reduce(&:+).to_f.round(2)}"
              end
              td do
                "在线支付订总额: #{Order.alive.paid.online_payment.map(&:total_price).reduce(&:+).to_f.round(2)}"
              end
              td do
                "货到付款订总额: #{Order.alive.paid.cash_on_delivery.map(&:total_price).reduce(&:+).to_f.round(2)}"
              end
              td do
                "银行汇款订总额: #{Order.alive.paid.bank_payment.map(&:total_price).reduce(&:+).to_f.round(2)}"
              end
            end
          end

          text_node %{<div id="paid-orders-money-chart" width="500" height="300"></div>}.html_safe
          text_node %{<div id="paid-orders-money-chart-data" data-registering='#{ paid_order_data.to_json }'></div>}.html_safe
        end
      end

    end
  end # content

  controller do
    before_filter -> do
      @user_data = "Hello"
    end
  end
end
