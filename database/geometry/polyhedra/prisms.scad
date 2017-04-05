//! Table of polyhedra data group: \c prisms
/***************************************************************************//**
  \file   prisms.scad
  \author Roy Allen Sutton
  \date   2017

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

    This [omdl] formatted data table has been assembled using a script
    that converts the polyhedra data obtained from [Anthony Thyssen]'s
    [Studies into Polyhedra]. The vertices are tabulated in both their
    original Cartesian as well as their converted spherical coordinate
    form, which is convenient when scaling. The data originates from
    one of three sources:

      \li [Exact Mathematics] as presented by [Anthony Thyssen],
      \li the [Polyhedron Database] maintained by [Netlib], and
      \li an [Encyclopedia of Polyhedra] by [George W. Hart].

  \note Include this library file using the \b include statement.

  [omdl]: https://github.com/royasutton/omdl

  [Anthony Thyssen]: http://www.ict.griffith.edu.au/anthony/anthony.html
  [Studies into Polyhedra]: http://www.ict.griffith.edu.au/anthony/graphics/polyhedra
  [Exact Mathematics]: http://www.ict.griffith.edu.au/anthony/graphics/polyhedra/maths.shtml

  [George W. Hart]: http://www.georgehart.com
  [Encyclopedia of Polyhedra]: http://www.georgehart.com/virtual-polyhedra/vp.html

  [Netlib]: http://www.netlib.org
  [Polyhedron Database]: http://www.netlib.org/polyhedra

  \ingroup database_polyhedra
*******************************************************************************/

//----------------------------------------------------------------------------//
/***************************************************************************//**
  \addtogroup database_polyhedra
  @{
    <br>
    ### Group: prisms ###

    \amu_define caption (prisms)
    \amu_make png_files (append=db_dim extension=png)
    \amu_make stl_files (append=db_dim extension=stl)

    \amu_shell file_cnt ("echo ${png_files} | wc -w")
    \amu_shell cell_num ("seq -f '(%g)' -s '^' ${file_cnt}")

    \amu_shell html_cell_titles
      (
        "echo ${stl_files} | grep -Po 'db_dim_\K[^.]*' | tr '\n' '^'"
      )

    \htmlonly
      \amu_image_table
        (
          type=html columns=4 image_width="200" cell_files="${png_files}"
          table_caption="${caption}" cell_captions="${cell_num}"
          cell_titles="${html_cell_titles}" cell_urls="${stl_files}"
        )
    \endhtmlonly

    \amu_define caption (prisms)
    \amu_make eps_files (append=db_dim extension=png2eps)

    \latexonly
      \amu_image_table
        (
          type=latex columns=4 image_width="1.25in" cell_files="${eps_files}"
          table_caption="${caption}" cell_captions="${cell_num}"
        )
    \endlatexonly

    \amu_shell data
      (
        "grep -Po 'ECHO: \"\K[^\"]*' build/csg/prisms_db_autostat.log" --rmnl
      )
    \amu_shell columns ("echo '${data}' | awk -F '^' 'NR==1 {print NF;exit}'")
    \amu_shell heading ("echo '${data}' | awk -F '^' 'NR==1 {print;exit}'")
    \amu_shell texts   ("echo '${data}' | awk -F '^' 'NR>1 {print}'")

    \amu_table
      (
        columns=${columns} column_headings="${heading}" cell_texts="${texts}"
      )
*******************************************************************************/
//----------------------------------------------------------------------------//

//! <matrix-2x9> \c prisms polyhedra data table columns definition.
//! \hideinitializer
dtc_polyhedra_prisms =
[
  ["id", "identifier"],
  ["n", "name"],
  ["o", "other name"],
  ["g", "group"],
  ["d", "data source"],
  ["c", "cartesian vertices"],
  ["s", "spherical vertices"],
  ["f", "faces"],
  ["e", "edges"]
];

