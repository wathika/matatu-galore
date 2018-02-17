class User < ApplicationRecord
  acts_as_voter
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  validates :username, presence: true, length: { minimum: 4, maximum: 16 }, uniqueness: {case_sensitive: false}
  # Only allow letter, number, underscore and punctuation.
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  has_attached_file :avatar, styles: { medium: "152x152#" }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  #overwrite find_for_database_authentication method
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      conditions[:email].downcase! if conditions[:email]
      if conditions[:username].nil?
        where(conditions.to_h).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
end
