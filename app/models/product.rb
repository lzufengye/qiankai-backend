# == Schema Information
#
# Table name: products
#
#  id                          :integer          not null, primary key
#  name                        :string(255)
#  image_url                   :string(255)
#  description                 :string(255)
#  price                       :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  link                        :string(255)
#  hot                         :boolean
#  product_detail_file_name    :string(255)
#  product_detail_content_type :string(255)
#  product_detail_file_size    :integer
#  product_detail_updated_at   :datetime
#  service_file_name           :string(255)
#  service_content_type        :string(255)
#  service_file_size           :integer
#  service_updated_at          :datetime
#  customer_id                 :integer
#  unit                        :string(255)
#  stock_number                :integer
#  free_ship                   :boolean          default(FALSE), not null
#

class Product < ActiveRecord::Base
  before_save :set_tag_categories

  scope :hot, -> () {
    where(hot: true)
  }

  has_and_belongs_to_many :tags
  has_many :product_images, as: :attachable
  accepts_nested_attributes_for :product_images, allow_destroy: true

  has_many :product_details, as: :attachable
  accepts_nested_attributes_for :product_details, allow_destroy: true

  has_many :services, as: :attachable
  accepts_nested_attributes_for :services, allow_destroy: true

  has_many :line_items
  has_many :orders, through: :line_items
  belongs_to :customer

  def set_tag_categories
    tag_categories = self.tags.map(&:tag_category).uniq
    tag_categories.delete(nil)
    tag_categories.map(&:present_tag).each do |tag|
      next if self.tags.include?(tag)
      self.tags << tag
    end
  end
end
