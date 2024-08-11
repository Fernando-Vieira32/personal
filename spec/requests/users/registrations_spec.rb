# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersRegistrations', type: :request do
  let(:user) { build(:user) }

  describe 'GET sign_up' do
    subject(:sign_up) { get new_user_registration_path }

    it_behaves_like 'a request'
  end

  describe 'POST /users' do
    subject(:sign_up) do
      post user_registration_path, params: { user: user_attributes }
    end
    let(:user_attributes) { attributes_for(:user) }
    it { sign_up and expect(response).to redirect_to(root_path) }
  end

  describe 'PATCH /users' do
    subject(:update_user) { patch user_registration_path, params: { user: new_attributes } }

    let(:new_attributes) { { email: 'newemail@example.com', current_password: user.password } }
    let(:user) { create(:user) }

    before { sign_in(user) }

    it { update_user and expect(user.reload.email).to eq('newemail@example.com') }
  end
end
