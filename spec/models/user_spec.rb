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
=begin
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
z
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
=end
  context "with different charset" do
    before do
      @user = UserWithAr.new
    end

    it "should be valid" do
      @user.website = "http://www.中国政府.政务.cn"
      #@user.website = "http://random"
      #@user.valid?
      #@user.website = "http://random"
      #@user.website = "http://random"
      puts @user.website_normalized
      @user.valid?
      @user.save
      debugger
      puts ''
      #@user.save
      #@user.should_not be_valid
    end

  end
end

