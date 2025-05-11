resource "aws_instance" "setup_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = var.security_group_ids

  tags = {
    Name = "setup-server1"
  }

  user_data = base64encode(<<-EOF
#!/bin/bash
sudo su

yum update -y
mkdir -p /var/www/html
mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${var.efs_mount_dns}.efs.${var.region}.amazonaws.com:/ /var/www/html


yum install -y httpd httpd-tools mod_ssl
systemctl enable httpd
systemctl start httpd

amazon-linux-extras enable php7.4
yum clean metadata
yum install -y php php-common php-pear php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip}

rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
yum install -y mysql-community-server
systemctl enable mysqld
systemctl start mysqld

# Initialize RDS: create DB and WP user
mysql -h ${var.db_endpoint} -u ${var.db_user} -p${var.db_password} <<CREATE_DB_SQL
CREATE DATABASE ${var.db_name};
CREATE USER 'wp-user'@'%' IDENTIFIED BY '${var.db_password}';
GRANT ALL PRIVILEGES ON ${var.db_name}.* TO 'wp-user'@'%';
FLUSH PRIVILEGES;
CREATE_DB_SQL

usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www && find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
chown apache:apache -R /var/www/html

cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
cp -r wordpress/* .

cp wp-config-sample.php wp-config.php
sed -i "s/database_name_here/${var.db_name}/" wp-config.php
sed -i "s/username_here/${var.db_user}/" wp-config.php
sed -i "s/password_here/${var.db_password}/" wp-config.php
sed -i "s/localhost/${var.db_endpoint}/" wp-config.php

# PHP configuration tweaks
sed -i 's/^upload_max_filesize.*/upload_max_filesize = 64M/' /etc/php.ini
sed -i 's/^post_max_size.*/post_max_size = 64M/' /etc/php.ini
sed -i 's/^memory_limit.*/memory_limit = 128M/' /etc/php.ini


systemctl restart httpd
EOF
  )
}