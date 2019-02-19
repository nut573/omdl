//! Length units and conversions.
/***************************************************************************//**
  \file
  \author Roy Allen Sutton
  \date   2015-2019

  \copyright

    This file is part of [omdl] (https://github.com/royasutton/omdl),
    an OpenSCAD mechanical design library.

    The \em omdl is free software; you can redistribute it and/or modify
    it under the terms of the [GNU Lesser General Public License]
    (http://www.gnu.org/licenses/lgpl.html) as published by the Free
    Software Foundation; either version 2.1 of the License, or (at
    your option) any later version.

    The \em omdl is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with the \em omdl; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
    02110-1301, USA; or see <http://www.gnu.org/licenses/>.

  \details

    \amu_define group_name  (Lengths)
    \amu_define group_brief (Length units and conversions.)

  \amu_include (include/amu/pgid_path_pstem_pg.amu)
*******************************************************************************/

//----------------------------------------------------------------------------//
// group.
//----------------------------------------------------------------------------//

/***************************************************************************//**
  \amu_include (include/amu/group_in_parent_start.amu)

  \details

    These functions allow for lengths to be specified with units.
    Lengths specified with units are independent of (\ref length_unit_base).
    There are also unit conversion functions for converting from one unit
    to another.

    The table below enumerates the supported units.

     units id  | description
    :---------:|:----------------------:
     pm        | picometer
     nm        | nanometer
     um        | micrometer
     mm        | millimeter
     cm        | centimeter
     dm        | decimeter
      m        | meter
     km        | kilometer
     thou, mil | thousandth of an inch
     in        | inch
     ft        | feet
     yd        | yard
     mi        | mile

    \b Example

      \dontinclude \amu_scope(index=1).scad
      \skip include
      \until to="mm");

    \b Result (length_unit_base = \b mm):  \include \amu_scope(index=1)_mm.log
    \b Result (length_unit_base = \b cm):  \include \amu_scope(index=1)_cm.log
    \b Result (length_unit_base = \b mil): \include \amu_scope(index=1)_mil.log
    \b Result (length_unit_base = \b in):  \include \amu_scope(index=1)_in.log

    \b Example (equivalent lengths)

    \image html  length_dim_qvga_top.png "Unit Lengths"
    \image latex length_dim_qvga_top.eps "Unit Lengths" width=4in
*******************************************************************************/

//----------------------------------------------------------------------------//

//! <string> The base units for value storage.
length_unit_base = "mm";

//! <string> The default units when unspecified.
length_unit_default = "mm";

//! Return the long name for a length unit identifier.
/***************************************************************************//**
  \param    u <string> A length unit identifier.

  \returns  <string> The long name for a length unit identifier.
            Returns \b undef for identifiers that are not defined.

  \private
*******************************************************************************/
function length_unit_name_1d
(
  u = length_unit_default
) = u == "pm"   ? "picometer"
  : u == "nm"   ? "nanometer"
  : u == "um"   ? "micrometer"
  : u == "mm"   ? "millimeter"
  : u == "cm"   ? "centimeter"
  : u == "dm"   ? "decimeter"
  : u ==  "m"   ? "meter"
  : u == "km"   ? "kilometer"
  : u == "thou" ? "thousandth"
  : u == "mil"  ? "thousandth"
  : u == "in"   ? "inch"
  : u == "ft"   ? "feet"
  : u == "yd"   ? "yard"
  : u == "mi"   ? "mile"
  : undef;

//! Return the long name for a length unit identifier with dimension.
/***************************************************************************//**
  \param    u <string> A length unit identifier.
  \param    d <integer> A dimension. One of [1|2|3].

  \returns  <string> The long name for a length unit identifier with
            dimension.
            Returns \b undef for identifiers or dimensions that are
            not defined.

  \private
*******************************************************************************/
function length_unit_name_symbol
(
  u = length_unit_default,
  d = 1
) = d == 1 ?      length_unit_name_1d( u )
  : d == 2 ? str( length_unit_name_1d( u ), "^2" )
  : d == 3 ? str( length_unit_name_1d( u ), "^3" )
  : undef;

//! Return the long name for a length unit identifier with dimension.
/***************************************************************************//**
  \copydetails length_unit_name_symbol()

  \private
*******************************************************************************/
function length_unit_name_word
(
  u = length_unit_default,
  d = 1
) = d == 1 ?                 length_unit_name_1d( u )
  : d == 2 ? str( "square ", length_unit_name_1d( u ) )
  : d == 3 ? str( "cubic ",  length_unit_name_1d( u ) )
  : undef;

//! Return the name for a length unit identifier with dimension.
/***************************************************************************//**
  \param    w <boolean> \b true for word and \b false for symbol format.

  \copydetails length_unit_name_symbol()
*******************************************************************************/
function length_unit_name
(
  u = length_unit_default,
  d = 1,
  w = false
) = w == true ? length_unit_name_word( u, d )
  :             length_unit_name_symbol( u, d );

//! Convert a value from millimeters to other units.
/***************************************************************************//**
  \param    v <decimal-list|decimal> The value(s) to convert.
  \param    to <string> The units to which the value should be converted.

  \returns  <decimal-list|decimal> The conversion result.
            Returns \b undef for identifiers that are not defined.

  \private
*******************************************************************************/
function length_unit_mm2
(
  v,
  to
) = to == "pm"    ? ( v * 1000000000.0 )
  : to == "nm"    ? ( v * 1000000.0 )
  : to == "um"    ? ( v * 1000.0 )
  : to == "mm"    ? ( v )
  : to == "cm"    ? ( v / 10.0 )
  : to == "dm"    ? ( v / 100.0 )
  : to ==  "m"    ? ( v / 1000.0 )
  : to == "km"    ? ( v / 1000000.0 )
  : to == "thou"  ? ( v / 0.0254 )
  : to == "mil"   ? ( v / 0.0254 )
  : to == "in"    ? ( v / 25.4 )
  : to == "ft"    ? ( v / 304.8 )
  : to == "yd"    ? ( v / 914.4 )
  : to == "mi"    ? ( v / 1609344.0 )
  : undef;

