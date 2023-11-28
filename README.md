������� 1. Vagrant-����� ��� ���������� ���� � �������� ������ �������.

���� ��������� �������:
��������� ��������� ���� � �� Linux. ��������� ������� ������ � Vagrant, Packer � ����������� ������� ������� � Vagrant Cloud.

�������� ��������� �������:
1. �������� ���� �� �� ����������� ELRepo.
2. ������� Vagrant box c ������� Packer.
3. ��������� Vagrant box � Vagrant Cloud.


������ ������ �� ������ CentOS 8 Stream �� ���������� � �������, ��� ����������� ���� /run/install/ks.cfg, ������� � ����� ����������� ������� �� ����� ������ ������ - CentOS 7. �� �������� � ��������.
�� ������ ���� ����� ����� ������������ �� ����������� https://github.com/Nickmob/vagrant_kernel_update
� ����� centos.json ���� ����������� ������ �� ����������� CentOS, ����������� �������� � ������ CentOS.
� ����� ks.cfg ����� ���� �������� ������ �� ������ ��� CentOS.
� ����� stage-1-kernel-update.sh ���� �������� ������ �� ����������� ELRepo.
����� ���������� ������� packer build centos.json ������������� ���� centos-7-kernel-6-x86_64-Minimal.box �������� 1,23 ��.
vagrant box add --name centos7-kernel6 centos-7-kernel-6-x86_64-Minimal.box

D:\Vagrant\packer>vagrant box list
centos7-kernel6  (virtualbox, 0)
generic/centos8s (virtualbox, 4.3.6, (amd64))

�������� vagrant init centos7-kernel6 ��� ������ ���� Vagrantfile

vagrant plugin install vagrant-vbguest