class MusicsController < ApplicationController
	def index
		@musics = Music.all.order(created_at: :desc)

		query_offset = ''
		@per_page =  params[:content] ? params[:content].to_i : 4
		@current_page = params[:page] ? params[:page].to_i : 1
		tot_content_disp = @per_page * @current_page
		tot_content = @musics.length
		if( @per_page * @current_page == @per_page)
			query_offset = 0
		else
			query_offset = tot_content_disp - @per_page
		end
		
		@tot_nav_links = nil

		@contents = @musics.limit(@per_page).offset(query_offset)
		
		if(tot_content % @per_page== 0)
			@tot_nav_links = tot_content / @per_page
		else
			@tot_nav_links = (tot_content / @per_page)+1
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