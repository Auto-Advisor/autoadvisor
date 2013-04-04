namespace :db do

  desc "Drop, create, migrate then seed the development database"
  task :reseed => [
      'db:reset',
      'db:seed'
    ]
end