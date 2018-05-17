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
    #### 
    
    #### rakuten Books
    params = URI.encode_www_form({applicationId: '1015176085132125130',
                                  booksGenreId: '001005',
                                  keyword: '機械学習 統計 深層学習 AI',
                                  orFlag: '1',
                                  sort: '-releaseDate'
                                  
    })
    uri = URI.parse("https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?
#{params}")

    https = Net::HTTP.new(uri.host,uri.port)
    https.use_ssl = true
    https.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    response = https.start do |http|
      
      # 接続時に待つ最大秒数を設定
      http.open_timeout = 5
      # 読み込み一回でブロックして良い最大秒数を設定
      http.read_timeout = 10
      
      
      # ここでWebAPIを叩いている
      # Net::HTTPResponseのインスタンスが返ってくる
      http.get(uri.request_uri)
    end
    result = JSON.parse(response.body)
    Book.destroy_all
    result['Items'].each do |item|
      item = item['Item']
      book = Book.new
      book.attributes = {
        url: item['itemUrl'],
        title: item['title'],
        image_url: item['smallImageUrl'],
        salesdate: item['salesDate'],
        itemprice: item['itemPrice']
      }
      if book.save
        next
      end
    end
  end

  
end