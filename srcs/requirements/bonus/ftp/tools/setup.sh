#! /bin/bash

service vsftpd start

sudo sed -i "s/anonymous_enable=NO/anonymous_enable=YES/g" /etc/vsftpd.conf
sudo sed -i "s/#write_enable=YES/write_enable=YES/g" /etc/vsftpd.conf
sudo sed -i "s/#anon_upload_enable=YES/anon_upload_enable=YES/g" /etc/vsftpd.conf
sudo sed -i "s/#chroot_local_user=YES/chroot_local_user=YES/g" /etc/vsftpd.conf
sudo echo "allow_writeable_chroot=YES" >> /etc/vsftpd.conf
sudo echo "pasv_enable=YES" >> /etc/vsftpd.conf
sudo echo "pasv_min_port=64000" >> /etc/vsftpd.conf
sudo echo "pasv_max_port=64500" >> /etc/vsftpd.conf

sudo useradd $FTP_USER1_NAME
echo "$FTP_USER1_NAME:$FTP_USER1_PASS" | sudo chpasswd

sudo mkdir -p $FTP_USER1_DIR #to be deleted
sudo usermod -aG 33 $FTP_USER1_NAME
sudo chown -R $FTP_USER1_NAME:33 $FTP_USER1_DIR
sudo usermod -d $FTP_USER1_DIR $FTP_USER1_NAME 
#sudo chmod -

service vsftpd stop

/usr/sbin/vsftpd -obackground=NO /etc/vsftpd.conf
