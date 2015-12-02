require_relative '../spec_helper'

describe ImageResizeWorker do
  before do
    @test_image_path = File.join(File.dirname(__FILE__), 'images', 'wensen.jpg')
    @worker = ImageResizeWorker.new
  end

  it 'should resize images with out error' do
    @worker.perform(@test_image_path, %w(100x100 200x200))
  end

  it 'should has the same extname' do
    @worker.perform(@test_image_path, %w(100x100 200x200))
    assert File.exist?(File.join(File.dirname(@test_image_path), "wensen@100x100.jpg"))
    assert File.exist?(File.join(File.dirname(@test_image_path), "wensen@200x200.jpg"))
  end

  it 'should assert_equal name and size' do
    @worker.perform(@test_image_path, %w(40x50 100x80 120x120))
    Dir[File.join(File.dirname(__FILE__), 'images', '*@*.*')].each do |f|
      image = MiniMagick::Image.open(f)
      size = File.basename(f, '.*').split('@').last.split 'x'
      assert_equal image.width, size.first.to_i
      assert_equal image.height, size.last.to_i
    end
  end

  after do
    Dir[File.join(File.dirname(__FILE__), 'images', '*@*.*')].each { |f| File.delete f }
  end
end
