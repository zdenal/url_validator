class UserWithAr < ActiveRecord::Base
  self.table_name = "users"

  validates :website, :url => true
end

