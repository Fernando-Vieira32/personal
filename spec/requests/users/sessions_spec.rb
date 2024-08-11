# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'UsersSessions', tye: :request do
  let(:user) { create(:user) }
  describe 'GET sign_in' do
    subject(:get_sign_in) { get new_user_session_path }

    it_behaves_like 'a request'
  end
  describe 'POST sign_in' do
    context 'with valid credentials' do
      subject(:post_sign_in) do
        post user_session_path, params: { user: { email: user.email, password: user.password } }
      end

      it { post_sign_in and expect(response).to redirect_to(root_path) }
    end
  end

  describe 'DELETE sign_out' do
    subject(:sign_out) { delete destroy_user_session_path }
    before { sign_in(user) }
    it { sign_out and expect(response).to redirect_to(root_path) }
  end
end
