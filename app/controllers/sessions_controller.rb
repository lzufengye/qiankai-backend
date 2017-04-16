class SessionsController < Devise::SessionsController
  respond_to :json
  # https://github.com/plataformatec/devise/blob/master/app/controllers/devise/sessions_controller.rb
  # POST /resource/sign_in
  # Resets the authentication token each time! Won't allow you to login on two devices
  # at the same time (so does logout).

  def create

    self.resource = warden.authenticate(auth_options)
    unless (resource)
      return render json: {
          message: '请输入正确的用户名或密码',
          status: 401
      }
    end
    sign_in(resource_name, resource)

    render json: {
        consumer: current_consumer,
        status: :ok
    }
  end

  # DELETE /resource/sign_out
  def destroy

    respond_to do |format|
      format.json {
        if current_consumer
          current_consumer.update authentication_token: nil
          signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
          render :json => {}.to_json, :status => :ok
        else
          render :json => {}.to_json, :status => :unprocessable_entity
        end
      }
    end
  end
end