class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :blogs, dependent: :destroy
  has_many :blog_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :relationships, foreign_key: :following_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :follower

  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: :follower_id, dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :following

  def followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width,height]).processed
  end

  def self.search_for(word, method)
    if method == 'perfect'
      User.where(name: word)
    elsif method == 'foward'
      User.where('name LIKE?', word + '%')
    elsif method == 'backword'
      User.where('name LIKE?', '%' + word)
    else
      User.where('name LIKE?', '%' + word + '%')
    end
  end



end
