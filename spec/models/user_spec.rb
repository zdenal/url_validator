require 'spec_helper'

describe "User" do

  before(:all) do
    ActiveRecord::Schema.define(:version => 1) do

      create_table :users, :force => true do |t|
        t.column :website, :string
      end

    end
  end
  after(:all) do
    ActiveRecord::Base.connection.drop_table(:users)
  end

  context "with regular validator" do
    before do
      @user = User.new
    end

    it "should not allow nil as url" do
      @user.website = nil
      @user.should_not be_valid
    end

  end

  context "with allow blank" do
    before do
      @user = UserWithBlank.new
    end

    it "should allow nil as url" do
      @user.website = nil
      @user.should be_valid
    end

    it "should allow blank as url" do
      @user.website = ""
      @user.should be_valid
    end

    it "should allow a valid url" do
      @user.website = "http://www.example.com"
      @user.should be_valid
    end
  end

  context "with ActiveRecord" do
    before do
      @user = UserWithAr.new
    end

    it "should not allow invalid url" do
      @user.website = "random"
      @user.should_not be_valid
    end
  end

  context "with regular validator and custom scheme" do
    before do
      @user = UserWithCustomScheme.new
    end

    it "should allow alternative URI schemes" do
      @user.website = "ftp://ftp.example.com"
      @user.should be_valid
    end
  end
end

