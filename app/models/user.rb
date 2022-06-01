class User < ApplicationRecord 
  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy

  before_save :create_password_digest

  attr_accessor :password, :password_confirmation,
                :remember_token
  validates :name, presence: true, length: { maximum: 64 }, 
                                   uniqueness: true
  validates :state, presence: true
  validate :valid_password

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end

    def new_cookie_user
      user = User.new
      user.name = User.new_token
      user.remember_token  = User.new_token
      user.remember_digest = User.digest(user.remember_token)
      user.be :cookie
      user
    end
  end

  def initialize(params = {})
    super
    self.be(:normal) if self.state.nil?
    self
  end

  def authenticate?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def admin?
    state == 1
  end

  def cookie?
    state == 2
  end

  def normal?
    state == 3
  end

  def is?
    if cookie?
      :cookie
    elsif normal?
      :normal
    elsif admin?
      :admin
    end
  end

  def be(state)
    if state == :admin
      self.state = 1
    elsif state == :cookie
      self.state = 2
    elsif state == :normal
      self.state = 3
    end
  end

  def feed
    Post.where("user_id = ?", id)
  end

  private

    def valid_password
      if cookie?
        return
      elsif password.nil? && id.nil?
        errors.add(:password, :nil)
      elsif password.nil? && !password_confirmation.nil?
        errors.add(:password, :not_same)
      elsif !password.nil? && password_confirmation.nil?
        errors.add(:password, :not_same)
      elsif !password.nil? && !password_confirmation.nil?
        errors.add(:password, :blank) if password.blank?
        errors.add(:password, :not_same) if password != password_confirmation
        errors.add(:password, :too_short) if password.length < 8
        errors.add(:password, :too_long) if password.length > 32
      end
    end

    def create_password_digest
      if !password.nil?
        self.password_digest = User.digest(password)
      end
    end
end