//! Convert a value from some units to millimeters.
/***************************************************************************//**
  \param    v <decimal-list|decimal> The value(s) to convert.
  \param    from <string> The units of the value to be converted.

  \returns  <decimal-list|decimal> The conversion result.
            Returns \b undef for identifiers that are not defined.

  \private
*******************************************************************************/
function length_unit_2mm
(
  v,
  from
) = v / length_unit_mm2( 1, from );

//! Convert a value from from one units to another.
/***************************************************************************//**
  \param    v <decimal-list|decimal> The value(s) to convert.
  \param    from <string> The units of the value to be converted.
  \param    to <string> A units to which the value should be converted.

  \returns  <decimal-list|decimal> The conversion result.
            Returns \b undef for identifiers that are not defined.
*******************************************************************************/
function length
(
  v,
  from = length_unit_default,
  to   = length_unit_base
) = (from == to) ? v
  : length_unit_mm2( length_unit_2mm( v, from ), to );

//! Convert a value from from one units to another.
/***************************************************************************//**
  \param    v <decimal-list|decimal> The value(s) to convert.
  \param    from <string> The units of the value to be converted.
  \param    to <string> A units to which the value should be converted.

  \returns  <decimal-list|decimal> The conversion result.
            Returns \b undef for identifiers that are not defined.
*******************************************************************************/
function length_inv
(
  v,
  from = length_unit_base,
  to   = length_unit_default
) = (from == to) ? v
  : length_unit_mm2( length_unit_2mm( v, from ), to );

//! Convert a value from from one units to another with dimensions.
/***************************************************************************//**
  \param    v <decimal> The value to convert.
  \param    from <string> The units of the value to be converted.
  \param    to <string> A units to which the value should be converted.
  \param    d <integer> A dimension. One of [1|2|3].

  \returns  <decimal> The conversion result.
            Returns \b undef for identifiers or dimensions that are
            not defined.
*******************************************************************************/
function length_d
(
  v,
  from = length_unit_default,
  to   = length_unit_base,
  d    = 1
) = d == 1 ?    ( length(v, from, to)    )
  : d == 2 ? pow( length(v, from, to), 2 )
  : d == 3 ? pow( length(v, from, to), 3 )
  : undef;

//! @}
//! @}

//----------------------------------------------------------------------------//
// openscad-amu auxiliary scripts
//----------------------------------------------------------------------------//

/*
BEGIN_SCOPE example;
  BEGIN_OPENSCAD;
    include <omdl-base.scad>;

    length_unit_base = "mm";
    length_unit_default = "in";

    // get unit names
    bu = length_unit_name(length_unit_base);
    du = length_unit_name();

    // absolute length measurements in base unit.
    c1 = length(1/8);
    c2 = length(3.175, "mm");
    c3 = length(25, "mil");
    c4 = length(1, "ft", d=3);

    // convert between units.
    c5 = length(10, from="mil", to="in");
    c6 = length(10, from="ft", to="mm");

    echo( bu=bu );
    echo( du=du );
    echo( c1=c1 );
    echo( c2=c2 );
    echo( c3=c3 );
    echo( c4=c4 );
    echo( c5=c5 );
    echo( c6=c6 );
  END_OPENSCAD;

  BEGIN_MFSCRIPT;
    include --path "${INCLUDE_PATH}" {config_base,config_csg}.mfs;

    defines   name "units" define "length_unit_base" strings "mm cm mil in";
    variables add_opts_combine "units";

    include --path "${INCLUDE_PATH}" script_std.mfs;
  END_MFSCRIPT;
END_SCOPE;

BEGIN_SCOPE dim;
  BEGIN_OPENSCAD;
    include <omdl-base.scad>;

    module dim( uv=1, un="cm" ) {
      mx = 200.0;
      my = 1;
      tx = my;
      ty = mx / 10;
      ts = mx / 25;

      color( "black" )
      union() {
        square( [mx, my], true );
        translate([-mx/2,0,0]) square( [tx, ty], true );
        translate([+mx/2,0,0]) square( [tx, ty], true );
      }

      l1l = length( uv, "in", un );
      l1u = length_unit_name( un );
      l1s = str( l1l, " ", l1u );

      translate( [0, ts, 0] )
      text( text=l1s, size=ts, font="Courier:style=bold italic", halign="center", valign="center" );
    }

    unv = ["um", "mm", "cm", "mil", "in"];
    for( un = unv )
      translate( [0, 30 * search([un], unv)[0], 0] ) dim( 1, un );
  END_OPENSCAD;

  BEGIN_MFSCRIPT;
    include --path "${INCLUDE_PATH}" {config_base,config_png}.mfs;

    views     name "views" translate "0,60,0" distance "400" views "top";
    variables add_opts_combine "views";

    include --path "${INCLUDE_PATH}" script_std.mfs;
  END_MFSCRIPT;
END_SCOPE;
*/

//----------------------------------------------------------------------------//
// end of file
//----------------------------------------------------------------------------//
