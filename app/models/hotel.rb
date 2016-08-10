# == Schema Information
#
# Table name: hotels
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  description :string(255)
#  phone       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Hotel < ActiveRecord::Base
end
