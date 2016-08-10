class Api::V1::AdvertisementsController < ApiController

  def index
    @advertisements = Advertisement.all.sort_by(&:rank)
  end

end
