class VideosController < ApplicationController

	def index
		@videos = Video.all.order(created_at: :desc)

		query_offset = ''
		@per_page =  params[:content] ? params[:content].to_i : 4
		@current_page = params[:page] ? params[:page].to_i : 1
		tot_content_disp = @per_page * @current_page
		tot_content = @videos.length
		if( @per_page * @current_page == @per_page)
			query_offset = 0
		else
			query_offset = tot_content_disp - @per_page
		end
		
		@tot_nav_links = nil

		@contents = @videos.limit(@per_page).offset(query_offset)
		
		if(tot_content % @per_page== 0)
			@tot_nav_links = tot_content / @per_page
		else
			@tot_nav_links = (tot_content / @per_page)+1
		end
	end

	def new
		@video = Video.new
	end

	def create
		@videoService = VideoService.new(params)

		@videoService.create_locally

		@video = @videoService.store_video
		
		if @video
			flash[:customed_message] = @video.errors.full_messages
		end
		
		redirect_to admin_index_path
	end

	def show
		@video = Video.find(params[:id])
	end

	def download
		video_id = params[:video][:video_id]
		video = Video.find(video_id)

		if video.valid?
			video_rel_path = video.video_path
			
			video_name = File.basename video_rel_path

			video_file = gen_absolute_file_path video_rel_path

			send_file(video_file)
		end
	end

	private
		def permit_video
			params.require(:video).permit( :title, :producer, :description );
		end
end
