class Wiki < ApplicationRecord
  belongs_to :user

  after_initialize { self.private ||= false }
end
