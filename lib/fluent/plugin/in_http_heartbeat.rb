# Copyright 2016 Junjie Chen, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You
# may not use this file except in compliance with the License. A copy of
# the License is located at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# or in the "license" file accompanying this file. This file is
# distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF
# ANY KIND, either express or implied. See the License for the specific
# language governing permissions and limitations under the License.

module Fluent
  class HttpHeartbeatInput < Input
    Fluent::Plugin.register_input('http_heartbeat', self)

    config_param :port, :integer, :default => 80
    config_param :bind, :string, :default => '0.0.0.0'

    def initialize
      super
      require 'cool.io'
      require 'fluent/input'
    end

    class HeartbeatConnection < Cool.io::TCPSocket
      def on_connect
        puts "#{remote_addr}:#{remote_port} connected"
      end

      def on_read(data)
        body = "heartbeat"

        response = "HTTP/1.1 200\r\n"
        response << "Content-type: text/plain\r\n"
        response << "Content-length: " + body.bytesize.to_s + "\r\n"
        response << "\r\n"
        response << body
        write response
      end

      def on_write_complete
        close
      end
    end

    def start
      super

      log.debug "listening http on #{@bind}:#{@port}"
      @server = Cool.io::TCPServer.new(@bind, @port, HeartbeatConnection)
      @loop = Coolio::Loop.new
      @loop.attach(@server)
      
      @thread = Thread.new(&method(:run))
    end

    def shutdown
      @loop.stop
      @server.close
      @thread.join
    end

    def run
      @loop.run()
    rescue
      log.error "unexpected error", error: $!.to_s
      log.error_backtrace
    end
  end
end
