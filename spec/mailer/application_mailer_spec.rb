# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  it { expect(ApplicationMailer.default[:from]).to eq('from@example.com') }
end
