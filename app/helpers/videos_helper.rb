module VideosHelper
	def write_file file, path
			file_name = file.original_filename

			file_ext = File.extname file_name

			new_file = File.new(path, "wb")

			new_file.write(file.read)

			new_file.close
		end
end
