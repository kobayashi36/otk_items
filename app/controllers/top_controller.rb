class TopController < ApplicationController
  require 'open-uri'
  require 'nokogiri'

  def index
  	# スクレイピング先のURL
  	url = 'http://www.animate-onlineshop.jp/products/list.php?mode=search&spc=0&smt=%E3%83%A9%E3%83%96%E3%83%A9%E3%82%A4%E3%83%96%E3%80%80%E5%B0%8F%E6%B3%89%E8%8A%B1%E9%99%BD'

  	charset = nil
  	html = open(url) do |f|
  	  charset = f.charset # 文字種別を取得
  	  f.read # htmlを読み込んで変数htmlに渡す
  	end

  	# htmlをパース(解析)してオブジェクトを作成
  	doc = Nokogiri::HTML.parse(html, nil, charset)

	@items = Array.new
  	doc.xpath('//div[@class="imgsizefix"]').each do |image|
	  	h = Hash.new
		h["name"] = image.css('img').attribute('alt').value
		h["img"] =  image.css('img').attribute('src').value
		h["src"] = "http://www.animate-onlineshop.jp/"+ image.css('a').attribute('href').value
		@items.push(h)
    end

	url = 'http://store.broccoli.co.jp/ec/cmHeaderSearchProduct/doSearchProduct/cmHeader/%20/%20/1?wd=%E3%83%A9%E3%83%96%E3%83%A9%E3%82%A4%E3%83%96%20%E5%B0%8F%E6%B3%89%E8%8A%B1%E9%99%BD'

  	charset = nil
  	html = open(url) do |f|
  	  charset = f.charset # 文字種別を取得
  	  f.read # htmlを読み込んで変数htmlに渡す
  	end

  	# htmlをパース(解析)してオブジェクトを作成
  	doc = Nokogiri::HTML.parse(html, nil, charset)

  	doc.xpath('//div[@class="image"]').each do |image|
	  	h = Hash.new
		h["name"] = image.css('img').attribute('alt').value
		h["img"] = "http://store.broccoli.co.jp/ec/cmHeaderSearchProduct/doSearchProduct/cmHeader/%20/%20/"+ image.css('img').attribute('src').value
		h["src"] = "http://store.broccoli.co.jp/"+ image.css('a').attribute('href').value
		@items.push(h)
    end

	render :action => 'index.html.erb'
  end

end
