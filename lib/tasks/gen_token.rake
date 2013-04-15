namespace :serv do

  desc "Drop, create, migrate then seed the development database"
  task :gen_token do

    token_len = 128
    chars = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f']
    token = (1..token_len).map {|v| chars.sample}.join
    File.open('config/initializers/secret_token.rb', 'w') {|file| file.write("Autoadvisor::Application.config.secret_token = '#{token}'\n")}

  end
end