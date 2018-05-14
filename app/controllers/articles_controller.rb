require 'net/http'
require "rss"
require 'open-uri'
require 'kconv'
require 'active_support/core_ext/hash/conversions'
class ArticlesController < ApplicationController
  def index
    # http://kzfm-s.hateblo.jp/entry/2015/06/07/014735
    url = "https://qiita.com/tags/Python/feed"
    xml  = open(url).read.toutf8
    hash = Hash.from_xml(xml)
    @articles = hash["feed"]["entry"]
  end
end
