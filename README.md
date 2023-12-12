## Занятие 1. Vagrant-стенд для обновления ядра и создания образа системы. ##

**Цель домашнего задания:**
Научиться обновлять ядро в ОС Linux. Получение навыков работы с Vagrant, Packer и публикацией готовых образов в Vagrant Cloud.

**Описание домашнего задания:**
1. Обновить ядро ОС из репозитория ELRepo.
2. Создать Vagrant box c помощью Packer.
3. Загрузить Vagrant box в Vagrant Cloud.

Сборка образа на основе CentOS 8 Stream не заработала с ошибкой, что отсутствует файл /run/install/ks.cfg (Kickstart file /run/install/ks.cfg is missing.), поэтому я решил попробовать собрать на более старой версии - CentOS 7.\
За основу были взяты файлы конфигурации из репозитория https://github.com/Nickmob/vagrant_kernel_update  
В файле _centos.json_ была подправлена ссылка на дистрибутив CentOS, подправлены названия и версии CentOS.\
В файле _ks.cfg_ также была изменена ссылка на пакеты для CentOS.\
В файле _stage-1-kernel-update.sh_ была изменена ссылка на репозитроий ELRepo.\
Также были подправлены строки в файле _stage-1-kernel-update.sh_, в которых происходит обновление параметров загрузчика _grub_. Вместо\
**grub2-mkconfig -o /boot/grub2/grub.cfg**\
**grub2-set-default 0**\
стало\
**sudo grub2-set-default 0**\
**sudo grub2-mkconfig -o /boot/grub2/grub.cfg**

После этих изменений команда **packer build centos.json** выполнилась успешно и сформировался файл **centos-7-kernel-6-x86_64-Minimal.box**.

При локальном развёртывании из файла командой **vagrant box add --name centos7-kernel6 centos-7-kernel-6-x86_64-Minimal.box**, ВМ нормально поднимается с обновлённым ядром, а вот с облаком проблема: при загрузке в облако ошибка (см. ниже). Возможно из-за того, что у меня процессор AMD и при автоматической установке CentOS 7 неверно определяется архитектура (x64 вместо amd64).

Я попробовал найти параметр, в котором можно явно указать архитектуру «amd64», но здесь https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm не нашёл. Что интересно, для файла **Vagrantfile** есть такой параметр: **box_architecture**.

Попытка загрузки в облако:\
D:\Vagrant\packer>**vagrant cloud publish -r dvsm48qnzqag/centos7-kernel6 1.0 virtualbox centos-7-kernel-6-x86_64-Minimal.box**\
You are about to publish a box on Vagrant Cloud with the following options:\
dvsm48qnzqag/centos7-kernel6:   (v1.0) for provider 'virtualbox'\
Automatic Release:     true\
**Box Architecture:      x64**\
Do you wish to continue? [y/N]y\
Saving box information...\
Failed to create box dvsm48qnzqag/centos7-kernel6\
Vagrant Cloud request failed - **Invalid architecture name: x64**. Valid names: amd64, arm, arm64, i386, mips, mips64, mips64le, mipsle, ppc64, ppc64le, s390x, unknown


Скачать box для локального развёртывания можно с ЯД https://disk.yandex.ru/d/E_oFIdfzepcTBQ

После развёртывания box'а можно посмотреть список ядер. Видно, что было старое 3.10.0, а стало новое 6.6.3.\
[root@otus-task1 ~]# **ls -l /boot/vmlinuz-***\
-rwxr-xr-x. 1 root root  6769256 Dec  2 11:46 /boot/vmlinuz-0-rescue-7f7067301a779b4a8c34eb6716eaa4d1\
-rwxr-xr-x. 1 root root  7051880 Oct 17 11:46 /boot/vmlinuz-3.10.0-1160.102.1.el7.x86_64\
-rwxr-xr-x. 1 root root  6769256 Oct 19  2020 /boot/vmlinuz-3.10.0-1160.el7.x86_64\
-rwxr-xr-x. 1 root root 11038688 Nov 29 00:29 /boot/vmlinuz-6.6.3-1.el7.elrepo.x86_64
