class UserWithPrefferedSchema
  include ActiveModel::Validations

  attr_accessor :website, :url

  validates_url :website, :preffered_schema => 'https://'
end

