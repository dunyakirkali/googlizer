class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :searches

  def activate
    self.update_attribute(:active, true)
  end

  def deactivate
    self.update_attribute(:active, false)
  end

  def self.googlize
    # require 'google/api_client'
    # client = Google::APIClient.new(
    #   :application_name => 'Example Ruby application',
    #   :application_version => '1.0.0'
    # )
    # custom_search = client.discovered_api('custom_search')
    all.map { |user|
      new_search = user.searches.create(query: RandomWord.adjs.next)
      if self.active
      # custom_search.execute {
      #   result = new_search.query
      # }
      end
      result = { hits: 5 }
      new_search.update_attribute(hits: result[:hits])
    }
  end

  def self.find_for_google_oauth2(access_token, signed_in_resource = nil)
    data = access_token.info
    user = User.where(email: data["email"]).first
    unless user
      user = User.create(
        email: data["email"],
        password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
