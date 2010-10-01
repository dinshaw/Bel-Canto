# Rack middleware for serving individual javascript files
# from non-public directories to the Jammit asset packager
# when in test or development modes
#
# To use, add this line to the relevant (development)
# environment file:
#
#     config.middleware.use 'JavascriptsHost'  
#

class JammitHost

  def initialize(app, opts={})
    @app = app
    @rack_file = Rack::File.new(Dir.pwd)
  end

  def call(env)
    if env["PATH_INFO"] =~ /\/app\/javascripts/
      response = @rack_file.call(env)
      return response unless response[0] == 404
    end
    @app.call(env)
  end
end
