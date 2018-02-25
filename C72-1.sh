#! /bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

[ "$EUID" -ne '0' ] && echo "Error,This script must be run as root! " && exit 1
KernelList="$(rpm -qa |grep 'kernel' |awk '{print $1}')"
[ -z "$(echo $KernelList |grep -o kernel-ml-4.10.8-1.el7.elrepo.x86_64)" ] && echo "Install error." && exit 1
for KernelTMP in `echo "$KernelList"`
 do
  [ "$KernelTMP" != "kernel-ml-4.10.8-1.el7.elrepo.x86_64" ] && echo -ne "Uninstall Old Kernel\n\t$KernelTMP\n" && yum remove "$KernelTMP" -y >/dev/null 2>&1
done

yum remove kernel-headers -y
# http://mirror.rc.usf.edu/compute_lock/elrepo/kernel/el7/x86_64/RPMS/
yum install -y http://mirror.rc.usf.edu/compute_lock/elrepo/kernel/el7/x86_64/RPMS/kernel-ml-headers-4.10.8-1.el7.elrepo.x86_64.rpm
yum install -y http://mirror.rc.usf.edu/compute_lock/elrepo/kernel/el7/x86_64/RPMS/kernel-ml-devel-4.10.8-1.el7.elrepo.x86_64.rpm
yum install -y http://mirror.rc.usf.edu/compute_lock/elrepo/kernel/el7/x86_64/RPMS/kernel-ml-tools-libs-4.10.8-1.el7.elrepo.x86_64.rpm
yum install -y http://mirror.rc.usf.edu/compute_lock/elrepo/kernel/el7/x86_64/RPMS/kernel-ml-tools-4.10.8-1.el7.elrepo.x86_64.rpm
