# == Schema Information
#
# Table name: road_shows
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  text       :text(65535)
#  video_link :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class RoadShow < ActiveRecord::Base
end
