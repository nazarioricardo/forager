# exit on error
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
# bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}