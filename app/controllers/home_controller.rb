class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    a
  end

  def a
    0
  end
end
