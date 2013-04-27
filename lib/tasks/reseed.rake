namespace :db do

  desc "Drop, create, migrate then seed the development database"
  task :reseed => [
    'db:reset',
    'db:seed'
  ]

  task :rebuild => [
    "db:drop",
    "db:create",
    "db:migrate",
    "db:schema:dump",
    "db:seed"
  ]
end