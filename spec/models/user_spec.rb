# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it { expect(User.superclass).to eq(ApplicationRecord) }
  end
end
