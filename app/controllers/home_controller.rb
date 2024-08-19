class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    x
  end

  def x
    10
  end
end
