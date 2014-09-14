require 'rails_helper'

describe User do

  it 'should be able to become active' do
    user = FactoryGirl.create(:user, :inactive)
    user.activate

    expect(user.active).to be(true)
  end

  it 'should be able to become inactive' do
    user = FactoryGirl.create(:user, :active)
    user.deactivate

    expect(user.active).to be(false)                                                                                                   
  end

  describe '@actives' do
    it 'should scope active users' do
      active_users = FactoryGirl.create_list(:user, 5, :active)
      inactive_users = FactoryGirl.create_list(:user, 5, :inactive)

      expect(User.actives).to match_array(active_users)
    end
  end
end
