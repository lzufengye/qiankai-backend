# ActiveAdmin.register CreateSpace do
#   menu parent:'开街创谷'
#   permit_params :introduction, :policy, :support
#
#   index do
#     selectable_column
#     id_column
#     column :introduction
#     column :policy
#     column :support
#     column :created_at
#     actions
#   end
#
#   filter :introduction
#   filter :policy
#   filter :support
#   filter :created_at
#
#   form do |f|
#     f.inputs "Admin Details" do
#       f.input :introduction
#       f.input :policy
#       f.input :support
#     end
#     f.actions
#   end
#
# end
