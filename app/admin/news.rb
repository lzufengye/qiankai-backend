ActiveAdmin.register News do
  menu parent:'便民生活'

  permit_params :title, :text,
                attachments_attributes: [:id, :image, :_destroy]

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
    f.inputs "资讯详情" do
      f.input :title
      f.input :text, as: :rich, config: { width: '76%', height: '400px' }
      f.inputs '图片' do
        f.has_many :attachments, heading: false, allow_destroy: true do |a|
          a.input :image, as: :file, hint: (a.template.image_tag(a.object.image.url) if a.object.image.exists? unless a.object.new_record?)
        end
      end
    end
    f.actions
  end

end
