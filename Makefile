#!/usr/bin/make -f
################################################################################
#
#  (openscad-amu): Project Makefile omdl
#
################################################################################

AMU_LIB_PATH        := /usr/local/share/openscad-amu/v1.9
AMU_TOOL_PREFIX     := /usr/local/bin/
AMU_TOOL_VERSION    := v1.9

AMU_PM_PREFIX       := $(AMU_LIB_PATH)/include/pmf/

#AMU_PM_VERBOSE     := defined
#AMU_PM_DEBUG       := defined

include $(AMU_PM_PREFIX)amu_pm_init

#------------------------------------------------------------------------------#
# Default Overrides
#------------------------------------------------------------------------------#
#parallel_jobs                          := $(true)
#target_headings                        := $(false)
#verbose_seam                           := $(false)
#debug_dif_filter                       := $(true)

output_path_add_project_version         := $(false)

targets_depends_project                 := $(false)
version_checks                          := $(true)
generate_latex                          := $(false)

release_project                         := $(false)
release_library                         := $(false)
release_archive_doxygen                 := $(true)
release_archive_scopes                  := $(false)

#------------------------------------------------------------------------------#
# Project Version Checks
#------------------------------------------------------------------------------#
ifeq ($(version_checks),$(true))

$(call check_version,amuseam,ge,1.9,$(true),requires openscad-amu v1.9 or later.)

ifeq ($(generate_latex),$(true))
$(call check_version,doxygen,le,1.8.9.1,$(true),latex output broken since v1.8.9.1.)
endif

endif

#------------------------------------------------------------------------------#
# Project
#------------------------------------------------------------------------------#
project_name        := omdl
project_version     := $(shell git describe --tags --dirty --always)
project_brief       := OpenSCAD Mechanical Design Library

docs_group_id       := primitives
project_logo        := mainpage_logo_top_55x55
seam_defines        := INCLUDE_PATH=include

doxygen_config      := Doxyfile
doxygen_html_footer := Doxyfooter.html
doxygen_html_css    := Doxystyle.css

project_files_add   := $(wildcard include/*.mfs)

library_info        := README.md \
                       lgpl-2.1.txt

# Polyhedra
library_db01        := database/geometry/polyhedra/anti_prisms \
                       database/geometry/polyhedra/archimedean_duals \
                       database/geometry/polyhedra/archimedean \
                       database/geometry/polyhedra/cupolas \
                       database/geometry/polyhedra/dipyramids \
                       database/geometry/polyhedra/johnson \
                       database/geometry/polyhedra/platonic \
                       database/geometry/polyhedra/prisms \
                       database/geometry/polyhedra/pyramids \
                       database/geometry/polyhedra/trapezohedron \
                       database/geometry/polyhedra/polyhedra_all

library_db01_src    := database_src/geometry/polyhedra/Makefile \
                       database_src/geometry/polyhedra/src/Makefile \
                       database_src/geometry/polyhedra/src/convert \
                       database_src/geometry/polyhedra/src/convert.conf \
                       database_src/geometry/polyhedra/src/convert.text \
                       database_src/geometry/polyhedra/src/dist/fetch.bash \
                       database_src/geometry/polyhedra/src/dist/rename

library             := $(library_db01) \
                       \
                       mainpage \
                       omdl-base \
                       \
                       console \
                       constants \
                       validation \
                       \
                       datatypes/datatypes-base \
                       datatypes/datatypes_identify_scalar \
                       datatypes/datatypes_identify_iterable \
                       datatypes/datatypes_identify_list \
                       datatypes/datatypes_operate_scalar \
                       datatypes/datatypes_operate_iterable \
                       datatypes/datatypes_operate_list \
                       \
                       datatypes/datatypes_map \
                       datatypes/datatypes_table \
                       \
                       math/math-base \
                       math/math_linear_algebra \
                       math/math_vector_algebra \
                       \
                       math/math_bitwise \
                       math/math_oshapes \
                       math/math_polytope \
                       math/math_triangle \
                       math/math_utility \
                       \
                       shapes/shapes2d \
                       shapes/shapes2de \
                       shapes/shapes3d \
                       \
                       tools/tools_align \
                       tools/tools_edge \
                       tools/tools_polytope \
                       tools/tools_utility \
                       \
                       units/units_angle \
                       units/units_coordinate \
                       units/units_length \
                       units/units_resolution

#------------------------------------------------------------------------------#
# Scope excludes
#------------------------------------------------------------------------------#
# to exclude nothing (ie: build everything) from the command line, use:
# make scopes_exclude="" all

# shape manifests: only required when doing a release
scopes_exclude      := manifest

# database: normally pre-built and released by database makefiles
scopes_exclude      += db_autotest db_autostat

#------------------------------------------------------------------------------#
# Release and backup additions
#------------------------------------------------------------------------------#
# use recursive assignment '=' for references that use derived paths
# such as: $(output_path), $(release_path), etc.

release_files_add    = $(library_info) \
                       \
                       $(output_path)stl/mainpage_quickstart.stl \
                       $(output_path)svg/shapes2d_manifest.svg \
                       $(output_path)stl/shapes2de_manifest.stl \
                       $(output_path)stl/shapes3d_manifest_1.stl \
                       $(output_path)stl/shapes3d_manifest_2.stl \
                       $(output_path)stl/tools_edge_manifest.stl

release_archive_files_add := $(library_info)

backup_files_add    := $(library_info) \
                       \
                       $(library_db01_src)

#------------------------------------------------------------------------------#
include $(AMU_PM_PREFIX)amu_pm_rules
################################################################################
# eof
################################################################################
