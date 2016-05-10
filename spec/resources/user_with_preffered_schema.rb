class UserWithPrefferedSchema
  include ActiveModel::Validations

  attr_accessor :website, :url

  validates_url :website, :preferred_schema => 'https://'
end

