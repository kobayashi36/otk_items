class ScrapingsController < ApplicationController

	def new
		@scraping = Scraping.new(item_name: params[:item_name], img: params[:img], src: params[:src])
		if @scraping.save
			@scrapings = Scraping.all
			#render :index
			redirect_to root_path+'?utf8=✓&word='+params[:want]+'&commit=検索', notice: '＼『' + @scraping.item_name + '』を欲しいリストに登録しました！／'
		end
	end

	def index
		@scrapings = Scraping.all
	end

	def destroy
		@scraping = Scraping.find(params[:id])
		@scraping.destroy
		redirect_to scrapings_url, notice: '＼『' + @scraping.item_name + '』を完了しました！／'
	end

end
