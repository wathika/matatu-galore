class Post < ApplicationRecord
  acts_as_votable
  validates :image, presence: true
  validates :user_id, presence: true
  validates :caption, length: { minimum: 3, maximum: 30 }
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_attached_file :image, styles: { :medium => "640x" }

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

  scope :of_followed_users, -> (following_users) { where user_id: following_users }
end
