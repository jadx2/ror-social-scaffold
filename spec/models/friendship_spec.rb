require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'belongs to different users' do
    it 'should belong to user that sent invitation' do
      should belong_to(:sent_to)
    end
    it 'should belong to user that received invitation' do
      should belong_to(:sent_by)
    end
  end
end
