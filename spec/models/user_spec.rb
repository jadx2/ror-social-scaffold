require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Abdul', email: 'abdul123@gmail.com', password: '123456') }
  context 'validation of user' do
    it 'validates if name is present' do
      expect(subject).to be_valid
    end
    it 'rejects if name not present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
    it 'rejects if email not present' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
    it 'rejects if password not present' do
      subject.password = nil
      expect(subject).to_not be_valid
    end
  end

  context 'User Associations' do
    it 'It has create many posts' do
      should have_many(:posts)
    end
    it 'It has many post comments' do
      should have_many(:comments)
    end
    it 'It has many post likes' do
      should have_many(:likes)
    end
    it 'It has requested many friendships' do
      should have_many(:friend_request)
    end
    it 'It has sent many friendship requests' do
      should have_many(:friend_sent)
    end
    it 'It has many notifications' do
      should have_many(:notifications)
    end
  end
end
