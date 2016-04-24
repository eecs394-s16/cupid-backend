# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string
#  email           :string
#  orientation     :string
#  gender          :boolean
#  image_url       :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  uid             :integer
#  last_name       :string
#  provider        :string
#  password_digest :string
#  access_token    :string
#

class User < ActiveRecord::Base
  has_many :matches
  has_many :friendships
  has_many :friends, through: :friendships
  has_secure_password

  before_save :downcase_email
  validates_uniqueness_of :email
  validates_presence_of :email, :orientation
  validates :orientation, inclusion: { in: ['straight', 'gay', 'bi'] }
  validates_confirmation_of :password

  def update_facebook_params(auth)
    self.provider = auth['provider']
    self.uid = auth['uid']

    if auth['info']
      puts auth['info'].inspect
      self.first_name = auth['info']['first_name'] || ""
      self.last_name = auth['info']['last_name'] || ""
      self.image_url = auth['info']['image'] || ""
      self.gender = auth['info']['gender'] == 'male'

      @graph = Koala::Facebook::API.new(auth['credentials']['token'])
      friends = @graph.get_connections("me", "friends", api_version: "v2.0")

      friends.each do |profile|
        next unless friend = User.find_by_uid(profile['id'])
        #next if Friendship.where(user_id: user.id, friend_id: friend.id).blank?
        Friendship.create({:user_id => auth['info']['uid'],:friend_id => profile['id']})
      end

    end
  end

  def get_votable_match
    # votable matches, whether voted on or not
    votable_matches = Match.where.not(user_1_id: id).where.not(user_2_id: id)
    # matches I've voted on - this will be slow because it's not sql
    matches_ive_voted_on = Vote.where(user_id: id).all.map(&:match_id)

    # postgres specific
    match = votable_matches.where.not(id: matches_ive_voted_on).order("RANDOM()").first
    # if it is not an empty match
    unless match.blank?
      return {
        'match_id': match.id,
        'user_id': id,
        'user_name': full_name,
        'users': [
           {'name': match.user1.full_name, 'profile_picture': match.user1.image_url},
           {'name': match.user2.full_name, 'profile_picture': match.user2.image_url},
        ]
      }

    # otherwise return match_id equals null
    else
      return {
          'match_id': false
        }
    end
  end



  def get_votable_match_for_user(user_id)
    # votable matches, whether voted on or not
    votable_matches = Match.where(user_1_id: user_id).where.not(user_2_id: id)
    # matches I've voted on - this will be slow because it's not sql
    matches_ive_voted_on = Vote.where(user_id: id).all.map(&:match_id)

    # postgres specific
    match = votable_matches.where.not(id: matches_ive_voted_on).order("RANDOM()").first
    # if it is not an empty match
    unless match.blank?
      return {
        'match_id': match.id,
        'user_id': id,
        'user_name': full_name,
        'users': [
           {'name': match.user1.full_name, 'profile_picture': match.user1.image_url},
           {'name': match.user2.full_name, 'profile_picture': match.user2.image_url},
        ]
      }

    # otherwise return match_id equals null
    else
      return {
          'match_id': false
        }
    end
  end


  def get_next_user(prev_user_id)
    # Get the previous user
    prev_user=User.where(id: prev_user_id).take
    if prev_user.blank?
      return {
          "match_id": false,
          "error": "No user matches user_id: "+ prev_user_id
        }
    end
    # Get the next user who is not "me" and is the next in alphabetical order.
    next_user=User.where.not(id: id).where('first_name > ?', prev_user.first_name).order('first_name ASC').first()
    unless next_user==nil
      # If there is some user ordered next in alphabetical order.

      return_data = get_votable_match_for_user(next_user.id)
    else
      # Otherwise, first check if there is any votable match
      votable_match=get_votable_match()
      # If there is, continue, Otherwise, return match_id=false.
      if votable_match['match_id']==false
        return {
          'match_id': false,
          "error": "You've matched all of your friends. Get more friends to register for the app!"
        }
      end

      # just grab the first user from the alphabetical list.
      next_user=User.where.not(id: id).order('first_name ASC').first
      unless next_user==nil
        return_data = get_votable_match_for_user(next_user.id)
      else
        # if there is no user at all, return match_id=false.
        return {
          'match_id': false,
          "error": "Are you the only user for the app?"
        }
      end
    end

    # The return data can be 'match_id': false, meaning we've exhausted all the matches for that user. in that case, recursively call get_next_user
    if return_data['match_id']==false
      return get_next_user(next_user.id)
    else
      return return_data
    end
  end


  def get_prev_user(curr_user_id)
    # Get the previous user
    curr_user=User.where(id: curr_user_id).take
    if curr_user.blank?
      return {
          "match_id": false,
          "error": "No user matches user_id: "+ curr_user_id
        }
    end
    # Get the next user who is not "me" and is the next in alphabetical order.
    prev_user=User.where.not(id: id).where('first_name < ?', curr_user.first_name).order('first_name DESC').first()
    unless prev_user==nil
      # If there is some user ordered next in alphabetical order.

      return_data = get_votable_match_for_user(prev_user.id)
    else
      # Otherwise, first check if there is any votable match
      votable_match=get_votable_match()
      # If there is, continue, Otherwise, return match_id=false.
      if votable_match['match_id']==false
        return {
          'match_id': false,
          "error": "You've matched all of your friends. Get more friends to register for the app!"
        }
      end

      # just grab the first user from the alphabetical list.
      prev_user=User.where.not(id: id).order('first_name DESC').first
      unless prev_user==nil
        return_data = get_votable_match_for_user(prev_user.id)
      else
        # if there is no user at all, return match_id=false.
        return {
          'match_id': false,
          "error": "Are you the only user for the app?"
        }
      end
    end

    # The return data can be 'match_id': false, meaning we've exhausted all the matches for that user. in that case, recursively call get_prev_user
    if return_data['match_id']==false
      return get_prev_user(prev_user.id)
    else
      return return_data
    end
  end


  def downcase_email
    self.email.downcase!
  end

  def full_name
    if first_name!=nil
      if last_name!=nil
        return first_name + ' ' + last_name
      else
        return first_name
      end
    else
      if last_name!=nil
        return last_name
      else
        return ''
      end
    end

  end

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
    self.save
    return self.access_token
  end
end
