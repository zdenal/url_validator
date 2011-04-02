class UserWithAr < ActiveRecord::Base
  self.table_name = "users"

  validates_url :website
end

