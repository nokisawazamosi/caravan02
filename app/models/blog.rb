class Blog < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :blog_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end

  def self.search_for(word, method)
    if method == 'perfect'
      Blog.where(blog_title: word)
    elsif method == 'foward'
      Blog.where('blog_title LIKE?', word + '%')
    elsif method == 'backword'
      Blog.where('blog_title LIKE?', '%' + word)
    else
      Blog.where('blog_title LIKE?', '%' + word + '%')
    end
  end

end