//! <matrix-9xR> \c prisms polyhedra data table rows.
//! \hideinitializer
dtr_polyhedra_prisms =
[
  [
    "decagonal_prism",
    "Decagonal Prism",
    empty_str,
    "prisms",
    "Polyhedron Database #26",
    [
      [-0.95542256321,  0.29524180884, -0.00000000000],
      [-0.77295309045,  0.29524180884,  0.56158329236],
      [-0.77295309045,  0.29524180884, -0.56158329236],
      [-0.95542256321, -0.29524180884, -0.00000000000],
      [-0.77295309045, -0.29524180884,  0.56158329236],
      [-0.77295309045, -0.29524180884, -0.56158329236],
      [-0.29524180884,  0.29524180884,  0.90866085456],
      [-0.29524180884,  0.29524180884, -0.90866085456],
      [-0.29524180884, -0.29524180884,  0.90866085456],
      [-0.29524180884, -0.29524180884, -0.90866085456],
      [ 0.29524180884,  0.29524180884,  0.90866085456],
      [ 0.29524180884,  0.29524180884, -0.90866085456],
      [ 0.29524180884, -0.29524180884,  0.90866085456],
      [ 0.29524180884, -0.29524180884, -0.90866085456],
      [ 0.77295309045,  0.29524180884,  0.56158329236],
      [ 0.77295309045,  0.29524180884, -0.56158329236],
      [ 0.95542256321,  0.29524180884, -0.00000000000],
      [ 0.77295309045, -0.29524180884,  0.56158329236],
      [ 0.77295309045, -0.29524180884, -0.56158329236],
      [ 0.95542256321, -0.29524180884, -0.00000000000]
    ],
    [
      [0.99999999999,  162.82796214954,  89.99999999999],
      [0.99999999999,  159.09484255227,  55.83463617203],
      [0.99999999999,  159.09484255227, 124.16536382795],
      [0.99999999999, -162.82796214954,  89.99999999999],
      [0.99999999999, -159.09484255227,  55.83463617203],
      [0.99999999999, -159.09484255227, 124.16536382795],
      [0.99999999999,  134.99999999999,  24.67905738915],
      [0.99999999999,  134.99999999999, 155.32094261084],
      [0.99999999999, -134.99999999999,  24.67905738915],
      [0.99999999999, -134.99999999999, 155.32094261084],
      [0.99999999999,   45.00000000000,  24.67905738915],
      [0.99999999999,   45.00000000000, 155.32094261084],
      [0.99999999999,  -45.00000000000,  24.67905738915],
      [0.99999999999,  -45.00000000000, 155.32094261084],
      [0.99999999999,   20.90515744772,  55.83463617203],
      [0.99999999999,   20.90515744772, 124.16536382795],
      [0.99999999999,   17.17203785045,  89.99999999999],
      [0.99999999999,  -20.90515744772,  55.83463617203],
      [0.99999999999,  -20.90515744772, 124.16536382795],
      [0.99999999999,  -17.17203785045,  89.99999999999]
    ],
    [
      [17,19,18,13,9,5,3,4,8,12],
      [1,0,2,7,11,15,16,14,10,6],
      [2,5,9,7],
      [0,3,5,2],
      [1,4,3,0],
      [6,8,4,1],
      [10,12,8,6],
      [14,17,12,10],
      [16,19,17,14],
      [15,18,19,16],
      [11,13,18,15],
      [7,9,13,11]
    ],
    [
      [0,1],
      [0,2],
      [0,3],
      [1,4],
      [1,6],
      [2,5],
      [2,7],
      [3,4],
      [3,5],
      [4,8],
      [5,9],
      [6,8],
      [6,10],
      [7,9],
      [7,11],
      [8,12],
      [9,13],
      [10,12],
      [10,14],
      [11,13],
      [11,15],
      [12,17],
      [13,18],
      [14,16],
      [14,17],
      [15,16],
      [15,18],
      [16,19],
      [17,19],
      [18,19]
    ]
  ],
  [
    "hexagonal_prism",
    "Hexagonal Prism",
    empty_str,
    "prisms",
    "Polyhedron Database #24",
    [
      [-0.89442719100,  0.44721359550,  0.00000000000],
      [-0.44721359550,  0.44721359550,  0.77459666924],
      [-0.44721359550,  0.44721359550, -0.77459666924],
      [ 0.44721359550,  0.44721359550,  0.77459666924],
      [ 0.44721359550,  0.44721359550, -0.77459666924],
      [-0.89442719100, -0.44721359550,  0.00000000000],
      [ 0.89442719100,  0.44721359550,  0.00000000000],
      [-0.44721359550, -0.44721359550,  0.77459666924],
      [-0.44721359550, -0.44721359550, -0.77459666924],
      [ 0.44721359550, -0.44721359550,  0.77459666924],
      [ 0.44721359550, -0.44721359550, -0.77459666924],
      [ 0.89442719100, -0.44721359550,  0.00000000000]
    ],
    [
      [1.00000000000,  153.43494882291,  89.99999999994],
      [1.00000000000,  135.00000000000,  39.23152048360],
      [1.00000000000,  135.00000000000, 140.76847951642],
      [1.00000000000,   45.00000000000,  39.23152048360],
      [1.00000000000,   45.00000000000, 140.76847951642],
      [1.00000000000, -153.43494882291,  89.99999999994],
      [1.00000000000,   26.56505117708,  89.99999999994],
      [1.00000000000, -134.99999999998,  39.23152048360],
      [1.00000000000, -134.99999999998, 140.76847951642],
      [1.00000000000,  -44.99999999999,  39.23152048360],
      [1.00000000000,  -44.99999999999, 140.76847951642],
      [1.00000000000,  -26.56505117707,  89.99999999994]
    ],
    [
      [11,10,8,5,7,9],
      [0,2,4,6,3,1],
      [0,5,8,2],
      [1,7,5,0],
      [3,9,7,1],
      [6,11,9,3],
      [4,10,11,6],
      [2,8,10,4]
    ],
    [
      [0,1],
      [0,2],
      [0,5],
      [1,3],
      [1,7],
      [2,4],
      [2,8],
      [3,6],
      [3,9],
      [4,6],
      [4,10],
      [5,7],
      [5,8],
      [6,11],
      [7,9],
      [8,10],
      [9,11],
      [10,11]
    ]
  ],
  [
    "octagonal_prism",
    "Octagonal Prism",
    empty_str,
    "prisms",
    "Polyhedron Database #25",
    [
      [-0.86285620946,  0.35740674434,  0.35740674434],
      [-0.86285620946,  0.35740674434, -0.35740674434],
      [-0.35740674434,  0.35740674434,  0.86285620946],
      [-0.35740674434,  0.35740674434, -0.86285620946],
      [-0.86285620946, -0.35740674434,  0.35740674434],
      [-0.86285620946, -0.35740674434, -0.35740674434],
      [-0.35740674434, -0.35740674434,  0.86285620946],
      [ 0.35740674434,  0.35740674434,  0.86285620946],
      [-0.35740674434, -0.35740674434, -0.86285620946],
      [ 0.35740674434,  0.35740674434, -0.86285620946],
      [ 0.86285620946,  0.35740674434,  0.35740674434],
      [ 0.86285620946,  0.35740674434, -0.35740674434],
      [ 0.35740674434, -0.35740674434,  0.86285620946],
      [ 0.35740674434, -0.35740674434, -0.86285620946],
      [ 0.86285620946, -0.35740674434,  0.35740674434],
      [ 0.86285620946, -0.35740674434, -0.35740674434]
    ],
    [
      [1.00000000000,  157.50000000001,  69.05897952780],
      [1.00000000000,  157.50000000001, 110.94102047226],
      [1.00000000000,  134.99999999999,  30.36119340482],
      [1.00000000000,  134.99999999999, 149.63880659514],
      [1.00000000000, -157.50000000001,  69.05897952780],
      [1.00000000000, -157.50000000001, 110.94102047226],
      [1.00000000000, -134.99999999999,  30.36119340482],
      [1.00000000000,   45.00000000000,  30.36119340482],
      [1.00000000000, -134.99999999999, 149.63880659514],
      [1.00000000000,   45.00000000000, 149.63880659514],
      [1.00000000000,   22.49999999998,  69.05897952780],
      [1.00000000000,   22.49999999998, 110.94102047226],
      [1.00000000000,  -45.00000000000,  30.36119340482],
      [1.00000000000,  -45.00000000000, 149.63880659514],
      [1.00000000000,  -22.49999999998,  69.05897952780],
      [1.00000000000,  -22.49999999998, 110.94102047226]
    ],
    [
      [14,15,13,8,5,4,6,12],
      [0,1,3,9,11,10,7,2],
      [1,5,8,3],
      [0,4,5,1],
      [2,6,4,0],
      [7,12,6,2],
      [10,14,12,7],
      [11,15,14,10],
      [9,13,15,11],
      [3,8,13,9]
    ],
    [
      [0,1],
      [0,2],
      [0,4],
      [1,3],
      [1,5],
      [2,6],
      [2,7],
      [3,8],
      [3,9],
      [4,5],
      [4,6],
      [5,8],
      [6,12],
      [7,10],
      [7,12],
      [8,13],
      [9,11],
      [9,13],
      [10,11],
      [10,14],
      [11,15],
      [12,14],
      [13,15],
      [14,15]
    ]
  ],
  [
    "pentagonal_prism",
    "Pentagonal Prism",
    empty_str,
    "prisms",
    "Polyhedron Database #23",
    [
      [-0.81990936291, -0.50673185397, -0.26640470114],
      [-0.81990936291,  0.50673185397, -0.26640470114],
      [-0.50673185397, -0.50673185397,  0.69745656233],
      [-0.50673185397,  0.50673185397,  0.69745656233],
      [ 0.00000000000, -0.50673185397, -0.86210372240],
      [ 0.00000000000,  0.50673185397, -0.86210372240],
      [ 0.50673185397, -0.50673185397,  0.69745656233],
      [ 0.50673185397,  0.50673185397,  0.69745656233],
      [ 0.81990936291, -0.50673185397, -0.26640470114],
      [ 0.81990936291,  0.50673185397, -0.26640470114]
    ],
    [
      [1.00000000000, -148.28252558848, 105.45043708638],
      [1.00000000000,  148.28252558848, 105.45043708638],
      [1.00000000000, -134.99999999999,  45.77670183604],
      [1.00000000000,  134.99999999999,  45.77670183604],
      [1.00000000000,  -89.99999999999, 149.55361568293],
      [1.00000000000,   89.99999999999, 149.55361568293],
      [1.00000000000,  -45.00000000000,  45.77670183604],
      [1.00000000000,   45.00000000000,  45.77670183604],
      [1.00000000000,  -31.71747441151, 105.45043708638],
      [1.00000000000,   31.71747441151, 105.45043708638]
    ],
    [
      [8,4,0,2,6],
      [1,5,9,7,3],
      [1,0,4,5],
      [3,2,0,1],
      [7,6,2,3],
      [9,8,6,7],
      [5,4,8,9]
    ],
    [
      [0,1],
      [0,2],
      [0,4],
      [1,3],
      [1,5],
      [2,3],
      [2,6],
      [3,7],
      [4,5],
      [4,8],
      [5,9],
      [6,7],
      [6,8],
      [7,9],
      [8,9]
    ]
  ],
  [
    "square_prism",
    "Square Prism",
    "Cube",
    "prisms",
    "Polyhedron Database #1",
    [
      [-0.57735026919, -0.57735026919, -0.57735026919],
      [-0.57735026919, -0.57735026919,  0.57735026919],
      [-0.57735026919,  0.57735026919, -0.57735026919],
      [-0.57735026919,  0.57735026919,  0.57735026919],
      [ 0.57735026919, -0.57735026919, -0.57735026919],
      [ 0.57735026919, -0.57735026919,  0.57735026919],
      [ 0.57735026919,  0.57735026919, -0.57735026919],
      [ 0.57735026919,  0.57735026919,  0.57735026919]
    ],
    [
      [1.00000000000, -134.99999999999, 125.26438968275],
      [1.00000000000, -134.99999999999,  54.73561031724],
      [1.00000000000,  134.99999999999, 125.26438968275],
      [1.00000000000,  134.99999999999,  54.73561031724],
      [1.00000000000,  -45.00000000000, 125.26438968275],
      [1.00000000000,  -45.00000000000,  54.73561031724],
      [1.00000000000,   45.00000000000, 125.26438968275],
      [1.00000000000,   45.00000000000,  54.73561031724]
    ],
    [
      [5,4,0,1],
      [7,5,1,3],
      [1,0,2,3],
      [4,6,2,0],
      [7,6,4,5],
      [3,2,6,7]
    ],
    [
      [0,1],
      [0,2],
      [0,4],
      [1,3],
      [1,5],
      [2,3],
      [2,6],
      [3,7],
      [4,5],
      [4,6],
      [5,7],
      [6,7]
    ]
  ],
  [
    "triangular_prism",
    "Triangular Prism",
    empty_str,
    "prisms",
    "Polyhedron Database #22",
    [
      [-0.65465367071, -0.65465367071,  0.37796447301],
      [-0.65465367071,  0.65465367071,  0.37796447301],
      [ 0.00000000000, -0.65465367071, -0.75592894602],
      [ 0.00000000000,  0.65465367071, -0.75592894602],
      [ 0.65465367071, -0.65465367071,  0.37796447301],
      [ 0.65465367071,  0.65465367071,  0.37796447301]
    ],
    [
      [1.00000000000, -134.99999999999,  67.79234570143],
      [1.00000000000,  134.99999999999,  67.79234570143],
      [1.00000000000,  -89.99999999999, 139.10660535081],
      [1.00000000000,   89.99999999999, 139.10660535081],
      [1.00000000000,  -45.00000000000,  67.79234570143],
      [1.00000000000,   45.00000000000,  67.79234570143]
    ],
    [
      [2,0,4],
      [3,5,1],
      [1,0,2,3],
      [5,4,0,1],
      [3,2,4,5]
    ],
    [
      [0,1],
      [0,2],
      [0,4],
      [1,3],
      [1,5],
      [2,3],
      [2,4],
      [3,5],
      [4,5]
    ]
  ]
];

