//! Shape extrusion tools.
/***************************************************************************//**
  \file
  \author Roy Allen Sutton
  \date   2015-2018

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

    \amu_pathid parent      (++path)
    \amu_pathid group       (++path ++stem)

    \amu_define group_name  ()
    \amu_define group_brief ()

  \ingroup \amu_eval(${parent} ${group})
*******************************************************************************/

include <../math/bitwise.scad>;

//----------------------------------------------------------------------------//
// openscad-amu macros
//----------------------------------------------------------------------------//

/***************************************************************************//**
  \amu_scope  mfscript  (index=1)
  \amu_source stem      (++stem)
  \amu_eval             (++global scope=dim size=qvga view=diag)
  \amu_define img_stem  (${stem}_${scope}_${size}_${view}_${function})
  \amu_define example_dim
  (
    \image html  ${img_stem}.png "${function}"
    \image latex ${img_stem}.eps "${function}" width=2.5in
    \dontinclude ${mfscript}.scad \skipline ${function}(
  )
*******************************************************************************/

//----------------------------------------------------------------------------//
// group.
//----------------------------------------------------------------------------//

/***************************************************************************//**
  \addtogroup \amu_eval(${parent})

    \amu_define caption (Extrude)

    \amu_make png_files (append=dim extension=png)
    \amu_make eps_files (append=dim extension=png2eps)
    \amu_word  file_cnt (words="${png_files}" ++count)
    \amu_seq   cell_num (last="${file_cnt}" ++roman)

    \amu_eval   fprefix (function="" ${img_stem})
    \amu_filename fname (files="${png_files}" ++stem)
    \amu_replace  fname (text="${fname}" search="${fprefix}")
    \amu_combine  fname ("${fname}" p="<center>" s="()</center>" j="" f="^")

    \amu_image_table
      (
        type=html columns=4 image_width="200" cell_files="${png_files}"
        table_caption="${caption}" cell_captions="${cell_num}"
        cell_end="${fname}"
      )
    \latexonly
      \amu_image_table
        (
          type=latex columns=4 image_width="1.25in" cell_files="${eps_files}"
          table_caption="${caption}" cell_captions="${cell_num}"
        )
    \endlatexonly
*******************************************************************************/

/***************************************************************************//**
  \addtogroup \amu_eval(${parent})
  @{

  \defgroup \amu_eval(${group}) Extrude
  \brief    Shape extrusion tools.
  @{
*******************************************************************************/

//----------------------------------------------------------------------------//

//! Translate, rotate, and revolve the 2d shape about the z-axis.
/***************************************************************************//**
  \param    r <decimal> The rotation radius.
  \param    pa <decimal> The profile pitch angle in degrees.
  \param    ra <decimal> The rotation sweep angle in degrees.
  \param    profile <boolean> Show profile only (do not extrude).

  \details

    \b Example
    \amu_eval ( function=rotate_extrude_tr ${example_dim} )
*******************************************************************************/
module rotate_extrude_tr
(
  r,
  pa = 0,
  ra = 360,
  profile = false
)
{
  rotate_extrude(angle = (profile==true ? 1 : ra) )
  translate([r, 0])
  rotate([0, 0, pa])
  children();
}

//! Translate, rotate, and revolve the 2d shape about the z-axis with linear elongation.
/***************************************************************************//**
  \param    r <decimal> The rotation radius.
  \param    l <decimal-list-2|decimal> The elongation length.
            A list [x, y] of decimals or a single decimal for (x=y)
  \param    pa <decimal> The profile pitch angle in degrees.
  \param    ra <decimal> The rotation sweep angle in degrees.
  \param    m <integer> The section render mode. An 8-bit encoded integer
            that indicates the revolution sections to render.
            Bit values \b 1 enables the corresponding section and bit values
            \b 0 are disabled. Sections are assigned to the bit position in
            counter-clockwise order.
  \param    profile <boolean> Show profile only (do not extrude).

  \details

    \b Example
    \amu_eval ( function=rotate_extrude_tre ${example_dim} )

  \note When elongating <tt>(l > 0)</tt>, \p ra is ignored. However, \p m
        may be used to control which complete revolution section to render.
*******************************************************************************/
module rotate_extrude_tre
(
  r,
  l,
  pa = 0,
  ra = 360,
  m = 255,
  profile = false
)
{
  if ( not_defined(l) || (profile==true) )
  {
    rotate_extrude_tr(r=r, pa=pa, ra=ra, profile=profile)
    children();
  }
  else
  {
    ld = is_scalar(l) ? l : 0;
    lx = edefined_or(l, 0, ld);
    ly = edefined_or(l, 1, ld);

    for
    (
      i = [
             [+lx/2, +ly/2,   0, 1],
             [-lx/2, +ly/2,  90, 3],
             [-lx/2, -ly/2, 180, 5],
             [+lx/2, -ly/2, 270, 7]
          ]
    )
    if ( bitwise_is_equal(m, i[3], 1) )
    {
      translate([i[0], i[1], 0])
      rotate([0, 0, i[2]])
      rotate_extrude_tr(r=r, pa=pa, ra=90, profile=profile)
      children();
    }

    for
    (
      i = [
            [ +r +lx/2,    +ly/2,   0, ly, 0],
            [    -lx/2, +r +ly/2,  90, lx, 2],
            [ -r -lx/2,    -ly/2, 180, ly, 4],
            [     lx/2, -r -ly/2, 270, lx, 6]
          ]
    )
    if ( bitwise_is_equal(m, i[4], 1) )
    {
      translate([i[0], i[1], 0])
      rotate([90, 0, i[2]])
      linear_extrude(height=i[3])
      rotate([0, 0, pa])
      children();
    }
  }
}

