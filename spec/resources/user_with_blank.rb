class UserWithBlank
  include ActiveModel::Validations

  attr_accessor :website

  validates_url :website, :allow_blank => true
end

