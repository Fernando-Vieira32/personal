# frozen_string_literal: true

class ApplicationController < ActionController::Base
  layout :layout_by_resource
  def layout_by_resource
    if devise_controller?
      'authentication/application'
    else
      'application'
    end
  end
end
