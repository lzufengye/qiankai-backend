class Api::V1::TransactionsController < ApiController
  before_action :authenticate_consumer_from_token!, only: [:new, :charge]
  before_action :authenticate_consumer!, only: [:new, :charge]
  before_action :validate_payment_request, only: [:charge]

  rescue_from Pingpp::APIConnectionError, with: :handle_ping_xx_connection_error

  def new
    if params[:sn].nil? || (order = Order.find_by_sn(params[:sn])).try(:consumer) != current_consumer || order.state == '已支付'
      @error = 'Invalid payment request'
      return render :error
    end

    if params[:channel].nil?
      @error = 'Channel not provided'
      return render :error
    end

    order = Order.find_by_sn(params[:sn])
    ip = request.remote_ip
    @charge = PingPPService.create_payment(order, ip, params[:channel], params[:success_url])
  end

  def charge
    @charge = PingPPService.create_payment_for_multiple_orders(params[:sns], '192.168.1.1', params[:channel], params[:success_url])

    unless @charge
      @error = 'Invalid payment request'
      return render :error
    end
    render :new
  end

  def create
    order_group_name = 'ORDERGROUP'

    if params['data']['object']['order_no'].start_with?(order_group_name)
      order_no = params['data']['object']['order_no']
      order_group_id = order_no.slice(order_group_name.length, order_no.length - order_group_name.length)
      orders = OrderGroup.find(order_group_id).try(:orders) || []
      raise Exception  if orders.select {|order| order.consumer != current_consumer}.present? || orders.select {|order| order.paid?}.present?
      orders.each {|order| order.update_attributes(state: '已支付')}
    else
      order = Order.find_by_sn(params['data']['object']['order_no'])
      raise Exception if order.paid?
      order.update_attributes(state: '已支付')
    end

    Transaction.create!(pingpp_id: params['id'],
                        order_sn: params['data']['object']['order_no'],
                       status: params['data']['object']['paid'],
                       transaction_type: params['type'],
                       amount: params['data']['object']['amount'])

    return render json: {status: 200}

  rescue Exception
    render json: {status: 500}
  end

  def validate_payment_request
    if params[:sns].nil? || params[:channel].nil?
      @error = 'Invalid parameters'
      return render :error
    end

    orders = params[:sns].map {|sn| Order.find_by_sn(sn)}
    if orders.select {|order| order.consumer != current_consumer}.present? || orders.select {|order| order.paid?}.present?
      @error = 'Invalid payment request'
      return render :error
    end
  end

  private
  def handle_ping_xx_connection_error
    @error = '连接超时'
    return render :error
  end
end
