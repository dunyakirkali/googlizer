class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
         
  has_many :searches
  
  def self.googlize
    # require 'google/api_client'
    # client = Google::APIClient.new(
    #   :application_name => 'Example Ruby application',
    #   :application_version => '1.0.0'
    # )
    # custom_search = client.discovered_api('custom_search')
    all.map { |user|
      new_search = user.searches.create(query: RandomWord.adjs.next)
      # custom_search.execute {
      #   new_search.query
      # }
      
    }
  end
         
  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first
    unless user
      user = User.create(
         email: data["email"],
         password: Devise.friendly_token[0,20]
      )
    end
    user
  end
end
