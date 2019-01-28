class News < ApplicationRecord
    belongs_to :admin, optional: true

    attr_accessor :body

    def read_file(file_path)
        self.body = File.open("#{Rails.root}/public/#{file_path}", 'r'){ |f| f.read }
    end
end