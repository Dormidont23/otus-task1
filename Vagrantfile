Vagrant.configure("2") do |config|
  config.vm.box = "dvsm48qnzqag/centos7-kernel6"
  config.vm.define "otus-task1"
  config.vm.synced_folder "./", "/vagrant", disabled: true
  config.vm.box_architecture = "x64"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.name = "otus-task1"
  end
end
