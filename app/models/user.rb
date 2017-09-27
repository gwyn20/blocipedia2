class User < ApplicationRecord
  has_many :wikis, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         
  
  before_save { self.email = email.downcase }
  before_save { validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  after_create :send_user_emails
  after_initialize :set_user
  
  def set_user
    self.role ||= :standard
  end

  enum role: [:standard, :premium, :admin]

  private
  
  def send_user_emails
    UserMailer.new_user(self).deliver_now
  end

end
