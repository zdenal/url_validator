class User
  include ActiveModel::Validations

  attr_accessor :website

  validates_url :website, :message => 'bad bad URL'
end

