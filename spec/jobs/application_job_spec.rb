# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  subject(:instance_job) { described_class.new }
  it { expect { instance_job }.not_to raise_error }
end
