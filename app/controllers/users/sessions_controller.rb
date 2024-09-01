# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    layout 'authentication/application'
  end
end
