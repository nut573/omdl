################################################################################
# Module
################################################################################
$(eval $(call clear-local-module))
#------------------------------------------------------------------------------#

local_path        :=  tools

local_library     :=  module \
                      \
                      tools_align \
                      tools_edge \
                      tools_polytope \
                      tools_utility

local_release_add :=  stl/tools_edge_manifest.stl

local_backup_add  :=

local_submodules  :=

#------------------------------------------------------------------------------#
# add local module
#------------------------------------------------------------------------------#
$(eval $(call add-local-module))

################################################################################
# eof
################################################################################
