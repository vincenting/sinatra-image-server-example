class ImageResizeWorker
  include Sidekiq::Worker

  def perform(image_path, sizes)
    image_info = {}
    [:dirname, :extname].each do |f|
      image_info[f] = File.send f, image_path
    end
    image_info[:basename] = File.basename image_path, image_info[:extname]
    sizes.each do |size|
      output_path = File.join(image_info[:dirname],
                              "#{image_info[:basename]}@#{size}#{image_info[:extname]}")
      resize_with_crop image_path, size, output_path
    end
  end

  private
  def resize_with_crop(image_path, output_size, output_path)
    image = MiniMagick::Image.open image_path
    output_dimensions = output_size.split('x').map { |e| e.to_i }
    image_crop_params = crop_params image.dimensions, output_dimensions
    image.crop image_crop_params if image_crop_params
    image.resize output_size
    image.write output_path
  end

  def crop_params(origin_dimensions, output_dimensions)
    origin_scale = origin_dimensions.first /  origin_dimensions.last.to_f
    output_scale = output_dimensions.first /  output_dimensions.last.to_f
    return false if (origin_scale - output_scale).abs < 0.00001
    (w, h), (x, y) = [origin_dimensions, [0, 0]]
    if origin_scale > output_scale
      x = w*(1-output_scale)/2
      w = w*output_scale
    else
      y = h*(1-1/output_scale)/2
      h = h/output_scale
    end
    "#{w}x#{h}+#{x}+#{y}"
  end
end
