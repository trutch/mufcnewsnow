require 'minitest/spec'
require 'minitest/autorun'
require_relative '../lib/newsnow'

describe NewsNow, "Fetch fresh MUFC News" do
  before do
    @newsnow = NewsNow.new
  end
  it "should receive the MUFC News Now page successfully" do
    @newsnow.connect.must_be_instance_of Nokogiri::HTML::Document
  end
  it "should create a hash of all the news entries" do 
    @newsnow.news.last.must_be_instance_of Hash
  end
  it "should save the sha of the first (latest) news to a file" do
    @newsnow.news.first[:sha].must_equal @newsnow.old_news_sha
  end
	 
=begin
  it "can be created with no arguments" do
    NewsNow.news.must_be_instance_of Hash
  end
=end
end

#  it "can be created with a specific size" do
#    Array.new(10).size.must_equal 10
#  end
