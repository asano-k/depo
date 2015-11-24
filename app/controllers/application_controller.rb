class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :now#, if: :whitelist
  before_action :authorize, :find_user

  def now
    @time = Time.now
  end

  private
    def find_user
      @user = User.find_by(id: session[:user_id])
    end

    def authorize
      unless find_user
      # unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "ログインしてください"
      end
    end

    def whitelist
      %w{store products carts}.include?(controller_name)
    end

    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

end
