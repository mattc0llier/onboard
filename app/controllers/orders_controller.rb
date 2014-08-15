class OrdersController < ApplicationController
  def index
  	@user = current_user
  	@orders = @user.orders.all 
  end

  def show
  	require_user
  	@user = current_user
  	@order = @user.orders.find
  end

  def new
  	require_user
  	@house = House.find(params[:house_id])
    @order = @house.orders.new
  end

  def create
  	require_user

    @house = House.find(params[:house_id])

    @order = @house.orders.new(order_params)

    @order.user = current_user

    if @order.save
  		flash[:success] = "Thanks for placing your order"
  		redirect_to orders_path

      # Set your secret key: remember to change this to your live secret key in production
      # See your keys here https://dashboard.stripe.com/account
      Stripe.api_key = Rails.application.secrets.stripe_secret

      # Get the credit card details submitted by the form
      token = @order.stripe_token

      # Create the charge on Stripe's servers - this will charge the user's card
      begin
        charge = Stripe::Charge.create(
          :amount => @order.house.price_in_pence,
          :currency => "gbp",
          :card => token,
          :description => "payinguser@example.com"
        )
      rescue Stripe::CardError => e
        # The card has been declined
      flash[:error] = e
      end


  	else
  		flash[:error] = "Something went wrong"
  		render :new
  	end
  end

  private
  def order_params
  	params.require(:order).permit(:stripe_token)
  end

end
