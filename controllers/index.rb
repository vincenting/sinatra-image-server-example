get '/' do
  halt 404 unless ENV['RACK_ENV'] == 'test'
  <<-HTML
  <html>
  <head><title>Multi file upload</title></head>
  <body>
  <form action="/" method="post" enctype="multipart/form-data">
  <input type="file" name="images[]" multiple />
  <input type="submit" />
  </form>
  </body>
  </html>
  HTML
end
