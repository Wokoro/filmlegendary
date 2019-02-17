class LatestsController < ApplicationController
	
	def index
		redirect_to '/'
	end

    def search
        test = !!params[:search] ? params[:search][:query] : false
        @query = !!test ? test : Latest.order(created_at: :desc).limit(6)
        @contents = !!test ? Latest.where(artist_name: @query ).or(Latest.where(title: @query )).or(Latest.where(description: @query )) : @query
    end
end