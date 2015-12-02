require_relative '../spec_helper'

describe 'UploadImageController' do

  before do
    @test_image_path = File.join(File.dirname(__FILE__), '../workers/images/', 'wensen.jpg')
  end

  it 'should raise 500 if images not uploadFile array' do
    post '/'
    assert !last_response.ok?
    assert_equal 500, last_response.status

    post '/', images: Rack::Test::UploadedFile.new(@test_image_path, 'image/jpeg')
    assert !last_response.ok?
    assert_equal 500, last_response.status
  end

  it 'should raise 500 if images is something else' do
    post '/', images: [{name: 'helo'}]
    assert !last_response.ok?
    assert_equal 500, last_response.status
  end

  it 'should upload success if is array' do
    post '/', images: [Rack::Test::UploadedFile.new(@test_image_path, 'image/jpeg')]
    assert last_response.ok?
    assert_equal Dir[File.join(ENV['STATIC_ROOT'], '*.jpg')].size, 1
  end

  it 'should support multifile' do
    post '/', images: [Rack::Test::UploadedFile.new(@test_image_path, 'image/jpeg'),
                       Rack::Test::UploadedFile.new(@test_image_path, 'image/jpeg')]
    assert last_response.ok?
    assert_equal MultiJson.load(last_response.body)['urls'].size, 2
    assert_equal Dir[File.join(ENV['STATIC_ROOT'], '*.jpg')].size, 2
  end

  after do
    Dir[File.join(ENV['STATIC_ROOT'], '**', '*.jpg')].each { |f| File.delete f }
  end
end
