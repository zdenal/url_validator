class UserWithBlank
  include ActiveModel::Validations

  attr_accessor :website, :url

  validates_url :website, :url, :allow_blank => true
end

