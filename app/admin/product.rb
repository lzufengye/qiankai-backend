ActiveAdmin.register Product do
  menu parent:'开街商城'

  permit_params :cash_on_delivery, :sold_number, :display_order, :stock_number, :name, :image_url, :description, :free_ship, :price, :unit, :link, :on_sale, :product_detail, :customer_id, :service, tag_ids: [],
                product_images_attributes: [:id, :image, :_destroy], product_details_attributes: [:id, :image, :_destroy],
                services_attributes: [:id, :image, :_destroy], skus_attributes: [:id, :name, :price]

  actions :all, except: [:destroy]

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :unit
    column :free_ship
    column :on_sale
    column :stock_number
    column :sold_number
    column :display_order
    column :cash_on_delivery
    actions
  end

  filter :customer
  filter :description
  filter :name
  filter :price
  filter :unit
  filter :free_ship
  filter :on_sale
  filter :tags
  filter :stock_number
  filter :sold_number
  filter :display_order
  filter :cash_on_delivery
  filter :created_at

  form do |f|
    f.inputs "详情" do
      f.input :name
      f.input :description
      f.input :price
      f.input :unit
      f.input :free_ship
      if current_admin_user.admin?
        f.input :on_sale
      end
      f.input :stock_number
      if current_admin_user.admin?
        f.input :sold_number
      end
      if current_admin_user.admin?
        f.input :display_order
      end
      f.input :cash_on_delivery, as: :select, collection: [ ['仅支持货到付款', '仅支持货到付款'], ['支持货到付款', '支持货到付款'], ['不支持货到付款', '不支持货到付款'] ]

      f.inputs '标签' do
        TagCategory.all.each do |tag_category|
          f.input :tags, as: :check_boxes, collection: tag_category.tags, label: "-- #{tag_category.name}"
        end
      end
      if current_admin_user.admin?
        f.input :customer, as: :select, collection: Customer.all
      else
        f.input :customer_id, :input_html => { value: current_admin_user.customer_id }, as: :hidden
      end
      f.inputs '图片' do
        f.has_many :product_images, heading: false, allow_destroy: true do |a|
          a.input :image, as: :file, hint: (a.template.image_tag(a.object.image.url(:small)) if a.object.image.exists? unless a.object.new_record?)
        end
      end
      f.inputs '商品详情' do
        f.has_many :product_details, heading: false, allow_destroy: true do |a|
          a.input :image, as: :file, hint: (a.template.image_tag(a.object.image.url(:small)) if a.object.image.exists? unless a.object.new_record?)
        end
      end
      f.inputs '售后服务' do
        f.has_many :services, heading: false, allow_destroy: true do |a|
          a.input :image, as: :file, hint: (a.template.image_tag(a.object.image.url(:small)) if a.object.image.exists? unless a.object.new_record?)
        end
      end

      f.inputs '品项' do
        f.has_many :skus, heading: false, allow_destroy: true do |a|
          a.input :name
          a.input :price
        end
      end

    end
    f.actions
  end

end
