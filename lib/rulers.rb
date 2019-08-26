require "rulers/array"
require "rulers/version"
require "rulers/routing"

module Rulers
  class Error < StandardError; end

  class Application
    def call(env)
      # if env['PATH_INFO'] == '/favicon.ico'
      if env['PATH_INFO'] == '/'
        # return [404, {'Content-Type' => 'text/html'}, ['No page found!']]
        # env['PATH_INFO'] = '/quotes/a_quote'
        return [303, {'Location' => '/quotes/a_quote'}, []]
      end

      klass, act = get_controller_and_action(env)
      controller = klass.new(env)

      begin
        text = controller.send(act)
      rescue
        return [404, {'Content-Type' => 'text/html'}, ['Page not found!']]
      end

      [200, {'Content-Type' => 'text/html'}, [text]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    def env
      @env
    end
  end
end
