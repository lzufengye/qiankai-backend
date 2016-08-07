# ActiveAdmin.register RoadShow do
#   menu parent:'开街创谷'
#   permit_params :name, :text, :video_link
#
#   index do
#     selectable_column
#     id_column
#     column :name
#     column :text
#     column :video_link
#     column :created_at
#     actions
#   end
#
#   filter :name
#   filter :text
#   filter :video_link
#   filter :created_at
#
#   form do |f|
#     f.inputs "Admin Details" do
#       f.input :name
#       f.input :text
#       f.input :video_link
#     end
#     f.actions
#   end
#
# end
