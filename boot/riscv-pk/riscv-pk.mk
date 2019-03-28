################################################################################
#
# riscv-pk
#
################################################################################

RISCV_PK_VERSION = ac2c910b18c3e36cfd85080472e78ad2fe484325
RISCV_PK_SITE = git://github.com/riscv/riscv-pk.git
RISCV_PK_LICENSE = BSD-3-Clause
RISCV_PK_LICENSE_FILES = LICENSE
RISCV_PK_DEPENDENCIES = linux
RISCV_PK_SUBDIR = build
RISCV_PK_INSTALL_IMAGES = YES

define RISCV_PK_CONFIGURE_CMDS
	mkdir -p $(@D)/build
	(cd $(@D)/build; \
		$(TARGET_CONFIGURE_OPTS) ../configure \
		--host=$(GNU_TARGET_NAME) \
		--with-payload=$(BINARIES_DIR)/vmlinux \
	)
endef

define RISCV_PK_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)/build bbl
endef

define RISCV_PK_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/bbl $(BINARIES_DIR)/bbl
endef

$(eval $(generic-package))
