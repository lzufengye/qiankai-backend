ActiveAdmin.register Customer do
  menu parent:'开街商城'
  permit_params :name, :description, :phone, admin_users_attributes: [:id, :name, :email, :password, :password_confirmation, :_destroy], attachments_attributes: [:id, :image, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column :description do |customer|
      truncate(customer.description)
    end
    column :phone
    column :admin_users do |customer|
      customer.admin_users.map(&:name).join(', ')
    end
    column :created_at
    actions
  end

  filter :description
  filter :name
  filter :phone
  filter :created_at

  show do
    attributes_table do
      row :name
      row :description
      row :phone
    end

    panel('商户管理员') do
      table_for(customer.admin_users) do
        column :id
        column :name
        column :email
      end
    end

    panel('图片') do
      table_for(customer.attachments) do
        column :image do |attachment|
          image_tag attachment.image.url(:small)
        end
      end
    end
  end

  form do |f|
    f.inputs '商户详情' do
      f.input :name
      f.input :phone
      f.input :description

      f.inputs '商户管理员' do
        f.has_many :admin_users, heading: false, allow_destroy: true do |a|
          a.input :name
          a.input :email
          a.input :password
          a.input :password_confirmation
        end
      end

      f.inputs '图片' do
        f.has_many :attachments, heading: false, allow_destroy: true do |a|
          a.input :image, as: :file, label: '图片(请上传尺寸为363 x 300)'
        end
      end
    end
    f.actions
  end
end
