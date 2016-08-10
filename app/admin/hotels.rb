ActiveAdmin.register Hotel do
  menu parent:'旅游'
  permit_params :name, :description, :phone

  index do
    selectable_column
    id_column
    column :name
    column :phone
    column :description do |hotel|
      truncate(hotel.description)
    end
    column :created_at
    actions
  end

  filter :name
  filter :phone
  filter :created_at

  form do |f|
    f.inputs '酒店详情' do
      f.input :name
      f.input :phone
      f.input :description
    end
    f.actions
  end

end