//! @}

//----------------------------------------------------------------------------//
// openscad-amu auxiliary scripts
//----------------------------------------------------------------------------//

/*
BEGIN_SCOPE db;
BEGIN_SCOPE autostat;
  BEGIN_OPENSCAD;
    include <math/math_polytope.scad>;
    include <math/math_utility.scad>;
    include <datatypes/datatypes_table.scad>;
    include <database/geometry/polyhedra/prisms.scad>;

    fs  = "^";

    tc = dtc_polyhedra_prisms;
    tr = dtr_polyhedra_prisms;

    ids = get_table_ridl(tr);

    echo
    (
      str
      (
        "no.", fs, "table id", fs, "other name", fs,
        "vertices", fs, "faces", fs, "edges",

        fs, "face-verticies",
        fs, "face-angles",
        fs, "edge-lengths",
        fs, "edge-angles"
      )
    );

    for ( id = ids )
    {
      i = first(find(id, ids, c=1))+1;

      n = get_table_v(tr, tc, id, "n");
      o = get_table_v(tr, tc, id, "o");
      g = get_table_v(tr, tc, id, "g");
      d = get_table_v(tr, tc, id, "d");

      c = get_table_v(tr, tc, id, "c");
      s = get_table_v(tr, tc, id, "s");
      f = get_table_v(tr, tc, id, "f");
      e = get_table_v(tr, tc, id, "e");

      fo = is_empty(o) ? "-" : o;

      echo
      (
        str
        (
          i, fs, id, fs, fo, fs,
          len(c), fs, len(f), fs, len(e),

          fs, hist(qsort(polytope_face_vcounts(f)), m=9),
          fs, hist(qsort(dround(polytope_face_angles(c, f), d=1)), m=9),
          fs, hist(qsort(sround(polytope_edge_lengths(c, e), d=3)), m=9),
          fs, hist(qsort(dround(polytope_edge_angles(c, f), d=1)), m=9),

          fs
        )
      );
    }
  END_OPENSCAD;

  BEGIN_MFSCRIPT;
    include --path "${INCLUDE_PATH}" {config_base,config_csg}.mfs;
    include --path "${INCLUDE_PATH}" script_std.mfs;
  END_MFSCRIPT;
END_SCOPE;
END_SCOPE;
*/

