class LatestsController < ApplicationController
	
	def index
		redirect_to '/'
	end

    def search
        test = !!params[:search] ? params[:search][:query] : false
        @query = !!test ? test : Latest.order(created_at: :desc).limit(6)
        @contents = !!test ? Latest.where(artist_name: @query ).or(Latest.where(title: @query )).or(Latest.where(description: @query )) : @query
		query_offset = ''
		@per_page =  params[:content] ? params[:content].to_i : 4
		@current_page = params[:page] ? params[:page].to_i : 1
		tot_content_disp = @per_page * @current_page
		tot_content = @contents.length
		if( @per_page * @current_page == @per_page)
			query_offset = 0
		else
			query_offset = tot_content_disp - @per_page
		end
		
		@tot_nav_links = nil

		@contents = @contents.limit(@per_page).offset(query_offset)
		
		if(tot_content % @per_page== 0)
			@tot_nav_links = tot_content / @per_page
		else
			@tot_nav_links = (tot_content / @per_page)+1
        end
        
    end
end