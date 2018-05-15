require 'net/http'
require "rss"
require 'open-uri'
require 'kconv'
require 'active_support/core_ext/hash/conversions'
require 'nokogiri'
require "date"

task :update_db => :environment do
  Article.where.not(is_hold: true).destroy_all
  #### Qiita
  # http://kzfm-s.hateblo.jp/entry/2015/06/07/014735
  url = "https://qiita.com/tags/Python/feed"
  xml  = open(url).read.toutf8
  hash = Hash.from_xml(xml)
  articles = hash["feed"]["entry"]

  articles.each do |article|
    art = Article.new
    dt = DateTime.parse(article['updated'])
    
    art.attributes = {
      url: article['link']['href'],
      title: article['title'],
      image_url:'/images/increments-square.png',
      date: dt,
      site_name: 'Qiita',
      is_hold: 0
    }
    if art.save
      next
    end
  end
  ####
  
  #### google news
  # https://www.buildinsider.net/language/rubytips/0016
  # https://feed.mikle.com/ja/support/google-news-rss/
  url = 'https://news.google.com/news/rss/search/section/q/%E6%A9%9F%E6%A2%B0%E5%AD%A6%E7%BF%92/%E6%A9%9F%E6%A2%B0%E5%AD%A6%E7%BF%92?hl=ja&gl=JP&ned=jp'
  rss = RSS::Parser.parse(url)
  rss.channel.items.each do|article|
    art = Article.new
    # htmlをパース(解析)してオブジェクトを生成
    doc = Nokogiri::HTML.parse(article.description, nil)
    dt = DateTime.parse(article.pubDate.to_s)
    if doc.xpath("html/body/table/tr/td/img").nil?
      img_url = nil
    else
      img_url = doc.xpath("html/body/table/tr/td/img").attribute('src').value
    end
    art.attributes = {
      url: article.link,
      title: article.title,
      image_url: img_url,
      date: dt,
      site_name: 'GoogleNews',
      is_hold: 0
    }
    if art.save
      next
    end
  end

  
end