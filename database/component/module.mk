################################################################################
# Library Module
################################################################################

local_path        :=  database/component

local_library     :=  module

local_backup_add  :=

local_submodules  :=  electrical \
                      mechanical

#------------------------------------------------------------------------------#
# add local module
#------------------------------------------------------------------------------#
$(eval $(call add-local-module))
$(eval $(call clear-local-module))

################################################################################
# eof
################################################################################