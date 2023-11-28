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
После выполнения команды **packer build centos.json** сформировался файл **centos-7-kernel-6-x86_64-Minimal.box** размером 1,21 ГБ.\
**vagrant box add --name centos7-kernel6 centos-7-kernel-6-x86_64-Minimal.box**

При развёртывании из файла, ВМ нормально поднимается с обновлённым ядром, но при загрузке в облако ошибка ниже. Возможно из-за того, что у меня процессор AMD и при развёртывании CentOS 7 архитектура определилась просто как x64 вместо amd64.\
D:\Vagrant\packer>**vagrant cloud publish -r dvsm48qnzqag/centos7-kernel6 1.0 virtualbox centos-7-kernel-6-x86_64-Minimal.box**                         You are about to publish a box on Vagrant Cloud with the following options:                                                                          dvsm48qnzqag/centos7-kernel6:   (v1.0) for provider 'virtualbox'                                                                                     Automatic Release:     true                                                                                                                          Box Architecture:      x64                                                                                                                           Do you wish to continue? [y/N]y                                                                                                                      Saving box information...                                                                                                                            Failed to create box dvsm48qnzqag/centos7-kernel6                                                                                                    Vagrant Cloud request failed - Invalid architecture name: x64. Valid names: amd64, arm, arm64, i386, mips, mips64, mips64le, mipsle, ppc64, ppc64le, s390x, unknown
