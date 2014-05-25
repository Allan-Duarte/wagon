# Copied from https://github.com/guard/guard-livereload
# and customized to make it work outside the whole Guard stack.

module Guard
  class LiveReload < Plugin
    require 'guard/livereload/websocket'
    require 'guard/livereload/reactor'

    attr_accessor :reactor, :options

    def initialize(options = {})
      super
      @options = {
        host:           '0.0.0.0',
        port:           '35729',
        apply_css_live: true,
        override_url:   false,
        grace_period:   0
      }.merge(options)
    end

    def start
      @reactor = Reactor.new(options)
    end

    def stop
      reactor.stop
    end

    def run_on_modifications(paths)
      sleep options[:grace_period]
      reactor.reload_browser(paths)
    end

  end
end
