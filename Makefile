#
# Makefile to make ISO's
#


# define the absolute place where these tools reside
ISO_SOURCE = /var/build/isotools

# define the location where the ISO will be generated
ISO_TARGET = /var/build/isotools/BUILD

# define the version numbers and tags etc:
ISO_VERSION = 1.4.1
ISO_CODENAME = Dark Side
ISO_DATE = 20041113
ISO_CNAME = $(ISO_VERSION) ($(ISO_CODENAME) - $(ISO_DATE))

ISO_KVER = 2.4.27
ISO_KREL = r7.0.0

ISO_LUNAR_MODULE = theedge

export ISO_SOURCE ISO_TARGET ISO_VERSION ISO_CODENAME ISO_DATE ISO_CNAME ISO_KVER ISO_KREL ISO_LUNAR_MODULE

all: iso

iso: isolinux $(ISO_TARGET)/.iso
$(ISO_TARGET)/.iso:
	@echo "Generating .iso file"
	@scripts/isofs

isolinux: proper initrd kernels memtest $(ISO_TARGET)/isolinux
$(ISO_TARGET)/isolinux:
	@echo "Generating isolinux files"
	@scripts/isolinux

initrd: discover $(ISO_SOURCE)/initrd/initrd
$(ISO_SOURCE)/initrd/initrd:
	@echo "Generating initrd image"
	@scripts/initrd

discover: $(ISO_SOURCE)/discover/discover
$(ISO_SOURCE)/discover/discover:
	@echo "Generating static discover"
	@scripts/discover

kernels: $(ISO_SOURCE)/kernel/safe $(ISO_SOURCE)/kernel/linux

memtest: $(ISO_SOURCE)/memtest/memtest
$(ISO_SOURCE)/memtest/memtest:
	@echo "Generating memtest boot image"
	@scripts/memtest

proper: rebuild $(ISO_TARGET)/.proper
$(ISO_TARGET)/.proper:
	@echo "Cleaning BUILD"
	@scripts/proper

rebuild: etc $(ISO_TARGET)/.rebuild
$(ISO_TARGET)/.rebuild:
	@echo "Starting rebuild process"
	@scripts/rebuild

etc: unpack $(ISO_TARGET)/.etcf
$(ISO_TARGET)/.etcf:
	@echo "Copying miscfiles"
	@scripts/etc

unpack: dirs $(ISO_TARGET)/.unpack
$(ISO_TARGET)/.unpack:
	@echo "Unpacking binaries and copying sources"
	@scripts/unpack

dirs: init $(ISO_TARGET)/.dirs
$(ISO_TARGET)/.dirs:
	@echo "Creating LSB directory structure"
	@scripts/dirs

init: $(ISO_TARGET)/.init
$(ISO_TARGET)/.init:
	@echo "Creating BUILD root"
	@scripts/init


blank:
	@scripts/blank

burn:
	@scripts/burn
