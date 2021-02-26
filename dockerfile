FROM centos

RUN yum -y update
RUN yum -y install git
RUN mkdir main
RUN cd main
RUN git clone https://github.com/3l4l5/notice.git
RUN yum install -y python3
RUN yum install -y https://repo.ius.io/ius-release-el7.rpm --skip-broken
RUN pip3 install  requests
RUN yum install cronie -y


WORKDIR ~/../main
RUN git clone https://github.com/3l4l5/notice.git

RUN echo "* * * * * cd ~/../main/notice; sh main.sh" >> /var/spool/cron/root