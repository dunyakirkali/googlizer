require 'pp'
class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :searches, dependent: :destroy

  # Instance methods
  def activate
    self.update_attribute(:active, true)
  end

  def deactivate
    self.update_attribute(:active, false)
  end

  # Class methods
  def self.actives
    where(active: true)
  end

  def self.googlize
    actives.map { |user|
      require 'google/api_client'
      new_search = user.searches.create(query: RandomWord.adjs.next)
      cx = '004719035725883568351:yi8oxhuk_iu'
      client = Google::APIClient.new(key: ENV['GOOGLE_API_KEY'], authorization: nil, application_name: 'Googlize', application_version: '0.1.0')
      search = client.discovered_api('customsearch')
      result = client.execute(
        api_method: search.cse.list,
        parameters: {
          :'q' => new_search.query,
          :'cx' => cx
        }
      )
      new_search.update_attribute(:hits, result.data['searchInformation']['totalResults'])
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
