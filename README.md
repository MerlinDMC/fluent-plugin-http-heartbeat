# HTTP heartbeat input plugin for [Fluentd](http://github.com/fluent/fluentd)

## Overview

This plugin simply respond to any request with a 200 http respond. Can be used for elb healthcheck.

## Installation

    fluent-gem install fluent-plugin-http-heartbeat

## Configuration

    <source>
      @type http_heartbeat 

      port 8080
      bind 0.0.0.0
    </source>

**port**

The port the http server listens on. Default is 8080.

**bind**

The address the http server binds to. Default is 0.0.0.0.

## [License](LICENSE)

Copyright (c) 2016 Junjie Chen(jacky.jjchen@gmail.com).
Licensed under the [Apache License](LICENSE).
