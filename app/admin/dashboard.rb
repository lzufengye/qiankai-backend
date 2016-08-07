ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      # span class: "blank_slate" do
        # span I18n.t("active_admin.dashboard_welcome.welcome")
        # small I18n.t("active_admin.dashboard_welcome.call_to_action")
      # end
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
  end # content

  controller do
    before_filter -> do
      @user_data = "Hello"
    end
  end
end
