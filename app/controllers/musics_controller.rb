class MusicsController < ApplicationController
	def index
		respond_to do |format|
			format.json do 
				@query_offset = params[:offset].to_i
				@contents = Music.select(:media_id, :media_poster, :artist_name, :title).order(created_at: :desc).limit(6).offset(@query_offset)
				@query_offset += @contents.length
				@contents_json = Hash.new
				@contents_json["query"] = @query_offset
				@contents_json["contents"] = @contents.as_json
				render json: @contents_json
			end
			format.html do
				@query_offset=0;
				@contents = Music.select(:id, :poster_path, :artist_name, :title).order(created_at: :desc).limit(6)
				@query_offset += @contents.length
			end
		end
	end
	
	def new
		@music = Music.new
	end

	def create
		@musicService = MusicService.new(params)

		@musicService.create_locally()

		@music = @musicService.store_music()
		
		if @music
			flash[:customed_message] = @music.errors.full_messages
		end

		redirect_to admin_index_path
	end

	def show
		id = params[:id]
		@music = Music.find(id)
		@media = "musics/#{id}"
	end

	def download
		music_id = params[:music][:music_id]

		music =  Music.find(music_id)

		if music.valid?
			music_rel_path = music.music_path

			music_file = gen_absolute_file_path music_rel_path

			send_file(music_file)

			download_count = music.download_count + 1

			music.update(download_count: download_count)
		end
	end

	private
		def permit_music
			params.require(:music).permit(:producer, :music_path, :title, :poster_path, :album_title, :artist_name);
		end
end