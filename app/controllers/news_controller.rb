class NewsController < ApplicationController
    def index
        respond_to do |format|
			format.json do 
				@query_offset = params[:offset].to_i
				@contents = News.select(:id, :image_path, :title).order(created_at: :desc).limit(6).offset(@query_offset)
				@query_offset += @contents.length
				@contents_json = Hash.new
				@contents_json["query"] = @query_offset
				@contents_json["contents"] = @contents.as_json
				render json: @contents_json
			end
			format.html do
				@query_offset=0
				@contents = News.select(:id, :image_path, :title).order(created_at: :desc).limit(6)
				@query_offset += @contents.length
			end
		end
    end

    def new
        @news = News.new
    end

    def create
        @newsService = NewsService.new(params)
		@newsService.create_locally

		@news = @newsService.store_news
		
		if @news
			flash[:customed_message] = @news.errors.full_messages
		end
        
        if @news
            flash[:customed_message] = @news.errors.full_messages
        end
        redirect_to admin_index_path
    end

    def show
        @news = News.find(params[:id])
        url = @news.news_file_url
        @news.read_file(url)
    end

    private
        def permit_news
            params.require(:news).permit( :title, :body, :released )
        end

        def write_file file, path
            file_name = file.original_filename

            file_ext = File.extname file_name

            news_file = File.new(path, "wb")

            news_file.write(file.read)

            news_file.close
        end
end