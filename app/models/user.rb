class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  before_save { self.email = email.downcase }
  before_save { validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  after_create :send_user_emails
  

  private
  
  def send_user_emails
    UserMailer.new_user(self).deliver_now
  end

end
