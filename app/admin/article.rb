ActiveAdmin.register Article do
  permit_params :title, :text

  index do
    selectable_column
    id_column
    column :title
    column :text
    column :created_at
    actions
  end

  filter :title
  filter :text
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :title
      f.input :text
    end
    f.actions
  end

end
