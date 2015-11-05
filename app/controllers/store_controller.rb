class StoreController < ApplicationController
  skip_before_action :authorize
  include ActionView::Helpers::TextHelper
  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
    @count = view_counter
    @shown_message = "You’ve been here " + pluralize(@count, "time") if session[:counter] >5
  end

  def view_counter
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end

end
