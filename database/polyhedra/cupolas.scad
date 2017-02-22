//! Table of polyhedra data group: \c cupolas
/***************************************************************************//**
  \file   cupolas.scad
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
    one of three sources, in order of decreasing accuracy:

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
  \addtogroup database
  @{

  \addtogroup database_polyhedra
  @{
    <br>
    ### Group: cupolas ###

    \amu_define caption (cupolas)
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

    \amu_define caption (cupolas)
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
        "grep -Po 'ECHO: \"\K[^\"]*' build/csg/cupolas_db_autostat.log" --rmnl
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

//! \<table> \c cupolas polyhedra data table columns definition.
dtc_polyhedra_cupolas =
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

//! \<table> \c cupolas polyhedra data table rows.
dtr_polyhedra_cupolas =
[
  [
    "pentagonal_cupola",
    "Pentagonal Cupola",
    "J5",
    "cupolas",
    "Polyhedron Database #49",
    [
      [ 0.30722035250, -0.10767686506, -0.94552702116],
      [-0.30722035250, -0.10767686506, -0.94552702116],
      [ 0.80431332487, -0.10767686506, -0.58436783636],
      [ 0.30722035250,  0.21535373011, -0.42285253878],
      [-0.30722035250,  0.21535373011, -0.42285253878],
      [-0.80431332487, -0.10767686506, -0.58436783636],
      [ 0.99418594475, -0.10767686506,  0.00000000000],
      [ 0.49709297237,  0.21535373011,  0.16151529758],
      [-0.49709297237,  0.21535373011,  0.16151529758],
      [-0.99418594475, -0.10767686506, -0.00000000000],
      [ 0.00000000000,  0.21535373011,  0.52267448238],
      [ 0.80431332487, -0.10767686506,  0.58436783636],
      [-0.80431332487, -0.10767686506,  0.58436783636],
      [ 0.30722035250, -0.10767686506,  0.94552702116],
      [-0.30722035250, -0.10767686506,  0.94552702116]
    ],
    [
      [1.00000000000,  -19.31492121303, 161.00148636537],
      [1.00000000000, -160.68507878696, 161.00148636537],
      [1.00000000000,   -7.62509363515, 125.75834309459],
      [0.56530155104,   35.02948816948, 138.41849317790],
      [0.56530155104,  144.97051183050, 138.41849317790],
      [1.00000000000, -172.37490636484, 125.75834309458],
      [1.00000000000,   -6.18141426338,  89.99999999999],
      [0.56530155104,   23.42352770491,  73.39839025197],
      [0.56530155104,  156.57647229507,  73.39839025196],
      [1.00000000000, -173.81858573662,  89.99999999999],
      [0.56530155104,   89.99999999997,  22.39277092895],
      [1.00000000000,   -7.62509363516,  54.24165690541],
      [1.00000000000, -172.37490636484,  54.24165690540],
      [1.00000000000,  -19.31492121306,  18.99851363462],
      [1.00000000000, -160.68507878694,  18.99851363462]
    ],
    [
      [0,1,5,9,12,14,13,11,6,2],
      [7,10,8,4,3],
      [1,0,3,4],
      [5,1,4],
      [9,5,4,8],
      [12,9,8],
      [14,12,8,10],
      [13,14,10],
      [11,13,10,7],
      [6,11,7],
      [2,6,7,3],
      [0,2,3]
    ],
    [
      [0,1],
      [0,2],
      [0,3],
      [1,4],
      [1,5],
      [2,3],
      [2,6],
      [3,4],
      [3,7],
      [4,5],
      [4,8],
      [5,9],
      [6,7],
      [6,11],
      [7,10],
      [7,11],
      [8,9],
      [8,10],
      [8,12],
      [9,12],
      [10,13],
      [10,14],
      [11,13],
      [12,14],
      [13,14]
    ]
  ],
  [
    "pentagonal_gyrobicupola",
    "Pentagonal Gyrobicupola",
    "J31",
    "cupolas",
    "Polyhedron Database #75",
    [
      [ 0.80901699437,  0.00000000000,  0.58778525229],
      [ 0.30901699437,  0.00000000000,  0.95105651630],
      [ 1.00000000000,  0.00000000000, -0.00000000000],
      [-0.30901699437,  0.00000000000,  0.95105651630],
      [ 0.30901699438, -0.32491969623,  0.42532540418],
      [ 0.50000000000,  0.32491969623,  0.16245984812],
      [ 0.00000000000,  0.32491969623,  0.52573111212],
      [ 0.50000000000, -0.32491969623, -0.16245984812],
      [-0.30901699437, -0.32491969623,  0.42532540418],
      [ 0.80901699437,  0.00000000000, -0.58778525229],
      [-0.80901699437,  0.00000000000,  0.58778525229],
      [ 0.30901699437,  0.32491969623, -0.42532540418],
      [-0.50000000000,  0.32491969623,  0.16245984812],
      [-0.00000000000, -0.32491969623, -0.52573111212],
      [-0.50000000000, -0.32491969623, -0.16245984812],
      [-0.30901699438,  0.32491969623, -0.42532540418],
      [ 0.30901699437, -0.00000000000, -0.95105651630],
      [-1.00000000000,  0.00000000000,  0.00000000000],
      [-0.30901699437, -0.00000000000, -0.95105651630],
      [-0.80901699437, -0.00000000000, -0.58778525229]
    ],
    [
      [1.00000000000,    0.00000000001,  54.00000000000],
      [1.00000000000,    0.00000000002,  18.00000000000],
      [1.00000000000,    0.00000000000,  89.99999999999],
      [1.00000000000,  179.99999999997,  18.00000000000],
      [0.61803398875,  -46.43699940041,  46.51292225447],
      [0.61803398875,   33.01739809414,  74.75983771732],
      [0.61803398875,   89.99999999999,  31.71747441146],
      [0.61803398875,  -33.01739809415, 105.24016228267],
      [0.61803398875, -133.56300059956,  46.51292225447],
      [1.00000000000,    0.00000000000, 125.99999999999],
      [1.00000000000,  179.99999999999,  54.00000000000],
      [0.61803398875,   46.43699940043, 133.48707774552],
      [0.61803398875,  146.98260190584,  74.75983771731],
      [0.61803398875,  -89.99999999999, 148.28252558853],
      [0.61803398875, -146.98260190585, 105.24016228267],
      [0.61803398875,  133.56300059958, 133.48707774551],
      [1.00000000000,   -0.00000000002, 161.99999999999],
      [1.00000000000,  179.99999999999,  89.99999999999],
      [1.00000000000, -179.99999999997, 161.99999999999],
      [1.00000000000, -179.99999999998, 125.99999999999]
    ],
    [
      [13,14,8,4,7],
      [0,2,7,4],
      [1,0,4],
      [3,1,4,8],
      [10,3,8],
      [17,10,8,14],
      [19,17,14],
      [18,19,14,13],
      [16,18,13],
      [9,16,13,7],
      [2,9,7],
      [12,15,11,5,6],
      [0,1,6,5],
      [2,0,5],
      [9,2,5,11],
      [16,9,11],
      [18,16,11,15],
      [19,18,15],
      [17,19,15,12],
      [10,17,12],
      [3,10,12,6],
      [1,3,6]
    ],
    [
      [0,1],
      [0,2],
      [0,4],
      [0,5],
      [1,3],
      [1,4],
      [1,6],
      [2,5],
      [2,7],
      [2,9],
      [3,6],
      [3,8],
      [3,10],
      [4,7],
      [4,8],
      [5,6],
      [5,11],
      [6,12],
      [7,9],
      [7,13],
      [8,10],
      [8,14],
      [9,11],
      [9,16],
      [10,12],
      [10,17],
      [11,15],
      [11,16],
      [12,15],
      [12,17],
      [13,14],
      [13,16],
      [13,18],
      [14,17],
      [14,19],
      [15,18],
      [15,19],
      [16,18],
      [17,19],
      [18,19]
    ]
  ],
  [
    "pentagonal_orthobicupola",
    "Pentagonal Orthobicupola",
    "J30",
    "cupolas",
    "Polyhedron Database #74",
    [
      [ 0.30901699438,  0.00000000000,  0.95105651630],
      [-0.30901699437,  0.00000000000,  0.95105651630],
      [ 0.80901699437,  0.00000000000,  0.58778525229],
      [ 0.00000000000,  0.32491969623,  0.52573111212],
      [-0.00000000000, -0.32491969623,  0.52573111212],
      [-0.80901699437,  0.00000000000,  0.58778525229],
      [ 0.50000000000,  0.32491969623,  0.16245984812],
      [ 0.50000000000, -0.32491969623,  0.16245984812],
      [ 1.00000000000,  0.00000000000, -0.00000000000],
      [-0.50000000000,  0.32491969623,  0.16245984812],
      [-0.50000000000, -0.32491969623,  0.16245984812],
      [-1.00000000000,  0.00000000000,  0.00000000000],
      [ 0.30901699437,  0.32491969623, -0.42532540418],
      [ 0.30901699437, -0.32491969623, -0.42532540418],
      [ 0.80901699437, -0.00000000000, -0.58778525229],
      [-0.30901699438,  0.32491969623, -0.42532540418],
      [-0.30901699438, -0.32491969623, -0.42532540418],
      [-0.80901699437, -0.00000000000, -0.58778525229],
      [ 0.30901699437, -0.00000000000, -0.95105651630],
      [-0.30901699438,  0.00000000000, -0.95105651630]
    ],
    [
      [1.00000000000,    0.00000000000,  18.00000000000],
      [1.00000000000,  179.99999999999,  17.99999999999],
      [1.00000000000,    0.00000000001,  54.00000000000],
      [0.61803398875,   89.99999999998,  31.71747441146],
      [0.61803398875,  -89.99999999999,  31.71747441146],
      [1.00000000000,  179.99999999998,  53.99999999999],
      [0.61803398875,   33.01739809414,  74.75983771732],
      [0.61803398875,  -33.01739809414,  74.75983771731],
      [1.00000000000,    0.00000000000,  90.00000000000],
      [0.61803398875,  146.98260190585,  74.75983771731],
      [0.61803398875, -146.98260190585,  74.75983771731],
      [1.00000000000,  179.99999999999,  89.99999999999],
      [0.61803398875,   46.43699940043, 133.48707774551],
      [0.61803398875,  -46.43699940043, 133.48707774551],
      [1.00000000000,   -0.00000000001, 125.99999999999],
      [0.61803398875,  133.56300059957, 133.48707774552],
      [0.61803398875, -133.56300059957, 133.48707774551],
      [1.00000000000, -179.99999999998, 125.99999999999],
      [1.00000000000,   -0.00000000002, 162.00000000000],
      [1.00000000000,  179.99999999999, 161.99999999999]
    ],
    [
      [13,16,10,4,7],
      [0,2,7,4],
      [1,0,4],
      [5,1,4,10],
      [11,5,10],
      [17,11,10,16],
      [19,17,16],
      [18,19,16,13],
      [14,18,13],
      [8,14,13,7],
      [2,8,7],
      [9,15,12,6,3],
      [2,0,3,6],
      [8,2,6],
      [14,8,6,12],
      [18,14,12],
      [19,18,12,15],
      [17,19,15],
      [11,17,15,9],
      [5,11,9],
      [1,5,9,3],
      [0,1,3]
    ],
    [
      [0,1],
      [0,2],
      [0,3],
      [0,4],
      [1,3],
      [1,4],
      [1,5],
      [2,6],
      [2,7],
      [2,8],
      [3,6],
      [3,9],
      [4,7],
      [4,10],
      [5,9],
      [5,10],
      [5,11],
      [6,8],
      [6,12],
      [7,8],
      [7,13],
      [8,14],
      [9,11],
      [9,15],
      [10,11],
      [10,16],
      [11,17],
      [12,14],
      [12,15],
      [12,18],
      [13,14],
      [13,16],
      [13,18],
      [14,18],
      [15,17],
      [15,19],
      [16,17],
      [16,19],
      [17,19],
      [18,19]
    ]
  ],
  [
    "square_cupola",
    "Square Cupola",
    "J4",
    "cupolas",
    "Polyhedron Database #48",
    [
      [-0.90920355930, -0.17753303803, -0.37660444522],
      [-0.90920355930, -0.17753303803,  0.37660444522],
      [-0.37660444522,  0.35506607605, -0.37660444522],
      [-0.37660444522,  0.35506607605,  0.37660444522],
      [-0.37660444522, -0.17753303803, -0.90920355930],
      [-0.37660444522, -0.17753303803,  0.90920355930],
      [ 0.37660444522,  0.35506607605, -0.37660444522],
      [ 0.37660444522,  0.35506607605,  0.37660444522],
      [ 0.37660444522, -0.17753303803, -0.90920355930],
      [ 0.37660444522, -0.17753303803,  0.90920355930],
      [ 0.90920355930, -0.17753303803, -0.37660444522],
      [ 0.90920355930, -0.17753303803,  0.37660444522]
    ],
    [
      [1.00000000000, -168.95132206550, 112.12351211134],
      [1.00000000000, -168.95132206551,  67.87648788864],
      [0.64010447170,  136.68614334171, 126.03989343030],
      [0.64010447170,  136.68614334171,  53.96010656970],
      [1.00000000000, -154.76059817930, 155.39552032235],
      [1.00000000000, -154.76059817931,  24.60447967764],
      [0.64010447170,   43.31385665828, 126.03989343029],
      [0.64010447170,   43.31385665828,  53.96010656970],
      [1.00000000000,  -25.23940182068, 155.39552032235],
      [1.00000000000,  -25.23940182066,  24.60447967763],
      [1.00000000000,  -11.04867793448, 112.12351211135],
      [1.00000000000,  -11.04867793448,  67.87648788864]
    ],
    [
      [0,1,5,9,11,10,8,4],
      [6,7,3,2],
      [1,0,2,3],
      [5,1,3],
      [9,5,3,7],
      [11,9,7],
      [10,11,7,6],
      [8,10,6],
      [4,8,6,2],
      [0,4,2]
    ],
    [
      [0,1],
      [0,2],
      [0,4],
      [1,3],
      [1,5],
      [2,3],
      [2,4],
      [2,6],
      [3,5],
      [3,7],
      [4,8],
      [5,9],
      [6,7],
      [6,8],
      [6,10],
      [7,9],
      [7,11],
      [8,10],
      [9,11],
      [10,11]
    ]
  ],
  [
    "square_gyrobicupola",
    "Square Gyrobicupola",
    "J29",
    "cupolas",
    "Polyhedron Database #73",
    [
      [ 0.38268343237,  0.00000000000,  0.92387953251],
      [-0.38268343237, -0.00000000000,  0.92387953251],
      [ 0.92387953251,  0.00000000000,  0.38268343237],
      [ 0.38268343237,  0.54119610015,  0.38268343237],
      [ 0.00000000000, -0.54119610015,  0.54119610015],
      [-0.38268343237,  0.54119610015,  0.38268343237],
      [-0.92387953251, -0.00000000000,  0.38268343237],
      [ 0.54119610015, -0.54119610015, -0.00000000000],
      [ 0.92387953251,  0.00000000000, -0.38268343237],
      [ 0.38268343237,  0.54119610015, -0.38268343237],
      [-0.54119610015, -0.54119610015,  0.00000000000],
      [-0.38268343237,  0.54119610015, -0.38268343237],
      [ 0.00000000000, -0.54119610015, -0.54119610015],
      [-0.92387953251, -0.00000000000, -0.38268343237],
      [ 0.38268343237,  0.00000000000, -0.92387953251],
      [-0.38268343237,  0.00000000000, -0.92387953251]
    ],
    [
      [1.00000000000,    0.00000000000,  22.50000000000],
      [1.00000000000, -179.99999999997,  22.49999999999],
      [1.00000000000,    0.00000000001,  67.50000000000],
      [0.76536686473,   54.73561031725,  60.00000000000],
      [0.76536686473,  -89.99999999998,  45.00000000000],
      [0.76536686473,  125.26438968275,  60.00000000000],
      [1.00000000000, -179.99999999998,  67.49999999999],
      [0.76536686473,  -44.99999999999,  89.99999999999],
      [1.00000000000,    0.00000000001, 112.50000000000],
      [0.76536686473,   54.73561031725, 119.99999999999],
      [0.76536686473, -134.99999999999,  89.99999999999],
      [0.76536686473,  125.26438968275, 119.99999999999],
      [0.76536686473,  -89.99999999999, 135.00000000000],
      [1.00000000000, -179.99999999998, 112.49999999999],
      [1.00000000000,    0.00000000001, 157.50000000000],
      [1.00000000000,  179.99999999999, 157.49999999999]
    ],
    [
      [12,10,4,7],
      [0,2,7,4],
      [1,0,4],
      [6,1,4,10],
      [13,6,10],
      [15,13,10,12],
      [14,15,12],
      [8,14,12,7],
      [2,8,7],
      [11,9,3,5],
      [0,1,5,3],
      [2,0,3],
      [8,2,3,9],
      [14,8,9],
      [15,14,9,11],
      [13,15,11],
      [6,13,11,5],
      [1,6,5]
    ],
    [
      [0,1],
      [0,2],
      [0,3],
      [0,4],
      [1,4],
      [1,5],
      [1,6],
      [2,3],
      [2,7],
      [2,8],
      [3,5],
      [3,9],
      [4,7],
      [4,10],
      [5,6],
      [5,11],
      [6,10],
      [6,13],
      [7,8],
      [7,12],
      [8,9],
      [8,14],
      [9,11],
      [9,14],
      [10,12],
      [10,13],
      [11,13],
      [11,15],
      [12,14],
      [12,15],
      [13,15],
      [14,15]
    ]
  ],
  [
    "square_orthobicupola",
    "square orthobicupola",
    "J28",
    "cupolas",
    "Polyhedron Database #72",
    [
      [ 0.38268343237,  0.00000000000, -0.92387953251],
      [-0.38268343237,  0.00000000000, -0.92387953251],
      [ 0.92387953251, -0.00000000000, -0.38268343237],
      [ 0.38268343237, -0.54119610015, -0.38268343237],
      [ 0.38268343237,  0.54119610015, -0.38268343237],
      [-0.38268343237, -0.54119610015, -0.38268343237],
      [-0.38268343237,  0.54119610015, -0.38268343237],
      [-0.92387953251,  0.00000000000, -0.38268343237],
      [ 0.92387953251,  0.00000000000,  0.38268343237],
      [ 0.38268343237, -0.54119610015,  0.38268343237],
      [ 0.38268343237,  0.54119610015,  0.38268343237],
      [-0.38268343237, -0.54119610015,  0.38268343237],
      [-0.38268343237,  0.54119610015,  0.38268343237],
      [-0.92387953251,  0.00000000000,  0.38268343237],
      [ 0.38268343237,  0.00000000000,  0.92387953251],
      [-0.38268343237,  0.00000000000,  0.92387953251]
    ],
    [
      [1.00000000000,    0.00000000000, 157.49999999999],
      [1.00000000000,  179.99999999999, 157.49999999999],
      [1.00000000000,   -0.00000000001, 112.49999999999],
      [0.76536686473,  -54.73561031725, 119.99999999999],
      [0.76536686473,   54.73561031725, 119.99999999999],
      [0.76536686473, -125.26438968274, 119.99999999999],
      [0.76536686473,  125.26438968274, 119.99999999999],
      [1.00000000000,  179.99999999999, 112.49999999999],
      [1.00000000000,    0.00000000000,  67.50000000000],
      [0.76536686473,  -54.73561031725,  60.00000000000],
      [0.76536686473,   54.73561031725,  60.00000000000],
      [0.76536686473, -125.26438968274,  59.99999999999],
      [0.76536686473,  125.26438968274,  59.99999999999],
      [1.00000000000,  179.99999999998,  67.50000000000],
      [1.00000000000,    0.00000000000,  22.50000000000],
      [1.00000000000,  179.99999999999,  22.50000000000]
    ],
    [
      [11,9,3,5],
      [0,1,5,3],
      [2,0,3],
      [8,2,3,9],
      [14,8,9],
      [15,14,9,11],
      [13,15,11],
      [7,13,11,5],
      [1,7,5],
      [10,12,6,4],
      [1,0,4,6],
      [7,1,6],
      [13,7,6,12],
      [15,13,12],
      [14,15,12,10],
      [8,14,10],
      [2,8,10,4],
      [0,2,4]
    ],
    [
      [0,1],
      [0,2],
      [0,3],
      [0,4],
      [1,5],
      [1,6],
      [1,7],
      [2,3],
      [2,4],
      [2,8],
      [3,5],
      [3,9],
      [4,6],
      [4,10],
      [5,7],
      [5,11],
      [6,7],
      [6,12],
      [7,13],
      [8,9],
      [8,10],
      [8,14],
      [9,11],
      [9,14],
      [10,12],
      [10,14],
      [11,13],
      [11,15],
      [12,13],
      [12,15],
      [13,15],
      [14,15]
    ]
  ],
  [
    "triangular_cupola",
    "Triangular Cupola",
    "J3",
    "cupolas",
    "Polyhedron Database #47",
    [
      [ 0.48245064068, -0.26261286572,  0.83562902180],
      [ 0.96490128135, -0.26261286572,  0.00000000000],
      [ 0.48245064068,  0.52522573144,  0.27854300727],
      [-0.48245064068, -0.26261286572,  0.83562902180],
      [-0.48245064068,  0.52522573144,  0.27854300727],
      [ 0.48245064068, -0.26261286572, -0.83562902180],
      [ 0.00000000000,  0.52522573144, -0.55708601453],
      [-0.96490128135, -0.26261286572, -0.00000000000],
      [-0.48245064068, -0.26261286572, -0.83562902180]
    ],
    [
      [1.00000000000,  -28.56082521782,  33.31860684000],
      [1.00000000000,  -15.22515701068,  89.99999999999],
      [0.76564149349,   47.43070269790,  68.66603725294],
      [1.00000000000, -151.43917478219,  33.31860684000],
      [0.76564149349,  132.56929730209,  68.66603725295],
      [1.00000000000,  -28.56082521781, 146.68139315999],
      [0.76564149349,   89.99999999999, 136.68614334171],
      [1.00000000000, -164.77484298931,  90.00000000000],
      [1.00000000000, -151.43917478217, 146.68139315999]
    ],
    [
      [1,5,8,7,3,0],
      [4,6,2],
      [5,1,2,6],
      [8,5,6],
      [7,8,6,4],
      [3,7,4],
      [0,3,4,2],
      [1,0,2]
    ],
    [
      [0,1],
      [0,2],
      [0,3],
      [1,2],
      [1,5],
      [2,4],
      [2,6],
      [3,4],
      [3,7],
      [4,6],
      [4,7],
      [5,6],
      [5,8],
      [6,8],
      [7,8]
    ]
  ],
  [
    "triangular_gyrobicupola",
    "Triangular Gyrobicupola",
    "Cuboctahedron",
    "cupolas",
    "Exact Mathematics",
    [
      [ 0.00000000000, -0.81649658093, -0.57735026919],
      [-0.50000000000, -0.81649658093,  0.28867513459],
      [-1.00000000000,  0.00000000000, -0.00000000000],
      [-0.50000000000,  0.00000000000, -0.86602540378],
      [ 0.50000000000, -0.81649658093,  0.28867513459],
      [-0.50000000000, -0.00000000000,  0.86602540378],
      [-0.50000000000,  0.81649658093, -0.28867513459],
      [ 0.50000000000,  0.00000000000, -0.86602540378],
      [ 1.00000000000,  0.00000000000, -0.00000000000],
      [ 0.50000000000, -0.00000000000,  0.86602540378],
      [ 0.00000000000,  0.81649658093,  0.57735026919],
      [ 0.50000000000,  0.81649658093, -0.28867513459]
    ],
    [
      [1.00000000000,  -89.99999999999, 125.26438968275],
      [1.00000000000, -121.48215410529,  73.22134511904],
      [1.00000000000,  179.99999999999,  89.99999999999],
      [1.00000000000,  179.99999999998, 149.99999999999],
      [1.00000000000,  -58.51784589470,  73.22134511904],
      [1.00000000000, -179.99999999998,  30.00000000000],
      [1.00000000000,  121.48215410529, 106.77865488095],
      [1.00000000000,    0.00000000001, 149.99999999999],
      [1.00000000000,    0.00000000000,  89.99999999999],
      [1.00000000000,   -0.00000000001,  30.00000000000],
      [1.00000000000,   89.99999999999,  54.73561031724],
      [1.00000000000,   58.51784589470, 106.77865488095]
    ],
    [
      [3,2,1,0],
      [0,4,8,7],
      [1,5,9,4],
      [2,6,10,5],
      [3,7,11,6],
      [8,9,10,11],
      [0,1,4],
      [1,2,5],
      [2,3,6],
      [3,0,7],
      [4,9,8],
      [5,10,9],
      [6,11,10],
      [7,8,11]
    ],
    [
      [0,1],
      [1,2],
      [2,3],
      [3,0],
      [4,0],
      [0,7],
      [7,8],
      [8,4],
      [5,1],
      [1,4],
      [4,9],
      [9,5],
      [6,2],
      [2,5],
      [5,10],
      [10,6],
      [7,3],
      [3,6],
      [6,11],
      [11,7],
      [8,9],
      [9,10],
      [10,11],
      [11,8]
    ]
  ],
  [
    "triangular_orthobicupola",
    "Triangular Orthobicupola",
    "J27",
    "cupolas",
    "Polyhedron Database #71",
    [
      [-0.50000000000, -0.00000000000, -0.86602540378],
      [ 0.50000000000,  0.00000000000, -0.86602540378],
      [ 0.00000000000,  0.81649658093, -0.57735026919],
      [ 0.00000000000, -0.81649658093, -0.57735026919],
      [-1.00000000000, -0.00000000000, -0.00000000000],
      [-0.50000000000,  0.81649658093,  0.28867513459],
      [-0.50000000000, -0.81649658093,  0.28867513459],
      [ 1.00000000000,  0.00000000000,  0.00000000000],
      [ 0.50000000000,  0.81649658093,  0.28867513459],
      [ 0.50000000000, -0.81649658093,  0.28867513459],
      [-0.50000000000,  0.00000000000,  0.86602540378],
      [ 0.50000000000,  0.00000000000,  0.86602540378]
    ],
    [
      [1.00000000000, -179.99999999998, 150.00000000000],
      [1.00000000000,    0.00000000000, 149.99999999998],
      [1.00000000000,   89.99999999999, 125.26438968275],
      [1.00000000000,  -89.99999999999, 125.26438968275],
      [1.00000000000, -179.99999999998,  89.99999999999],
      [1.00000000000,  121.48215410529,  73.22134511904],
      [1.00000000000, -121.48215410529,  73.22134511904],
      [1.00000000000,    0.00000000001,  89.99999999999],
      [1.00000000000,   58.51784589470,  73.22134511903],
      [1.00000000000,  -58.51784589470,  73.22134511903],
      [1.00000000000,  179.99999999999,  30.00000000000],
      [1.00000000000,    0.00000000001,  29.99999999999]
    ],
    [
      [8,5,2],
      [4,0,2,5],
      [10,4,5],
      [11,10,5,8],
      [7,11,8],
      [1,7,8,2],
      [0,1,2],
      [9,3,6],
      [0,4,6,3],
      [1,0,3],
      [7,1,3,9],
      [11,7,9],
      [10,11,9,6],
      [4,10,6]
    ],
    [
      [0,1],
      [0,2],
      [0,3],
      [0,4],
      [1,2],
      [1,3],
      [1,7],
      [2,5],
      [2,8],
      [3,6],
      [3,9],
      [4,5],
      [4,6],
      [4,10],
      [5,8],
      [5,10],
      [6,9],
      [6,10],
      [7,8],
      [7,9],
      [7,11],
      [8,11],
      [9,11],
      [10,11]
    ]
  ]
];

//! @}
//! @}

//----------------------------------------------------------------------------//
// openscad-amu auxiliary scripts
//----------------------------------------------------------------------------//

/*
BEGIN_SCOPE db;
BEGIN_SCOPE autostat;
  BEGIN_OPENSCAD;
    include <math.scad>;
    include <math_utility.scad>;
    include <coordinates.scad>;
    include <table.scad>;
    include <database/polyhedra/cupolas.scad>;

    fs  = "^";

    fad = 1;
    eld = 3;
    ead = 1;

    tc = dtc_polyhedra_cupolas;
    tr = dtr_polyhedra_cupolas;

    ids = table_get_row_ids(tr);

    echo
    (
      str
      (
        "no.", fs, "table id", fs, "other name", fs,
        "vertices", fs, "faces", fs, "edges",

        fs, "face-facets",
        fs, "face-angles",
        fs, "edge-lengths",
        fs, "edge-angles"
      )
    );

    for ( id = ids )
    {
      i = first(find(id, ids, c=1))+1;

      n = table_get(tr, tc, id, "n");
      o = table_get(tr, tc, id, "o");
      g = table_get(tr, tc, id, "g");
      d = table_get(tr, tc, id, "d");

      c = table_get(tr, tc, id, "c");
      s = table_get(tr, tc, id, "s");
      f = table_get(tr, tc, id, "f");
      e = table_get(tr, tc, id, "e");

      fo = is_empty(o) ? "-" : o;

      echo
      (
        str
        (
          i, fs, id, fs, fo, fs,
          len(c), fs, len(f), fs, len(e),

          fs, hist([for (i=f) len(i)], m=9),
          fs, hist
              (
                [
                  for(i=[0 : len(f)-1])
                  let
                  (
                    n1 = cross_vv(c[f[i][1]], c[f[i][2]], c[f[i][0]], c[f[i][0]]),
                    af = [for(v=f[i]) for(j=[0 : len(f)-1]) if( j != i && exists(v, f[j]) ) j]
                  )
                    for(u=unique(af))
                    let
                    (
                      n2 = cross_vv(c[f[u][1]], c[f[u][2]], c[f[u][0]], c[f[u][0]])
                    )
                      dround(angle_vv(n1, n2), d=fad)
                ], m=9
              ),
          fs, hist([for (i=e) dround(distance_pp(c[first(i)], c[second(i)]), d=eld)], m=9),
          fs, hist
              (
                [
                  for (k=[for(j=f) for(i=nssequence(j, n=3, s=1, w=true)) i])
                    dround(angle_vv( c[k[1]], c[k[2]], c[k[0]], c[k[1]] ), d=ead)
                ], m=9
              ),
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
    include <constants.scad>;
    include <table.scad>;
    include <database/polyhedra/cupolas.scad>;

    tc = dtc_polyhedra_cupolas;
    tr = dtr_polyhedra_cupolas;

    id = "default";
    ct = 1/25;

    config = 0;
    rp = config == 0 ? true : false;
    rs = config == 0 ? true : false;
    rc = config == 0 ? true : false;

    pv = table_get(tr, tc, id, "c");
    pf = table_get(tr, tc, id, "f");
    pe = table_get(tr, tc, id, "e");

    if( rp )
    %polyhedron(points=pv, faces=pf);
    else
    polyhedron(points=pv, faces=pf);

    if ( rs )
    color("lightblue")
    for(p=pv)
      translate(p)
        sphere(r=ct*(1+1/2), $fn=25);

    if ( rc )
    for(e=pe)
    {
      p1 = pv[first(e)];
      p2 = pv[second(e)];

      el = norm(p1-p2);
      ax = -acos((p2[2]-p1[2]) / el);
      az = -atan2(p2[0]-p1[0], p2[1]-p1[1]);

      translate((p1+p2) / 2)
      rotate([ax, 0, az])
      cylinder(r=ct, h=el, center=true);
    }
  END_OPENSCAD;

  BEGIN_MFSCRIPT;
    include --path "${INCLUDE_PATH}" {config_base,config_png}.mfs;

    views     name "views" views "diag";
    defines   name "ids" define "id"
              strings
              "
                pentagonal_cupola
                pentagonal_gyrobicupola
                pentagonal_orthobicupola
                square_cupola
                square_gyrobicupola
                square_orthobicupola
                triangular_cupola
                triangular_gyrobicupola
                triangular_orthobicupola
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