//! Linearly extrude 2d shape with extrusion upper and lower scaling.
/***************************************************************************//**
  \param    h <decimal-list-3:9|decimal> A list of decimals or a single
            decimal to specify simple extrusion height.
  \param    center <boolean> Center extrusion about origin.

  \details

    When \p h is a decimal, the shape is extruded linearly as normal.
    To scale the upper and lower slices of the extrusion, \p h must be
    assigned a list with a minimum of three decimal values as described
    in the following table.

      sym | h[n] | default | description
    :----:|:----:|:-------:|:---------------------------------------
      h   |  0   |         | total extrusion height
      n1  |  1   |         | (+z) number of scaled extrusion slices
      h1  |  2   |         | (+z) extrusion scale percentage
      x1  |  3   | -h1     | (+z) x-dimension scale percentage
      y1  |  4   |  x1     | (+z) y-dimension scale percentage
      n2  |  5   |  n1     | (-z) number of scaled extrusion slices
      h2  |  6   |  h1     | (-z) extrusion scale percentage
      x2  |  7   |  x1     | (-z) x-dimension scale percentage
      y2  |  8   |  y1     | (-z) y-dimension scale percentage

  \details

    \b Example
    \amu_eval ( function=linear_extrude_uls ${example_dim} )

  \note When symmetrical scaling is desired, shape must be centered about
        origin.

  \todo This function should be rewritten to use the built-in scaling
        provided by linear_extrude() in the upper and lower scaling zones.
*******************************************************************************/
module linear_extrude_uls
(
  h,
  center = false
)
{
  if ( not_defined(h) )
  {
    children();
  }
  else if ( is_scalar(h) )
  {
    translate(center==true ? [0, 0, -h/2] : origin3d)
    linear_extrude(height=h)
    children();
  }
  else
  {
    z = h[0];                                   // total height

    n1 = (len(h) >= 3) ? max(h[1], 0)  : undef; // number of scaled-slices
    z1 = (len(h) >= 3) ? abs(h[2])/100 : undef; // z scale fraction
    x1 = (len(h) >= 4) ?     h[3] /100 : -z1;   // x scale fraction
    y1 = (len(h) >= 5) ?     h[4] /100 : x1;    // y scale fraction

    n2 = (len(h) >= 6) ? max(h[5], 0)  : n1;
    z2 = (len(h) >= 7) ? abs(h[6])/100 : z1;
    x2 = (len(h) >= 8) ?     h[7] /100 : x1;
    y2 = (len(h) >= 9) ?     h[8] /100 : y1;

    h1 = (n1>0) ? z1 * z : 0;
    h2 = (n2>0) ? z2 * z : 0;
    h0 = z - h1 - h2;

    translate(center==true ? [0, 0, -z/2] : origin3d)
    {
      if (h1 > 0)
      {
        translate([0, 0, h0+h2])
        for( s = [0 : n1-1] )
        {
          translate([0, 0, h1/n1*s])
          scale([1+x1/n1*(s+1), 1+y1/n1*(s+1), 1])
          linear_extrude(height=h1/n1)
          children();
        }
      }

      translate([0, 0, h2])
      linear_extrude(height=h0)
      children();

      if (h2 > 0)
      {
        for( s = [0 : n2-1] )
        {
          translate([0, 0, h2/n2*s])
          scale([1+x2/n2*(n2-s), 1+y2/n2*(n2-s), 1])
          linear_extrude(height=h2/n2)
          children();
        }
      }
    }
  }
}

//! @}
//! @}

//----------------------------------------------------------------------------//
// openscad-amu auxiliary scripts
//----------------------------------------------------------------------------//

/*
BEGIN_SCOPE dim;
  BEGIN_OPENSCAD;
    include <tools/extrude.scad>;

    shape = "rotate_extrude_tr";
    $fn = 72;

    if (shape == "rotate_extrude_tr")
      rotate_extrude_tr( r=50, pa=45, ra=270 ) square( [10,5], center=true );
    else if (shape == "rotate_extrude_tre")
      rotate_extrude_tre( r=25, l=[5, 50], pa=45, m=31 ) square( [10,5], center=true );
    else if (shape == "linear_extrude_uls")
      linear_extrude_uls( [5,10,15,-5], center=true ) square( [20,15], center=true );
  END_OPENSCAD;

  BEGIN_MFSCRIPT;
    include --path "${INCLUDE_PATH}" {config_base,config_png}.mfs;

    views     name "views" views "diag";
    defines   name "shapes" define "shape"
              strings "
                rotate_extrude_tr
                rotate_extrude_tre
                linear_extrude_uls
              ";
    variables add_opts_combine "views shapes";
    variables add_opts "--viewall --autocenter";

    include --path "${INCLUDE_PATH}" script_std.mfs;
  END_MFSCRIPT;
END_SCOPE;
*/

//----------------------------------------------------------------------------//
// end of file
//----------------------------------------------------------------------------//
