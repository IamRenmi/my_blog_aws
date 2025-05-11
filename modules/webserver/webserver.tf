resource "aws_instance" "webserver" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.security_group_id]

  tags = {
    Name = "webserver-${var.subnet_name}"
  }
  
  user_data = base64encode(<<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install -y httpd httpd-tools mod_ssl
sudo systemctl enable httpd
sudo systemctl start httpd

sudo amazon-linux-extras enable php7.4
sudo yum clean metadata
sudo yum install -y php php-common php-pear php-{cgi,curl,mbstring,gd,mysqlnd,gettext,json,xml,fpm,intl,zip}

sudo rpm -Uvh https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022
sudo yum install -y mysql-community-server
sudo systemctl enable mysqld
sudo systemctl start mysqld

# Mount EFS via fstab
sudo echo "${var.efs_mount_dns}.efs.${var.region}.amazonaws.com:/ /var/www/html nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0" | sudo tee -a /etc/fstab
sudo mount -a

sudo chown -R apache:apache /var/www/html
sudo systemctl restart httpd
EOF
  )
}