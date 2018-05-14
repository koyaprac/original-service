require 'net/http'

class BooksController < ApplicationController
  def index
    params = URI.encode_www_form({applicationId: '1015176085132125130',
                                  booksGenreId: '001005',
                                  keyword: '機械学習 統計 深層学習 AI',
                                  orFlag: '1',
                                  sort: '-releaseDate'
                                  
    })
    uri = URI.parse("https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?
#{params}")
    @query = uri.query
    
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
    @result = JSON.parse(response.body)
    
    @books = []
    @result['Items'].each do |item|
      @books << item['Item']
    end
  end
end
