#!/bin/bash

# ��������� ����������� elrepo
sudo yum install -y https://www.elrepo.org/elrepo-release-7.el7.elrepo.noarch.rpm
# ��������� ������ ���� �� ����������� elrepo-kernel
sudo yum --enablerepo elrepo-kernel install kernel-ml -y

# ���������� ���������� GRUB
sudo grub2-set-default 0
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

echo "Grub update done."
# ������������ ��
shutdown -r now