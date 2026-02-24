# systemd-nitro-enclaves

`systemd-nitro-enclaves` is a package including tools and systemd services for managing an EC2 host enabling AWS Nitro Enclaves. At present, it includes the following:

## `nitro-enclaves-allocator.service`

`nitro-enclaves-allocator.service` is a systemd service to configure an EC2 instance's memory and CPU reservation for running nitro enclaves.

### Usage

To configure enclave memory and CPU usage, install the nitro-enclaves-allocator files.

``
$ make install
``

Modify `/etc/nitro_enclaves/allocator.yaml` to configure your desired amount of RAM and CPUs for use by nitro enclaves. In this example, we are reserving 8GiB of RAM and 2 CPUs within the instance for use by nitro enclaves.
```
---
# Enclave configuration file.
#
# How much memory to allocate for enclaves (in MiB).
memory_mib: 8192
#
# How many CPUs to reserve for enclaves.
cpu_count: 2
#
# Alternatively, the exact CPUs to be reserved for the enclave can be explicitly
# configured by using `cpu_pool` (like below), instead of `cpu_count`.
# Note: cpu_count and cpu_pool conflict with each other. Only use exactly one of them.
# Example of reserving CPUs 2, 3, and 6 through 9:
# cpu_pool: 2,3,6-9
```

With the parameters configured, start the systemd nitro enclaves allocator service to begin RAM/CPU allocation and management for nitro enclaves.
```
$ systemctl start nitro-enclaves-allocator.service
```

With that, a user is now able to run nitro enclaves within an EC2 instance.
