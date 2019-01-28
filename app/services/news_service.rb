class NewsService
    attr_reader :news_file_path
    
    def initialize(params)

        @poster_file = params[:news][:image_path]
        @news_title = params[:news][:title].downcase
        @released = params[:news][:released]
        @description = params[:news][:body]

        @news_name = format_name "#{@news_title}.txt"
        @poster_name = format_name @poster_file.original_filename
        @folder = format_name "#{@news_title}_#{@released}"
        @news_dir = gen_news_dir()
        @news_url = gen_rel_path(@news_name)
        @poster_url = gen_rel_path(@poster_name)
        @type = "news"
    end

    # methods for CRUD operation on local machine
    def create_locally
        write_file(@description, @news_name)
        write_file(@poster_file, @poster_name)
    end

     #methode to store info to database
     def store_news
        ActiveRecord::Base.transaction do
            @news = News.create(released: @released, news_file_url: @news_url, title: @news_title, image_path: @poster_url)
            Latest.create(description: @description, media_id: @news.id, released: @released, media_producer: @producer, title: @news_title, media_poster: @poster_url, media_type: @type)
        end
    end
    

    private
        #method to generate news directory
        def gen_news_dir()
            dir =  "#{Rails.root}/public/secure/news/#{@folder}"
            if Dir.exist? dir
                dir
            else
                dir if FileUtils.mkdir_p dir
            end
        end
    
        #method to write file to news directory
        def write_file(src, dest)
            file_path = "#{@news_dir}/#{dest}"
            dest = File.new(file_path, "wb")
            if src.is_a?(String)
                dest.write(src)
            else
                dest.write(src.read)
            end
            dest.close
        end

        #method to generate relative path
        def gen_rel_path(file)
            file = "/secure/news/#{@folder}/#{file}"
        end
    
        #method to remove spaces from a given name input
        def format_name(name)
            name.split(' ').join('_')
        end
end