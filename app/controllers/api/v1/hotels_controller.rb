class Api::V1::HotelsController < ApiController
  def index
    @hotels = paginate Hotel.all, per_page: params[:limit] || 10
  end

  def show
    @hotel = Hotel.find(params['id'].to_i)
  end
end
