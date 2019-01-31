class FilmsController < ApplicationController
	#controller specific configuration

	def index
		@latests = Latest.order(created_at: :desc).load

		query_offset = ''
		@per_page =  params[:content] ? params[:content].to_i : 4
		@current_page = params[:page] ? params[:page].to_i : 1
		tot_content_disp = @per_page * @current_page
		tot_content = @latests.length
		if( @per_page * @current_page == @per_page)
			query_offset = 0
		else
			query_offset = tot_content_disp - @per_page
		end
		
		@tot_nav_links = nil

		@contents = @latests.limit(@per_page).offset(query_offset)
		
		if(tot_content % @per_page== 0)
			@tot_nav_links = tot_content / @per_page
		else
			@tot_nav_links = (tot_content / @per_page)+1
		end
					
	end

	def about
	end

	def contactUs
	end

end