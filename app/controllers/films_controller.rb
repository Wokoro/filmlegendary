class FilmsController < ApplicationController
	#controller specific configuration

	def index
		# code for pagination to be removed for mobile
		#if(tot_content % @per_page== 0)
		#	@tot_nav_links = tot_content / @per_page
		#else
		#	@tot_nav_links = (tot_content / @per_page)+1
		#end

		respond_to do |format|
			format.json do 
				@query_offset = params[:offset].to_i
				@contents = Latest.select(:media_id, :media_type, :media_poster, :artist_name, :title).order(created_at: :desc).limit(6).offset(@query_offset)
				@query_offset += @contents.length
				@contents_json = Hash.new
				@contents_json["query"] = @query_offset
				@contents_json["contents"] = @contents.as_json
				render json: @contents_json
			end
			format.html do
				@query_offset=0;
				@contents = Latest.select(:media_id, :media_type, :media_poster, :artist_name, :title).order(created_at: :desc).limit(6)
				@query_offset += @contents.length
			end
		end			
	end

	def about
	end

	def contactUs
	end

end