require 'rack'
require 'json'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  path = req.path
  res.write("#{path}")
  # res.write("==============")
  # res.write("#{header}")
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)