/*
BEGIN_SCOPE db;
BEGIN_SCOPE dim;
  BEGIN_OPENSCAD;
    include <units/units_coordinate.scad>;
    include <tools/tools_polytope.scad>;
    include <datatypes/datatypes_table.scad>;
    include <database/geometry/polyhedra/prisms.scad>;

    config = 0;

    tc = dtc_polyhedra_prisms;
    tr = dtr_polyhedra_prisms;

    id = "default";
    sr = 100;

    pv = get_table_v(tr, tc, id, "c");
    pf = get_table_v(tr, tc, id, "f");
    pe = get_table_v(tr, tc, id, "e");

    sv = coordinates_csc(pv, sr);

    if (config == 0)  // png preview
    {
      $fn = 25;

      %polyhedron(sv, pf);

      polytope_frame(sv, pf, pe)
      {
        circle(r = sr / 25);
        color("lightblue")
        sphere(r = sr / 25 * (1 + 1/2));
      }
    }

    if (config == 1)  // stl model
    {
      polyhedron(sv, pf);
    }
  END_OPENSCAD;

  BEGIN_MFSCRIPT;
    include --path "${INCLUDE_PATH}" {config_base,config_png}.mfs;

    views     name "views" views "diag";
    defines   name "ids" define "id"
              strings
              "
                decagonal_prism
                hexagonal_prism
                octagonal_prism
                pentagonal_prism
                square_prism
                triangular_prism
              ";
    variables add_opts_combine "views ids";
    variables add_opts "-D config=0 --viewall --autocenter";

    include --path "${INCLUDE_PATH}" script_new.mfs;

    include --path "${INCLUDE_PATH}" config_stl.mfs;
    variables add_opts_combine "ids";
    variables add_opts "-D config=1";

    include --path "${INCLUDE_PATH}" script_app.mfs;
  END_MFSCRIPT;
END_SCOPE;
END_SCOPE;
*/

//----------------------------------------------------------------------------//
// end of file
//----------------------------------------------------------------------------//