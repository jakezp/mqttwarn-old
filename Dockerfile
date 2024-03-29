FROM python:2.7

MAINTAINER jakezp@gmail.com

# based on https://github.com/jpmens/mqttwarn

ENV DEBIAN_FRONTEND noninteractive

# Add config files
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD run.sh /run.sh

# Update and install packages
RUN apt install supervisor tzdata
RUN pip install paho-mqtt requests jinja2


# Setup and configure mqttwarn
RUN groupadd -r mqttwarn && useradd -r -g mqttwarn mqttwarn
RUN mkdir -p /opt/mqttwarn
RUN git clone https://github.com/jpmens/mqttwarn.git /opt/mqttwarn
RUN chown -R mqttwarn /opt/mqttwarn

# Set permissions
RUN chmod +x /run.sh

VOLUME ["/opt/mqttwarn/conf"]
ENV MQTTWARNINI="/opt/mqttwarn/conf/mqttwarn.ini"
WORKDIR /opt/mqttwarn

CMD ["/run.sh"]
