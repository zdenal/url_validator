class User
  include ActiveModel::Validations

  attr_accessor :website, :url

  validates_url :website, :url, :message => 'aaaaa'
end

