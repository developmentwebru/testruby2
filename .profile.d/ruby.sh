export LANG=${LANG:-en_US.UTF-8}
export GEM_PATH="$HOME/vendor/bundle/ruby/2.6.0:$GEM_PATH"
export PATH="$HOME/vendor/yarn-v1.22.4/bin/:$HOME/bin:$HOME/vendor/bundle/bin:$HOME/vendor/bundle/ruby/2.6.0/bin:$PATH"
export DISABLE_SPRING="1"
export BUNDLE_PATH=${BUNDLE_PATH:-vendor/bundle}
export BUNDLE_WITHOUT=${BUNDLE_WITHOUT:-development:test}
export BUNDLE_BIN=${BUNDLE_BIN:-vendor/bundle/bin}
export BUNDLE_GLOBAL_PATH_APPENDS_RUBY_SCOPE=${BUNDLE_GLOBAL_PATH_APPENDS_RUBY_SCOPE:-1}
export BUNDLE_DEPLOYMENT=${BUNDLE_DEPLOYMENT:-1}
export RAILS_ENV=${RAILS_ENV:-production}
export RACK_ENV=${RACK_ENV:-production}
export SECRET_KEY_BASE=${SECRET_KEY_BASE:-1c471bad6ae8c385ce03490de6afe33b3877d127d5fcb3e2943fc1fedd9b2f847ebc25ba4bea92c4474570caf162e01bbe4717bf13679f676766e3d3e20d61aa}
export RAILS_SERVE_STATIC_FILES=${RAILS_SERVE_STATIC_FILES:-enabled}
export RAILS_LOG_TO_STDOUT=${RAILS_LOG_TO_STDOUT:-enabled}
