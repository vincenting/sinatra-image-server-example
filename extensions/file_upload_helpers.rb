module Sinatra
  module FileUploadHelpers
    def cp_tempfile(f)
      begin
        filename = SecureRandom.hex(16) + File.extname(f[:filename])
        filepath = File.join ENV['STATIC_ROOT'], filename
        mkdir_unless_exist ENV['STATIC_ROOT']
        FileUtils.cp(f[:tempfile].path, filepath)
      rescue
        raise RuntimeError
      end
      unless ENV['RACK_ENV'] == 'test'
        ImageResizeWorker.perform_async filepath, (params[:resize] || '').split(',')
      end
      filename
    end

    private
    def mkdir_unless_exist(dir)
      system 'mkdir', '-p', dir
    end
  end

  helpers FileUploadHelpers
end
