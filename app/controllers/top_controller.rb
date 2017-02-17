class TopController < ApplicationController
  require 'open-uri'
  require 'nokogiri'
  require 'URI'

  def index
	@words = params[:word]
	urls = create_url(@words)

	@name = Array.new
	@img = Array.new
	@src = Array.new
	count = 0
	urls.each do |url|
		doc = get_obj(url)
		xpath,path,img = get_xpath(url)

		doc.xpath('//div[@class="'+xpath+'"]').each do |html|
			@name[count] = html.css('img').attribute('alt').value
			@img[count] = img+html.css('img').attribute('src').value
			@src[count] = path+ html.css('a').attribute('href').value
			count += 1
	    end
	end

	render :action => 'index.html.erb'
  end

  def create_url(words)
	  url = Array.new
	  word = ''
	  if !words.blank? then
		word = URI.encode(words)
	  	url.push('http://www.animate-onlineshop.jp/products/list.php?mode=search&spc=0&smt='+word)
	  	url.push('http://store.broccoli.co.jp/ec/cmHeaderSearchProduct/doSearchProduct/cmHeader/%20/%20/1?wd='+word)
	  end
	  return url
  end

  def get_obj(url)
	  charset = nil
	  html = open(url) do |f|
	    charset = f.charset # 文字種別を取得
	    f.read # htmlを読み込んで変数htmlに渡す
	  end
	  # htmlをパース(解析)してオブジェクトを作成
	  doc = Nokogiri::HTML.parse(html, nil, charset)
	  return doc
  end

  def get_xpath(url)
	  if url.index('animate') != nil then
		  return 'imgsizefix','http://www.animate-onlineshop.jp/',''
	  elsif url.index('broccoli') != nil then
		  return 'image','http://store.broccoli.co.jp/','http://store.broccoli.co.jp/ec/cmHeaderSearchProduct/doSearchProduct/cmHeader/%20/%20/'
	  end
  end

end
