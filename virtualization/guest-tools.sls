# Enable scheduled fstrim job to release freed blocks via discard/TRIM/UNMAP
# important for thinly provisioned storage.
# This only runs on filesystems on devices with UNMAP support enabled so it
# should not do any harm even if thin provisioning is not used. fstrim
# is installed even on physical hosts.

include:
{% if grains['virtual'] | lower == 'vmware' %}
  - vmware.vmware-tools
  - .elevator
  - .packages
{% elif grains['virtual'] | lower in ['kvm', 'qemu'] %}
  - kvm.qemu-guest-agent
  - .elevator
  - .packages
{% endif %}
  - fstrim
