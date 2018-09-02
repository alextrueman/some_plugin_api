class AnalyzedSite < ApplicationRecord
  include AASM

  aasm :column => 'status' do
     state :queued, initial: true
     state :approved
     state :rejected

     event :approve do
      transitions from: :queued, to: :approved
    end

    event :reject do
      transitions from: :queued, to: :rejected
    end

    event :queue do
      transitions from: :approved, to: :queued
      transitions from: :rejected, to: :queued
    end
  end
end
