# Notes for some things to be changed before an official release #

 - TODO check: Gentoo kernel reports to be compiled with GCC 5.4.0 but GCC 6.4.0 was installed
 - Since kernel 4.16.0 a virtualbox kernel module is included and has been enabled in kernel config (should be tested at least for shared folders and port forwardings)
 - otherwise we want to have the complete virtualbox guest additions (perhaps in addition to the kernel module above)
 - since v0.0.4:
   - gentoo-sources and debian-sources are both installed, but we only want to have gentoo-sources, therefore remove debian-sources (eclean-kernel?)
   - kernel sources could possibly be "make cleaned" (or better wiped with mrproper to save a lot of space)
   - kernel config should be reworked to get rid of some stuff which is never used (gave up on including AMD stuff) 
