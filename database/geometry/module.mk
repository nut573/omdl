################################################################################
# Library Module
################################################################################

local_path        :=  database/geometry

local_library     :=  module

local_backup_add  :=

local_submodules  :=  polyhedra

#------------------------------------------------------------------------------#
# add local module
#------------------------------------------------------------------------------#
$(eval $(call add-local-module))
$(eval $(call clear-local-module))

################################################################################
# eof
################################################################################