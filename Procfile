web: bundle exec puma -C config/puma.rb -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
release: bundle exec rails db:migrate
