require 'rubygems'
require 'pry'
require 'nokogiri'
require 'open-uri'
require 'digest/sha1'
require 'json'

class NewsNow 
  attr_accessor :connect, :news

  def initialize
    @newsnow_url = "http://www.newsnow.co.uk/h/Sport/Football/Premier+League/Manchester+United"
    @old_sha_file = './latest_output'.chomp()
    @connect = self.connect_to_newsnow()
    @news = self.parse_newsnow_links()
    self.old_news_sha()
    self.set_old_news_sha()
  end

  def connect_to_newsnow
    news_now_page = Nokogiri::HTML(open(@newsnow_url))
    return news_now_page
  end

  def parse_newsnow_links
    local_news = @connect.xpath('//div[@i]/a').collect {|news_item| 
      {
        href: news_item['href'],
        text: news_item.content,
        sha:  Digest::MD5.hexdigest(news_item.content)
      } 
    }
  end

  def set_old_news_sha
    File.open(@old_sha_file, 'w') { |f|
      f.write @news.first[:sha]
    }
  end

  def old_news_sha
    File.read(@old_sha_file).chomp
  end

end

a=NewsNow.new
binding.pry
