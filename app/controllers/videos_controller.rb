class VideosController < ApplicationController

	def index
		respond_to do |format|
			format.json do 
				@query_offset = params[:offset].to_i
				@contents = Video.select(:id, :poster_path, :title).order(created_at: :desc).limit(6).offset(@query_offset)
				@query_offset += @contents.length
				@contents_json = Hash.new
				@contents_json["query"] = @query_offset
				@contents_json["contents"] = @contents.as_json
				render json: @contents_json
			end
			format.html do
				@query_offset=0;
				@contents = Video.select(:id, :poster_path, :title).order(created_at: :desc).limit(6)
				@query_offset += @contents.length
			end
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
		id = params[:id]
		@video = Video.find(id)
		@media = "videos/#{id}"
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
