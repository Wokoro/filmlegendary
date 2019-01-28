class MusicService
    attr_reader :music_file_path
    
    def initialize(params)
        @music_file = params[:music][:music_file]
        @music_name = format_name @music_file.original_filename
        @poster_file = params[:music][:poster_file]
        @poster_name = format_name @poster_file.original_filename
        @music_title = params[:music][:title].downcase
        @artist_name = params[:music][:artist_name]
        @album_title = params[:music][:album_title]
        @released = params[:music][:released]
        @producer = params[:music][:producer]
        @description = params[:music][:description]
        @composer = params[:music][:composer]
        @genre = params[:music][:genres]
        
        @folder = format_name "#{@artist_name}_#{@album_title}"
        @music_dir = gen_music_dir()
        @music_url = gen_rel_path(@music_name)
        @poster_url = gen_rel_path(@poster_name)
        @type = "music"
    end

    # methods for CRUD operation on local machine
    def create_locally
        write_file(@music_file, @music_name)
        write_file(@poster_file, @poster_name)
    end

     #methode to store info to database
     def store_music
        ActiveRecord::Base.transaction do
            @music = Music.create(genre: @genre, composer: @composer, released: @released, description: @description, producer: @producer, music_path: @music_url, download_count: 0, title: @music_title, poster_path: @poster_url, album_title: @album_title, artist_name: @artist_name)
            Latest.create(description: @description, media_id: @music.id, released: @released, media_producer: @producer, title: @music_title, media_poster: @poster_url, media_type: @type, artist_name: @artist_name)
        end
    end
    

    private
        #method to generate music directory
        def gen_music_dir()
            dir =  "#{Rails.root}/public/secure/music/#{@folder}"
            if Dir.exist? dir
                dir
            else
                dir if FileUtils.mkdir_p dir
            end
        end
    
        #method to write file to music directory
        def write_file(src, dest)
            file_path = "#{@music_dir}/#{dest}"
            dest = File.new(file_path, "wb")
            dest.write(src.read)
            dest.close
        end

        #method to generate relative path
        def gen_rel_path(file)
            file = "/secure/music/#{@folder}/#{file}"
        end
    
        #method to remove spaces from a given name input
        def format_name(name)
            name.split(' ').join('_')
        end
end