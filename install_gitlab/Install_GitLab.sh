#!/bin/bash 

# Author Alex

#https://samzong.me/howto-install-gitlab/

cat <<EOF
************************************

此程序为一键Yum安装gitlab环境
会使用到sudo权限，请使用具有sudo权限的用户或root用户进行安装
具体操作可查看链接：https://samzong.me/howto-install-gitlab/

sudo sh Install_GitLab.sh

************************************
EOF


# 判断git是否存在
if command -v git >/dev/null 2>&1; then 
  echo 'exists git' 
else 
  echo 'no exists git' 
fi


# 安装gitlab
sudo yum install -y curl openssh-server openssh-clients postfix cronie
curl -sS http://packages.gitlab.cc/install/gitlab-ce/script.rpm.sh | sudo bash
sudo yum clean all && sudo yum makecache 
sudo yum install -y gitlab-ce

# 从github获取gitlab配置文件

sudo git clone https://github.com/SAMZONG/shell-scripts.git /tmp/gitlab_config_tmp
sudo cp -a /tmp/gitlab_config_tmp/install_gitlab/gitlab.rb /etc/gitlab/
sudo gitlab-ctl  reconfigure

sudo echo "gitlab-ctl start" >> /etc/rc.local