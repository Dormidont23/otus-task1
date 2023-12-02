#!/bin/bash

sudo -i
# Обновление и очистка всех ненужных пакетов
yum update -y
yum clean all

# Добавление ssh-ключа для пользователя vagrant
mkdir -pm 700 /home/vagrant/.ssh
curl -sL https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub -o /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh

# Удаление временных файлов
rm -rf /tmp/*
rm  -f /var/log/wtmp /var/log/btmp
rm -rf /var/cache/* /usr/share/doc/*
rm -rf /var/cache/yum
rm -rf /home/vagrant/*.iso
rm  -f ~/.bash_history
history -c

rm -rf /run/log/journal/*
sync
# И ещё раз обновим параметры GRUB, поскольку одного раза почему-то не хватает
grub2-set-default 0
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
# И контрольный ребут
shutdown -r now
