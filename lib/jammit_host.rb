
# environment.rb:
# config.middleware.use 'JavascriptsHost'  
class JammitHost

  def initialize(app, opts={})
    @app = app
    @location = opts[:location] || '/app/javascripts'
    root = opts[:root] || Dir.pwd
    @file_server = Rack::File.new(root)
  end

  def call(env)
    path = env["PATH_INFO"]
    if path =~ /^#{Regexp.quote(@location)}/
      resp = @file_server.call(env)
      return resp unless resp[0] == 404
    end
    @app.call(env)
  end
end
