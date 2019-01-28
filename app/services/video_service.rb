class VideoService
    attr_reader :video_file_path
    
    def initialize(params)
        @video_file = params[:video][:video_file]
        @video_name = format_name @video_file.original_filename
        @poster_file = params[:video][:poster_file]
        @poster_name = format_name @poster_file.original_filename
        @video_title = params[:video][:title].downcase
        @released = params[:video][:released]
        @producer = params[:video][:producer]
        @description = params[:video][:description]
        
        @folder = format_name "#{@video_title}_#{@released}"
        @video_dir = gen_video_dir()
        @video_url = gen_rel_path(@video_name)
        @poster_url = gen_rel_path(@poster_name)
        @type = "video"
    end

    # method for CRUD operation on local machine
    def create_locally
        write_file(@video_file, @video_name)
        write_file(@poster_file, @poster_name)
    end

    #method to store info to database
    def store_video
        ActiveRecord::Base.transaction do
            @video = Video.create(video_path: @video_url, description: @description, released: @released, title: @video_title, poster_path: @poster_url, producer: @producer)
			@latest = Latest.create(media_id: @video.id, title: @video_title, description: @description, released: @released, media_poster: @poster_url, media_producer: @producer, media_type: @type)
        end
    end
    

    private
        #method to generate video directory
        def gen_video_dir()
            dir =  "#{Rails.root}/public/secure/video/#{@folder}"
            if Dir.exist? dir
                dir
            else
                dir if FileUtils.mkdir_p dir
            end
        end
    
        #method to write file to video directory
        def write_file(src, dest)
            file_path = "#{@video_dir}/#{dest}"
            dest = File.new(file_path, "wb")
            dest.write(src.read)
            dest.close
        end

        #method to generate relative path
        def gen_rel_path(file)
            file = "/secure/video/#{@folder}/#{file}"
        end
    
        #method to remove spaces from a given name input
        def format_name(name)
            name.split(' ').join('_')
        end
end