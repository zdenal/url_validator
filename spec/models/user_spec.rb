# coding: utf-8

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

    it "should not allow blank as url" do
      @user.website = ''
      @user.should_not be_valid
    end

    it "should sanitize space in url" do
      @user.website = "web.asd dot.com"
      @user.should be_valid
    end

    it "should sanitize space in url" do
      @user.website = "webasd\tdot.com"
      @user.should be_valid
    end

    ["htt://www.website.com", "htttp://www.website.com"].each do |url|
      it "should not accept invalid #{url}" do
        @user.website = url
        @user.should_not be_valid
      end
    end

    it "should accept different kind of valid URLs" do
      ["http://www.website.com", "https://www.website.com/",
        "www.website.com", "website.com"].each do |url|
        @user.website = url
        @user.should be_valid
      end
    end

    it "website.com should be valid" do
      @user.website = 'website.com'
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "wEbsIte.coM should be valid" do
      @user.website = 'wEbsIte.coM'
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "http://12pointdesign.com/advice/dashes_vs_underscores.asp should be valid" do
      @user.website = 'http://12pointdesign.com/advice/dashes_vs_underscores.asp'
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "stage.website.com/m/65/John_Oconer should be valid" do
      @user.website = 'stage.website.com/m/65/John_Oconer'
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "http://website.com/~smith//// should be valid" do
      @user.website = 'http://website.com/~smith////'
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "www.website.com/~smith//// should be valid" do
      @user.website = 'www.website.com/~smith////'
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "website.com/~smith//a// should be valid" do
      @user.website = 'website.com/~smith//a//'
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "website with  '.travel' should be valid" do
      @user.website = 'somesite.travel'
      @user.should be_valid
    end

  end

  context "with allow blank" do
    before do
      @user = UserWithBlank.new
    end

    it "should allow nil as url" do
      @user.website = nil
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "should allow blank as url" do
      @user.website = ""
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "should allow a valid url" do
      @user.website = "http://www.website.com"
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "should return correct data" do
      @user.website = "website.com"
      @user.url = "website.com/blog"
      @user.should be_valid
      @user.website.should == "http://website.com"
      @user.url.should == "http://website.com/blog"
    end

  end

  context "with ActiveRecord" do
    before do
      @user = UserWithAr.new
    end

    it "should not allow invalid url: website" do
      @user.website = "ftp://website.com"
      @user.should_not be_valid
      @user.errors[:website].should_not be_empty
    end
  end

  context "with regular validator and custom scheme ftp://" do
    before do
      @user = UserWithCustomScheme.new
    end

    it "should allow alternative URI schemes" do
      @user.website = "ftp://ftp.website.com"
      @user.should be_valid
    end

    it "website.com should not be valid - scheme is ftp" do
      @user.website = 'http://website.com'
      @user.should_not be_valid
    end

  end

  context "check validate with different charset" do
    before do
      @user = UserWithAr.new
    end

    it "should be valid http://www.中国政府.政务.cn" do
      @user.website = "http://www.中国政府.政务.cn"
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "should be valid www.詹姆斯.com" do
      @user.website = "www.詹姆斯.com"
      @user.should be_valid
      @user.errors[:website].should be_empty
    end

    it "should not be valid http://www.詹姆斯.c" do
      @user.website = "ftp://www.詹姆斯"
      @user.should_not be_valid
      @user.errors[:website].should_not be_empty
    end

  end

  context "check normalizing" do
    before do
      @user = User.new
    end

    it "should convert correctly http://website.com/~smith/" do
      @user.website = "http://website.com/~smith/"
      @user.website_normalized.should == "http://website.com/~smith/"
    end

    it "should convert correctly website.com" do
      @user.website = "website.com"
      @user.website_normalized.should == "website.com"
    end

    it "should be equivalent to リ宠퐱卄.com" do
      @user.website = "リ宠퐱卄.com"
      @user.website_normalized.should == "xn--eek174hoxfpr4k.com"
    end

    it "should be equivalent to www.詹姆斯.com" do
      @user.website = "www.詹姆斯.com"
      @user.website_normalized.should == "www.xn--8ws00zhy3a.com"
    end

    it "should convert 'www.Iñtërnâtiônàlizætiøn.com' correctly" do
      @user.website = "www.Iñtërnâtiônàlizætiøn.com"
      @user.website_normalized.should == "www.xn--itrntinliztin-vdb0a5exd8ewcye.com"
    end
  end

  context "when custom message is set" do
    before do
      @user = User.new
    end

    it "should show correct message" do
      @user.valid?
      @user.errors[:website].join.should == 'bad bad URL'
    end
  end

  context "when custom message is not set" do
    before do
      @user = UserWithAr.new
    end

    it "should show correct message" do
      @user.valid?
      @user.errors[:website].join.should == 'is not a valid URL'
    end
  end

  context "automated preffilling prefix - preffill if didnt exists" do
    before do
      @user = User.new
      @user.website = 'website.com'
      @user_with_s = UserWithPrefferedSchema.new
      @user_with_s.website = 'website.com'
    end

    it "should preffill http:// to url" do
      @user.should be_valid
      @user.website.start_with?('http://').should be_true
    end

    it "should preffill https:// to url" do
      @user_with_s.should be_valid
      @user_with_s.website.start_with?('https://').should be_true
    end
  end

  context "automated preffilling prefix - dont preffill if exist" do
    before do
      @user = User.new
      @user.website = 'http://website.com'
      @user_with_s = UserWithPrefferedSchema.new
      @user_with_s.website = 'https://website.com'
    end

    it "should not preffill http://" do
      @user.should be_valid
      @user.website.should == 'http://website.com'
      @user.website = 'https://website.com'
      @user.valid?
      @user.website.should == 'https://website.com'
    end

    it "should not preffill https://" do
      @user_with_s.should be_valid
      @user_with_s.website.should == 'https://website.com'
      @user_with_s.website = 'http://website.com'
      @user.valid?
      @user_with_s.website.should == 'http://website.com'
    end
  end

end

