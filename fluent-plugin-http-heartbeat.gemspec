# Copyright 2016 Junjie Chen. All Rights Reserved.
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

# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name          = 'fluent-plugin-http-heartbeat'
  s.version       = '0.0.3'
  s.date          = '2016-02-28'
  s.summary       = "Fluentd input plugin that responses with HTTP status 200."
  s.description   = s.summary
  s.authors       = ['Junjie Chen']
  s.email         = 'jacky.jjchen@gmail.com'
  s.has_rdoc      = false
  s.homepage      = "https://github.com/Jackyjjc/fluent-plugin-http-heartbeat"
  s.license       = 'Apache License, Version 2.0'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
 
  s.add_dependency "fluentd", ">= 0.10.58", "< 2"
  s.add_dependency "cool.io", ">= 1.4.3", "< 1.5.0"
end
