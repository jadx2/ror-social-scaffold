require 'rails_helper'

RSpec.describe Notification, type: :model do
  context 'belong to user' do
    it 'check if notifications belongs to user' do
      should belong_to(:user)
    end
  end
end
