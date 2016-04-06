# Validator
class TimeOverlapsValidator < ActiveModel::Validator  
  def validate(record)
    time_overlaps?(record)
  end

  private

    def time_overlaps?(record)
      reservs = Reservation.where(record.table_id: table_id)
      range = record.reserved_from..record.reserved_to
      ranges = reservs.map { |r| r.reserved_from..r.reserved_to }
      if ranges.any? { |r| r.overlaps?(range) }
        errors.add(:reservations, 'not free')
      end
    end
end


# spec file

require 'spec_heleper'

class Validatable
  include ActiveModel::Model
  include ActiveModel::Validations
  attr_accessor :some_property

  validates_with TimeOverlapsValidator
end

describe TimeOverlapsValidator do
  subject { Validatable.new }

  context 'some context' do
    it 'is valid' do
      expect(subject).to be_valid
    ned

    it 'is very valid' do
      subject.stubs(some_property: whatever)
      expect(subject).to be_valid
    end
  end
end