class LatestsController < ApplicationController
    def search
        query = params[:search][:query]
        @result = Latest.where(artist_name: query ).or(Latest.where(title: query )).or(Latest.where(description: query ))
        respond_to do |format|
            format.json {render json: @result}
        end
    end
end