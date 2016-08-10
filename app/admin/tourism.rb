ActiveAdmin.register Tourism do
  menu parent:'旅游'
  permit_params :title, :description, :phone, :content, tourism_tag_ids: [],
                attachments_attributes: [:id, :image, :_destroy]

  index do
    selectable_column
    id_column
    column :title
    column :phone
    column :description do |tourism|
      truncate(tourism.description)
    end
    column :content do |tourism|
      truncate(tourism.content)
    end
    column :created_at
    actions
  end

  filter :title
  filter :description
  filter :created_at

  form do |f|
    f.inputs '景点详情' do
      f.input :title
      f.input :phone
      f.input :description
      f.input :content, as: :rich, config: { width: '76%', height: '400px' }
      f.inputs '图片' do
        f.has_many :attachments, heading: false, allow_destroy: true do |a|
          a.input :image, as: :file, hint: (a.template.image_tag(a.object.image.url(:small)) if a.object.image.exists? unless a.object.new_record?)
        end
      end
      f.input :tourism_tags, as: :check_boxes, collection: TourismTag.all
    end
    f.actions
  end

end
