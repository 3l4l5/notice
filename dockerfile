FROM centos
MAINTAINER ryusei.ohkura Ohkura.exe@gmail.com

# プロキシ設定
# ARG proxy='http://xxxx:8080'
# ARG noproxy='xxx,xxx'
# ENV HTTP_PROXY $proxy
# ENV HTTPS_PROXY $proxy
# ENV NO_PROXY $noproxy
# RUN echo "proxy=$proxy" >> /etc/yum.conf

# タイムゾーン変更
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# yum アップデートとcronのインストール
RUN yum update -y --disableplugin=fastestmirror && \
    yum install -y epel-release --disableplugin=fastestmirror && \
    yum install -y --disableplugin=fastestmirror sudo cronie

# 実行ユーザを追加（全てrootで行う場合は不要です、この場合crontabのコマンド起動ユーザをrootにする必要があります）
# sudoersへの追加は必要な場合のみで問題ありません
# (cronで実行するコマンドにsudoが含まれる場合に必要です)
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -m -s /bin/bash dev-user && \
    echo 'dev-user    ALL=(ALL)    NOPASSWD:ALL' >> /etc/sudoers.d/dev-user

# PAMの設定
RUN sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/crond

# Dockerfileと同じ階層の"cron.d"フォルダ内にcronの処理スクリプトを格納しておく
ADD cron.d /etc/cron.d/
RUN chmod 0644 /etc/cron.d/*

CMD crond && tail -f /dev/null
