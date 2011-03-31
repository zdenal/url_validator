class UserWithCustomScheme
  include ActiveModel::Validations

  attr_accessor :website

  validates :website, :url => { :schemes => ['ftp'] }
end

