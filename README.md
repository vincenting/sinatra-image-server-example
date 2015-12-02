## Image upload server example for [Sinatra](http://www.sinatrarb.com/)

整体开发思路 [用 Ruby 快速开发一个静态服务全过程](https://ruby-china.org/topics/27956)

---

#### 如何测试

1. 拷贝 example.env 至 .env
2. 修改 `REDIS_PROVIDER` 值为当前 sidekiq 使用的 redis 连接以及数据库
3. `STATIC_ROOT` 为静态文件期待处理至文件夹
4. `STATIC_URL` 为 nginx 中图片配置的地址（`STATIC_ROOT` 对应访问的地址）
5. `bundle install` 安装依赖
6. `rake test && rake quality`

#### 如何启动

建议使用 (Supervisord)[http://supervisord.org/] 配合 [Puma](http://puma.io/) 启动

1. 启动 worker `bundle exec sidekiq -r ./app.rb`
2. 启动 web `bundle exec rackup -p 8001 -s puma --host 127.0.0.1 config.ru`