ActiveAdmin.register VirtualTourism do
  menu parent:'旅游'
  permit_params :title, :description, :video

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :created_at
    actions
  end

  filter :title
  filter :description
  filter :created_at

  form do |f|
    f.inputs '虚拟旅游详情' do
      f.input :title
      f.input :description
      f.input :video, as: :file
    end
    f.actions
  end

end