
class User < ActiveRecord::Base

  def self.create_with_omniauth(auth)
    create! do |user|
    user.provider = auth['provider']
    user.uid = auth['uid']
    if auth['info']
      user.name = auth['info']['name'] || ""
      user.email = auth['info']['email'] || ""
      @graph = Koala::Facebook::API.new(auth['credentials']['token'])
      #@graph = Koala::Facebook::API.new("CAACEdEose0cBALPBwf3Ul6eF5zHmZCMviukG74i5NGJANHfFgMLAwmYwPZAFRVbIMFkX2xTNiZCXyCTCKeh5ZAk5iTyaa2MKtK5Kampo0ROq1gqgUtc4hdPlxX6BwZC7gl520iwWNSU2f0I8ZCogmIwXKSFrZCZCfyZBo7JgUzvsHhWZCX2LrLj8GgBX79S8paVVVZCJXN0XfwvyAZDZD")
      friends = @graph.get_connections("me", "friends")
      profile = @graph.get_object("me")
      puts "!!!!!!!!!!!"
      puts friends
      puts profile
    end
  end
end
end
