require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe AnalyzerWorker, type: :worker do
  it 'should create worker' do
    expect {described_class.perform_async('')}.to change(described_class.jobs, :size).by(1)
  end
end
