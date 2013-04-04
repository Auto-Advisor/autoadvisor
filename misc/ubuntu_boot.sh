sudo apt-get install git build-essential openssh-client ruby1.9.1-dev libmysqlclient-dev mysql-client mysql-server libv8-dev nodejs && \
  git clone git@github.com:Auto-Advisor/autoadvisor.git autoadvisor && \
  cd autoadvisor && \
  sudo gem install rails && \
  sudo bundle install && \
  rake db:migrate && \
  wget https://s3.amazonaws.com/elasticbeanstalk/cli/AWS-ElasticBeanstalk-CLI-2.3.1.zip -O aws-eb-cli.zip && \
  unzip aws-eb-cli.zip
