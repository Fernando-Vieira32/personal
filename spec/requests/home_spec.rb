# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Home', tye: :request do
  before do
    sign_in(create(:user))
  end

  describe 'GET index' do
    subject(:index) { get root_path }

    it_behaves_like 'a request'
  end
end
