class UserWithBlank
  include ActiveModel::Validations

  attr_accessor :website

  validates :website, :url => {:allow_blank => true}
end

