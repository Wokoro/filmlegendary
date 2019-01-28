class NewsController < ApplicationController
    def index
        @news = News.all.order(created_at: :desc)
     
        query_offset = ''
		@per_page =  params[:content] ? params[:content].to_i : 4
		@current_page = params[:page] ? params[:page].to_i : 1
		tot_content_disp = @per_page * @current_page
		tot_content = @news.length
		if( @per_page * @current_page == @per_page)
			query_offset = 0
		else
			query_offset = tot_content_disp - @per_page
		end
		
		@tot_nav_links = nil

        @contents = @news.limit(@per_page).offset(query_offset)
        
        @contents.each do |news|
            news.read_file(news.news_file_url)
        end
		
		if(tot_content % @per_page== 0)
			@tot_nav_links = tot_content / @per_page
		else
			@tot_nav_links = (tot_content / @per_page)+1
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