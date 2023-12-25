# exit on error
set -o errexit

bundle install
./bin/rails assets:precompile
./bin/rails rails assets:clean