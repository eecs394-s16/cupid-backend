# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  email       :string
#  orientation :string
#  gender      :boolean
#  image_url   :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class User < ActiveRecord::Base
  has_many :matches

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name, :email, :orientation, :image_url
  validates :orientation, inclusion: { in: ['straight', 'gay', 'bi'] }

  def full_name
    first_name + ' ' + last_name
  end
end
