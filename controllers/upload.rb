post '/' do
  result = []
  begin
    unless params[:images] && params[:images].class == Array
      raise RuntimeError
    end
    params[:images].each do |f|
      relative_uri = cp_tempfile f
      result << "#{ENV['STATIC_URL']}#{relative_uri}"
    end
    json msg: 'upload success.', urls: result
  rescue Exception
    halt 500, json(msg: 'upload images with error')
  end
end
