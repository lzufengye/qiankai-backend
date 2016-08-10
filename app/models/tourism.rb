# == Schema Information
#
# Table name: tourisms
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text(65535)
#  content     :text(65535)
#  created_at  :datetime
#  updated_at  :datetime
#  phone       :string(255)
#

class Tourism < ActiveRecord::Base
  has_and_belongs_to_many :tourism_tags
  has_many :attachments, as: :attachable
  accepts_nested_attributes_for :attachments, allow_destroy: true
end
