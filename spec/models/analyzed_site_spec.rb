require 'rails_helper'

RSpec.describe AnalyzedSite, type: :model do
  it 'should changes status correctly' do
    expect(subject).to transition_from(:queued).to(:approved).on_event(:approve)
    expect(subject).to transition_from(:queued).to(:rejected).on_event(:reject)
    expect(subject).to transition_from(:approved).to(:queued).on_event(:queue)
    expect(subject).to transition_from(:rejected).to(:queued).on_event(:queue)

    expect(subject).not_to transition_from(:approved).to(:rejected).on_event(:queue)
    expect(subject).not_to transition_from(:rejected).to(:approved).on_event(:queue)
    expect(subject).not_to transition_from(:queued).to(:rejected).on_event(:approve)
    expect(subject).not_to transition_from(:queued).to(:approved).on_event(:reject)
  end
end
