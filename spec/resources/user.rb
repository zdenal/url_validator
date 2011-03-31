class User
  include ActiveModel::Validations

  attr_accessor :website

  validates :website, :url => true
end

