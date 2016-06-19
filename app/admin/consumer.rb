ActiveAdmin.register Consumer do
  actions :index, :show

  index do
    selectable_column
    id_column
    column :email
    column :user_name
    column :phone
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :email
      row :user_name
      row :phone
      row :created_at
    end
  end

  filter :email
  filter :user_name
  filter :phone
  filter :created_at
end
