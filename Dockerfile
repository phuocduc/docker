# from father of image ubuntu: 16.04
FROM ruby:2.5.1
# author
LABEL author.name='DucNguyen' \ 
author.email='ducnp2020@gmail.com'

# update ubuntu
RUN apt-get update && \
apt-get install -y nodejs nano vim

# set timezone for vitual machine

ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# chi định thư mục làm việc mặc định (Optional)
ENV APP_PATH /my_app

WORKDIR $APP_PATH

COPY Gemfile Gemfile.lock $APP_PATH/
RUN bundle install --without production --retry 2 \
  --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1`

COPY . $APP_PATH

# add script to be executed everytime the container start

COPY docker/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


# default run cmd
CMD ["rails", "server", "-b", "0.0.0.0"]
