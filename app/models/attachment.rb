# == Schema Information
#
# Table name: attachments
#
#  id                 :integer          not null, primary key
#  attachable_type    :string(255)
#  attachable_id      :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  type               :string(255)
#

class Attachment < ActiveRecord::Base
  has_attached_file :image
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }
  belongs_to :attachable, polymorphic: true

  delegate :path, :url, :content_type, to: :image

end
