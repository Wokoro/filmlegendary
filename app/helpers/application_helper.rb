module ApplicationHelper
    def format_name(name)
        name.split(' ').join('_')
    end

    def gen_relative_file_path(folder, folder_type, file_name)
        "/secure/#{folder_type}/#{folder}/#{file_name}"
    end

    def gen_absolute_file_path(path)
        "#{Rails.root}/public#{path}"
    end

    def gen_absolute_folder_path(type, folder)
        "#{Rails.root}/public/secure/#{type}/#{folder}"
    end
end
