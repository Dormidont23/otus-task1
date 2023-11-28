## Занятие 1. Vagrant-стенд для обновления ядра и создания образа системы. ##

**Цель домашнего задания:**
Научиться обновлять ядро в ОС Linux. Получение навыков работы с Vagrant, Packer и публикацией готовых образов в Vagrant Cloud.

**Описание домашнего задания:**
1. Обновить ядро ОС из репозитория ELRepo.
2. Создать Vagrant box c помощью Packer.
3. Загрузить Vagrant box в Vagrant Cloud.

Сборка образа на основе CentOS 8 Stream не заработала с ошибкой, что отсутствует файл /run/install/ks.cfg, поэтому я решил попробовать собрать на более старой версии - CentOS 7.\
За основу были взяты файлы конфигурации из репозитория https://github.com/Nickmob/vagrant_kernel_update  
В файле _centos.json_ была подправлена ссылка на дистрибутив CentOS, подправлены названия и версии CentOS.\
В файле _ks.cfg_ также была изменена ссылка на пакеты для CentOS.\
В файле _stage-1-kernel-update.sh_ была изменена ссылка на репозитроий ELRepo.\
После выполнения команды **packer build centos.json** сформировался файл centos-7-kernel-6-x86_64-Minimal.box размером 1,23 ГБ.\
**vagrant box add --name centos7-kernel6 centos-7-kernel-6-x86_64-Minimal.box**

D:\Vagrant\packer>**vagrant box list**\
centos7-kernel6  (virtualbox, 0)\
generic/centos8s (virtualbox, 4.3.6, (amd64))

vagrant plugin install vagrant-vbguest
