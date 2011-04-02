class UserWithCustomScheme
  include ActiveModel::Validations

  attr_accessor :website

  validates_url :website, :schemes => ['ftp']
end

