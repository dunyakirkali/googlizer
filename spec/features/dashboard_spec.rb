require 'rails_helper'

describe 'Dashboard' do

  it 'should allow the user to activate itself' do
    user = FactoryGirl.create(:user, :inactive, :with_searches)
    login_as(user)
    find('.title a').click

    expect(page).to have_content 'Googlizer active!'
  end

  it 'should allow the user to deactivate itself' do
    user = FactoryGirl.create(:user, :active, :with_searches)
    login_as(user)
    find('.title a').click

    expect(page).to have_content 'Googlizer inactive!'
  end

  it 'should allow the user to see his/her latest searches' do
    user = FactoryGirl.create(:user, :active, :with_searches)
    login_as(user)
    click_on 'searches'

    user.searches.each do |search|
      expect(page).to have_content search.query
      expect(page).to have_content search.hits
    end
  end

  it 'should allow the user to sign out' do
    user = FactoryGirl.create(:user, :active, :with_searches)
    login_as(user)
    click_on('Sign out')
    
    expect(page).to have_content('Signed out successfully.')
  end
end