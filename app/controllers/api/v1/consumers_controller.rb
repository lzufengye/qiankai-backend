class Api::V1::ConsumersController < ApiController
  before_action :authenticate_consumer_from_token!
  before_action :authenticate_consumer!

  def show
    @consumer = current_consumer
  end

  def update
    @consumer = current_consumer

    if (consumer_reset_password_params)
      raise UnauthorizedException unless consumer_reset_password_params[:password] == consumer_reset_password_params[:password_confirmation]
      @consumer.update_attributes(password: consumer_reset_password_params[:password])
    end

    @consumer.update_attributes(consumer_update_params)
    if @consumer.save
      render :show
    else
      @error = @consumer.errors.messages
      render :error
    end
  end

  private
  def consumer_update_params
    params.require(:consumer).permit(:user_name, :phone).except(:created_at, :updated_at)
  end

  def consumer_reset_password_params
    params.require(:consumer).permit(:password, :password_confirmation).except(:email, :phone)
  end
end
