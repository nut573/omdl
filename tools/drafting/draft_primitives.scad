//! Drafting base functions and primitives.
/***************************************************************************//**
  \file
  \author Roy Allen Sutton
  \date   2019

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

    \amu_define group_name  (Primitives)
    \amu_define group_brief (Drafting base functions and primitives.)

  \amu_include (include/amu/pgid_path_pstem_g.amu)
*******************************************************************************/

//----------------------------------------------------------------------------//
// group.
//----------------------------------------------------------------------------//

/***************************************************************************//**
  \amu_include (include/amu/group_in_parent_start.amu)
*******************************************************************************/

//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//
// base primitives
//----------------------------------------------------------------------------//

//! .
/***************************************************************************//**
*******************************************************************************/
function draft_sheet_get_window
(
  rx,
  ry,
  ix,
  iy,
  limits = false,
  frame = false
) =
  let
  (
    //
    // get configuration values (scale all lengths)
    //

    // sheet size
    sdx = draft_sheet_get_value(ci="sdx") * draft_scaler,
    sdy = draft_sheet_get_value(ci="sdy") * draft_scaler,

    // sheet layout
    sll = draft_config_get_value(ci="sll"),

    // sheet frame and zone margins
    smx = draft_config_get_value(ci="smx") * draft_scaler,
    smy = draft_config_get_value(ci="smy") * draft_scaler,
    szm = draft_config_get_value(ci="szm") * draft_scaler,

    // reference zone labels
    zox = draft_config_get_value(ci="zox"),
    zoy = draft_config_get_value(ci="zoy"),
    zlx = draft_config_get_value(ci="zlx"),
    zly = draft_config_get_value(ci="zly"),

    // sheet layout dimensions
    ldx = sll ? sdy : sdx,
    ldy = sll ? sdx : sdy,

    // sheet frame dimensions
    fdx = ldx - smx,
    fdy = ldy - smy,

    // working dimensions excluding reference zone
    wdx = fdx - szm * 2,
    wdy = fdy - szm * 2,

    // zone start coordinates
    zxs = is_defined(ix) ?
          let
          ( // reference ordering
            iox = (zox > 0) ? ix : len(zlx)-1-ix
          )
          iox * fdx/len(zlx) -fdx/2
        : is_defined(rx) ?
          let
          ( // assign '-1', outside of frame, if not found
            zxi = defined_or(first(find(rx, zlx)), -1),
            iox = (zox > 0) ? zxi : len(zlx)-1-zxi
          )
          iox * fdx/len(zlx) -fdx/2
        : 0,
    zys = is_defined(iy) ?
          let
          ( // reference ordering
            ioy = (zoy > 0) ? iy : len(zly)-1-iy
          )
          ioy * fdy/len(zly) -fdy/2
        : is_defined(ry) ?
          let
          ( // assign '-1', outside of frame, if not found
            zyi = defined_or(first(find(ry, zly)), -1),
            ioy = (zoy > 0) ? zyi : len(zly)-1-zyi
          )
          ioy * fdy/len(zly) - fdy/2
        : 0,

    // reference window coordinates
    wx  = is_defined(ix) || is_defined(rx) ?
          [zxs, zxs + fdx/len(zlx)]
        : frame ?
          [-fdx/2, fdx/2]
        : [-wdx/2, wdx/2],
    wy  = is_defined(iy) || is_defined(ry) ?
          [zys, zys + fdy/len(zly)]
        : frame ?
          [-fdy/2, fdy/2]
        : [-wdy/2, wdy/2]
  )
    limits ?
    // limits: [[xmin, xmax], [ymin, ymax]
    [wx, wy]
    // window points in cw order from [xmin, ymin]
  : [[wx[0],wy[0]], [wx[0],wy[1]], [wx[1],wy[1]], [wx[1],wy[0]]];

//! .
/***************************************************************************//**
*******************************************************************************/
function draft_sheet_get_zone
(
  rx,
  ry,
  ix,
  iy,
  zp = 0,
  window = false,
  frame = false
) =
  let
  (
    // get reference window xy-limits
    wl  = !is_list(rx) && !is_list(ix) && !is_list(ry) && !is_list(iy) ?
          // no reference lists, just get single zone window
          draft_sheet_get_window( rx=rx, ry=ry, ix=ix, iy=iy, frame=frame, limits=true )
        : let
          (
            // determine x-limits
            wx  = is_list(ix) ?
                  let
                  (
                    w1 = draft_sheet_get_window( ix=first(ix), frame=frame, limits=true ),
                    w2 = draft_sheet_get_window( ix=last(ix),  frame=frame, limits=true )
                  )
                  [min(w1[0][0], w2[0][0]), max(w1[0][1], w2[0][1])]
                : is_list(rx) ?
                  let
                  (
                    w1 = draft_sheet_get_window( rx=first(rx), frame=frame, limits=true ),
                    w2 = draft_sheet_get_window( rx=last(rx),  frame=frame, limits=true )
                  )
                  [min(w1[0][0], w2[0][0]), max(w1[0][1], w2[0][1])]
                : let
                  (
                    w1 = draft_sheet_get_window( rx=rx, ix=ix, frame=frame, limits=true )
                  )
                  w1[0],

            // determine y-limits
            wy  = is_list(iy) ?
                  let
                  (
                    w1 = draft_sheet_get_window( iy=first(iy), frame=frame, limits=true ),
                    w2 = draft_sheet_get_window( iy=last(iy),  frame=frame, limits=true )
                  )
                  [min(w1[1][0], w2[1][0]), max(w1[1][1], w2[1][1])]
                : is_list(ry) ?
                  let
                  (
                    w1 = draft_sheet_get_window( ry=first(ry), frame=frame, limits=true ),
                    w2 = draft_sheet_get_window( ry=last(ry),  frame=frame, limits=true )
                  )
                  [min(w1[1][0], w2[1][0]), max(w1[1][1], w2[1][1])]
                : let
                  (
                    w1 = draft_sheet_get_window( ry=ry, iy=iy, frame=frame, limits=true )
                  )
                  w1[1]
          )
          // xy-limits
          [wx, wy]
  )
    window ?
    // window points in cw order from [xmin, ymin]
    [
      [wl[0][0], wl[1][0]],
      [wl[0][0], wl[1][1]],
      [wl[0][1], wl[1][1]],
      [wl[0][1], wl[1][0]]
    ]
  : let
    (
      // linearly scale window by px, py
      // [-1]=left/bottom, [0]=center/middle, [+1]=right/top]
      px = edefined_or(zp, 0, zp),
      py = edefined_or(zp, 1, px),

      cx = ( px * (wl[0][1]-wl[0][0]) + (wl[0][0]+wl[0][1]) )/2,
      cy = ( py * (wl[1][1]-wl[1][0]) + (wl[1][0]+wl[1][1]) )/2
    )
    // point
    [cx, cy];

//! .
/***************************************************************************//**
*******************************************************************************/
function draft_table_get_point
(
  ix,   // verticle line index
  iy,   // horizontal line index
  map,
  fmap
) =
  let
  (
    // get table format
    cmh = map_get_firstof2_or(map, fmap, "cmh", length(1/4,"in")) * draft_scaler,
    cmv = map_get_firstof2_or(map, fmap, "cmv", length(1/4,"in")) * draft_scaler,

    coh = map_get_firstof2_or(map, fmap, "coh", +1),
    cov = map_get_firstof2_or(map, fmap, "cov", -1),

    // get table data
    title = map_get_value(map, "title"),
    heads = map_get_value(map, "heads"),
    cols  = map_get_value(map, "cols"),
    rows  = map_get_value(map, "rows"),

    // vertical line index
    xu  = (ix <= 0) ? 0                     // left
        : sum([for( i=[1:ix] ) cols[i-1]]), // sum column units widths

    yt  = edefined_or(title, 1, 0),         // title: '0' unit default height
    yh  = edefined_or(heads, 1, 0),         // heads: '0' unit default height

    // horizontal line index
    yu  = (iy <= 0) ? 0                     // top
        : (iy == 1) ? yt                    // title
        : (iy == 2) ? sum( [yt, yh] )       // title + heads
        : sum
          (
            [
              yt, yh,                       // rows: '1' unit default height
              for( i=[3:iy] ) edefined_or(rows[i-3], 1, 1)
            ]
          )
  )
  [xu*cmh*coh, yu*cmv*cov];                 // units * unit-size * order

//! .
/***************************************************************************//**
*******************************************************************************/
function draft_table_get_cell
(
  ix,
  iy,
  zp = 0,
  limits = false,
  window = false,
  map,
  fmap
) =
  let
  (
    // get table data
    cols = map_get_value(map, "cols"),
    rows = map_get_value(map, "rows"),

    // vertical lines
    lv  = (iy <= 0) ?       [0, len(cols)]      // title cell
        : is_defined(ix) ?  [ix, ix+1]          // heading or row
        :                   [0, len(cols)],     // table width

    // horizontal lines
    lh  = is_defined(iy) ?  [iy, iy+1]          // any row
        :                   [0, len(rows)+2],   // table height

    // get cell window xy-limits [min, max]
    wl =
    [
      [ for( i=[0, 1] ) draft_table_get_point( ix=lv[i], map=map, fmap=fmap )[0] ],
      [ for( i=[0, 1] ) draft_table_get_point( iy=lh[i], map=map, fmap=fmap )[1] ]
    ]
  )
    limits ?
    // limits: [[xmin, xmax], [ymin, ymax]
    wl
  : window ?
    // window points in cw order from [xmin, ymin]
    [
      [wl[0][0], wl[1][0]],
      [wl[0][0], wl[1][1]],
      [wl[0][1], wl[1][1]],
      [wl[0][1], wl[1][0]]
    ]
  : let
    (
      // linearly scale window by px, py
      // [-1]=left/bottom, [0]=center/middle, [+1]=right/top]
      px = edefined_or(zp, 0, zp),
      py = edefined_or(zp, 1, px),

      cx = ( px * (wl[0][1]-wl[0][0]) + (wl[0][0]+wl[0][1]) )/2,
      cy = ( py * (wl[1][1]-wl[1][0]) + (wl[1][0]+wl[1][1]) )/2
    )
    // point
    [cx, cy];

//! .
/***************************************************************************//**
*******************************************************************************/
module draft_table_text
(
  ix,
  iy,
  text,
  size,
  dfmt,
  map,
  fmap
)
{ // element-wise default assignment
  function erdefined_or (v, r, d) = [for (i = r) defined_or( v[i], d[i] )];

  /*
   handled-input-cases          tv(text)      sf(text)
   (1)   "t1"                   ["t1"]        [ "t1" ]
   (2) [ "t1" ]                 ["t1"]        [ "t1" ]
   (3) [ "t1", "t2" ]           ["t1", "t2"]  [ ["t1", "t2"] ]
   (4) [ ["t1", "t2"] ]         ["t1", "t2"]  [ ["t1", "t2"] ]
   (5) [ ["t1", "t2"], [0,0] ]  ["t1", "t2"]  [ ["t1", "t2"], [0,0] ]
   (6) [ "t1", [0,0] ]          ["t1"]        [ "t1", [0,0] ]
  */

  sf = is_string(text)   ? [text]       // (1)
     : all_strings(text) ? [text]       // (2), (3)
     : text;                            // (4), (5), (6)

  tv = is_string(text)   ? [text]       // (1)
     : all_strings(text) ? text         // (2), (3)
     : is_list(text[0])  ? text[0]      // (4), (5)
     : [text[0]];                       // (6)

  // assign defaults where needed
  df = erdefined_or( sf, [0:11], dfmt );

  for ( l=[0:len(tv)-1] )
  translate
  (
    // zone coordinates
    draft_table_get_cell( ix=ix, iy=iy, zp=df[1], map=map, fmap=fmap )
    // configured offset
    + [ df[2][0], df[2][1] ] * size * df[5]
    // multi-line offset
    + df[3] * size * df[5] * l
  )
  rotate( df[4] )
  text
  (
         text=tv[l],
         size=df[5]*size,
       halign=df[6][0],
       valign=df[6][1],
         font=df[7],
      spacing=df[8],
    direction=df[9],
     language=df[10],
       script=df[11]
  );
}

//! .
/***************************************************************************//**
*******************************************************************************/
function draft_ztable_get_point
(
  ix,   // verticle line index
  iy,   // horizontal line index
  map
) =
  let
  (
    // get table configuration
    cmh    = map_get_value(map, "cmh") * draft_scaler,
    cmv    = map_get_value(map, "cmv") * draft_scaler,

    coh    = map_get_value(map, "coh"),
    cov    = map_get_value(map, "cov"),

    vlines = map_get_value(map, "vlines"),
    hlines = map_get_value(map, "hlines"),

    x = sum([for( i=[0:ix] ) vlines[i][0]]) * cmh * coh,
    y = sum([for( i=[0:iy] ) hlines[i][0]]) * cmv * cov
  )
  [x, y];

//! .
/***************************************************************************//**
*******************************************************************************/
function draft_ztable_get_zone
(
  i,
  zp = 0,
  limits = false,
  window = false,
  map
) =
  let
  (
    // get table configuration
    zones  = map_get_value(map, "zones"),

    zx  = is_defined(i) ?
          zones[i][0]
          // [min vline, max vline]
        : [0, len(map_get_value(map, "vlines"))-1],
    zy  = is_defined(i) ?
          zones[i][1]
          // [min hline, max hline]
        : [0, len(map_get_value(map, "hlines"))-1],

    // get zone window xy-limits [min, max]
    wl =
    [
      [ for( i=[1, 0] ) draft_ztable_get_point( ix=zx[i], map=map )[0] ],
      [ for( i=[0, 1] ) draft_ztable_get_point( iy=zy[i], map=map )[1] ]
    ]
  )
    limits ?
    // limits: [[xmin, xmax], [ymin, ymax]
    wl
  : window ?
    // window points in cw order from [xmin, ymin]
    [
      [wl[0][0], wl[1][0]],
      [wl[0][0], wl[1][1]],
      [wl[0][1], wl[1][1]],
      [wl[0][1], wl[1][0]]
    ]
  : let
    (
      // linearly scale window by px, py
      // [-1]=left/bottom, [0]=center/middle, [+1]=right/top]
      px = edefined_or(zp, 0, zp),
      py = edefined_or(zp, 1, px),

      cx = ( px * (wl[0][1]-wl[0][0]) + (wl[0][0]+wl[0][1]) )/2,
      cy = ( py * (wl[1][1]-wl[1][0]) + (wl[1][0]+wl[1][1]) )/2
    )
    // point
    [cx, cy];

//! .
/***************************************************************************//**
*******************************************************************************/
module draft_ztable_text
(
  i,
  text,
  size,
  fmt,
  dfmt,
  map
)
{ // element-wise default assignment
  function erdefined_or (v, r, d) = [for (i = r) defined_or( v[i], d[i] )];

  // multi- or single-line
  tv = is_list(text) ? text : [text];

  // assign defaults where needed
  df = erdefined_or( fmt, [0:11], dfmt );

  for ( l=[0:len(tv)-1] )
  translate
  (
    // zone coordinates
    draft_ztable_get_zone( i=i, zp=df[1], map=map )
    // configured offset
    + [ df[2][0], df[2][1] ] * size * df[5]
    // multi-line offset
    + df[3] * size * df[5] * l
  )
  rotate( df[4] )
  text
  (
         text=tv[l],
         size=df[5]*size,
       halign=df[6][0],
       valign=df[6][1],
         font=df[7],
      spacing=df[8],
    direction=df[9],
     language=df[10],
       script=df[11]
  );
}

//! .
/***************************************************************************//**
*******************************************************************************/
function draft_layers_any_active
(
  layers = draft_get_default("layers-default")
) = exists( is_list(layers) ? layers : [layers], draft_layers_show, true );

//! .
/***************************************************************************//**
*******************************************************************************/
module draft_make_3d_if_configured
(
)
{
  if ( draft_make_3d )
    linear_extrude
    (
      height=draft_get_default("make-3d-height") * draft_scaler, center=true
    )
    children();
  else
    children();
}

//----------------------------------------------------------------------------//
// basic shapes
//----------------------------------------------------------------------------//

//! .
/***************************************************************************//**
*******************************************************************************/
module draft_line_pp
(
  i,
  t,
  w = 1
)
{
  $fn = $draft_line_fn;
  p = draft_get_default("line-width-min") * w * draft_scaler;

  // hulled end-circles
  hull() { translate(i) circle(d=p); translate(t) circle(d=p); }

  // rectangle line with rounded ends
  // align_ll(r=[i, t], rp=2, l=y_axis3d_ul)
  // square([p, distance_pp(i, t)], center=true);
  // translate(i) circle(d=p); translate(t) circle(d=p);
}

//! .
/***************************************************************************//**
*******************************************************************************/
module draft_arrow
(
  l,
  w = 1,
  s = 0
)
{
  s1 = edefined_or(s, 0, s);                  // arrow selection

  if ( s1 )
  {
    s2  = edefined_or(s, 1, 0);               // fill [0:1, t:f]
    s3  = edefined_or(s, 2, 0);               // sections [0:all,1:left,2:right]

    s4  = edefined_or(s, 3, 1);               // length multiplier
    s5  = edefined_or(s, 4, 1);               // angle multiplier


    al  = draft_get_default("arrow-line-length-min")
            * s4 * draft_scaler;              // length

    ca  = draft_get_default("arrow-angle-min")
            * s5;                             // cut angle

    alx = angle_ll(x_axis2d_uv, l, true);     // line angle
    aa1 = alx+180-ca;                         // angle a1
    aa2 = alx-180+ca;                         // angle a2

    pah = line_tp(l);                         // head point

    ls1 = line2d_new(m=al, a=aa1, p1=pah);    // side line1
    ls2 = line2d_new(m=al, a=aa2, p1=pah);    // side line2

    ps1 = line_tp(ls1);                       // line1 end point
    ps2 = line_tp(ls2);                       // line2 end point

    ptm = (ps1 + ps2)/2;                      // tail mid point
    pam = (ptm + pah)/2;                      // middle point

    // update fn for arrow construction
    $draft_line_fn = $draft_arrow_fn;

    if ( s1 == 1 )
    { // closed 3-point
      hull_if( !s2 )
      {
        draft_line_pp(pah, ptm, w=w);
        if (bitwise_is_equal(s3, 0, 0))
          { draft_line_pp(ls1[0], ls1[1], w=w); draft_line_pp(ps1, ptm, w=w); }
        if (bitwise_is_equal(s3, 1, 0))
        { draft_line_pp(ls2[0], ls2[1], w=w); draft_line_pp(ps2, ptm, w=w); }
      }
    }
    else if ( s1 == 2 )
    { // closed 4-point
      hull_if( !s2 )
      {
        draft_line_pp(pah, pam, w=w);
        if (bitwise_is_equal(s3, 0, 0))
          { draft_line_pp(ls1[0], ls1[1], w=w); draft_line_pp(ps1, pam, w=w); }
      }
      hull_if( !s2 )
      {
        draft_line_pp(pah, pam, w=w);
        if (bitwise_is_equal(s3, 1, 0))
        { draft_line_pp(ls2[0], ls2[1], w=w); draft_line_pp(ps2, pam, w=w); }
      }
    }
    else if ( s1 == 3 )
    { // open 3-point
      if (bitwise_is_equal(s3, 0, 0))
        draft_line_pp(ls1[0], ls1[1], w=w);
      if (bitwise_is_equal(s3, 1, 0))
        draft_line_pp(ls2[0], ls2[1], w=w);
    }
    else if ( s1 == 4 )
    { // slash / cross
      if (bitwise_is_equal(s3+1, 0, 1))
      {
        xl1 = line2d_new(m=+al/3*2, a=alx+180-ca*2, p1=pah);
        xl2 = line2d_new(m=-al/3*2, a=alx+180-ca*2, p1=pah);

        draft_line_pp(xl1[0], xl1[1], w=w);
        draft_line_pp(xl2[0], xl2[1], w=w);
      }
      if (bitwise_is_equal(s3+1, 1, 1))
      {
        xl1 = line2d_new(m=+al/3*2, a=alx-180+ca*2, p1=pah);
        xl2 = line2d_new(m=-al/3*2, a=alx-180+ca*2, p1=pah);

        draft_line_pp(xl1[0], xl1[1], w=w);
        draft_line_pp(xl2[0], xl2[1], w=w);
      }
    }
    else if ( s1 == 5 )
    { // circle
      hull_if( !s2 )
      for ( ls = nssequence( polygon2d_arc_p( r=al/3, c=pah ), 2, 1 ) )
        draft_line_pp(ls[0], ls[1], w=w);
    }
  }
}

//! .
/***************************************************************************//**
*******************************************************************************/
module draft_line
(
  l,
  w = 1,
  s = 1,
  a1 = 0,
  a2 = 0
)
{
  s1 = edefined_or(s, 0, s);                  // line selection

  if ( !all_equal([s1, a1, a2], 0) )
  {
    lsm = draft_get_default("line-segment-min") * draft_scaler;

    i  = line_ip(l);
    t  = line_tp(l);

    if ( s1 == 1 )
    { // solid line
      draft_line_pp(i, t, w);
    }
    else if ( s1 == 2 )
    { // single pattern centered
      s2 = edefined_or(s, 1, 1)*lsm;          // length multiplier
      s3 = edefined_or(s, 2, 2);              // stride

      for ( ls = nssequence( polygon2d_line_p(l=l, ft=s2), 2, s3 ) )
        draft_line_pp(ls[0], ls[1], w);
    }
    else if ( s1 == 3 )
    { // dual overlapped patterns
      s2 = edefined_or(s, 1, 1)*lsm;          // length multiplier 1
      s3 = edefined_or(s, 2, 2);              // stride 1
      s4 = edefined_or(s, 3, 2)*lsm;          // length multiplier 2
      s5 = edefined_or(s, 4, 3);              // stride 2

      for ( ls = nssequence( polygon2d_line_p(l=l, fs=s2), 2, s3 ) )
        draft_line_pp(ls[0], ls[1], w);

      for ( ls = nssequence( polygon2d_line_p(l=l, fs=s4), 2, s5 ) )
        draft_line_pp(ls[0], ls[1], w);
    }
    else if ( s1 == 4 )
    { // at both ends and 'n' centered
      s2 = edefined_or(s, 1, 1);              // number 'n'
      s3 = edefined_or(s, 2, 1)*lsm;          // centered-length multiplier
      s4 = edefined_or(s, 3, 1)*lsm;          // end-length multiplier

      // at both ends
      el1 = line2d_new(s4, p1=i, v=[i, t]);
      el2 = line2d_new(s4, p1=t, v=[t, i]);

      draft_line_pp(el1[0], el1[1], w);
      draft_line_pp(el2[0], el2[1], w);

      // 'n' centered
      if (s2 > 0)
      {
        mp = polygon2d_line_p(l=l, fn=s2+1);
        for (j = [1:len(mp)-2])
        {
          cl1 = line2d_new(s3/2, p1=mp[j], v=[t, i]);
          cl2 = line2d_new(s3/2, p1=mp[j], v=[i, t]);

          draft_line_pp(cl1[1], cl2[1], w);
        }
      }
    }
    else if ( s1 == 5 )
    { // line break(s)
      s2 = edefined_or(s, 1, 1);              // number of breaks
      s3 = edefined_or(s, 2, 2)*lsm;          // length multiplier
      s4 = edefined_or(s, 3, 2)*lsm;          // width multiplier
      s5 = edefined_or(s, 4, 67.5);           // angle*

      // *s5=90 invokes bug: https://github.com/CGAL/cgal/issues/2631

      la = angle_ll(x_axis2d_uv, l);
      bp = polygon2d_line_p(l=l, fn=1+max(1,s2));

      xp =
      [
        for (i = [1:len(bp)-2])
        let
        (
          mp = bp[i],                         // mid, cross, & line points
          xp = polygon2d_regular_p(n=2, r=s4, o=la+s5, c=mp),
          lp = polygon2d_regular_p(n=2, r=s3, o=la, c=mp)
        )
        [ lp[1], xp[0], xp[1], lp[0] ]
      ];

      for ( ls = nssequence(concat([i],smerge(xp),[t]), 2, 1 ) )
        draft_line_pp(ls[0], ls[1], w);
    }

    // arrows
    draft_arrow(l=[t, i], w=w, s=a1);
    draft_arrow(l=[i, t], w=w, s=a2);
  }
}

//! .
/***************************************************************************//**
*******************************************************************************/
module draft_arc
(
  r,
  c  = origin2d,
  v1 = x_axis2d_uv,
  v2 = x_axis2d_uv,
  fn,
  cw = true,

  w  = 1,
  s  = 1,
  a1 = 0,
  a2 = 0
)
{
  s1 = edefined_or(s, 0, s);                  // line selection

  if ( !all_equal([s1, a1, a2], 0) )
  {
    pp = polygon2d_arc_p( r=r, c=c, v1=v1, v2=v2, fn=fn, cw=cw );

    if ( s1 == 1 )
    { // solid line
      for ( ls = nssequence( pp, 2, 1 ) )
        draft_line_pp(ls[0], ls[1], w);
    }
    else if ( s1 == 2 )
    { // single pattern centered
      s2 = edefined_or(s, 1, 2);              // point stride

      for ( ls = nssequence( pp, 2, s2 ) )
        draft_line_pp(ls[0], ls[1], w);
    }

    // arrows
    draft_arrow(l=reverse(nfirst(pp, 2)), w=w, s=a1);
    draft_arrow(l=nlast(pp, 2), w=w, s=a2);
  }
}

//! .
/***************************************************************************//**
*******************************************************************************/
module draft_rectangle
(
  d,
  c = origin2d,
  w = 1,
  s = 1
)
{
  dx = edefined_or(d, 0, d);
  dy = edefined_or(d, 1, dx);

  mx = dx/2;
  my = dy/2;

  pl =
  [
    [-mx, -my] + c,
    [-mx,  my] + c,
    [ mx,  my] + c,
    [ mx, -my] + c
  ];

  // draft each edge
  for ( cp = nssequence(pl, n=2, s=1, w=true) )
    draft_line(l=[cp[0], cp[1]], w=w, s=s);
}

//! .
/***************************************************************************//**
  \param    c <coords-2d> A list of 2d coordinate points.

  \param    p <integer-list-list> A list of paths that enclose the
            shape where each face is a list of coordinate indexes.
  \param    e <integer-list-2-list> A list of edges where each edge is
            a list of two coordinate indexes.
  \param    i <index> An index sequence [specification].

  \details

  \note     Parameter \p p is optional. When it is not given, the
            listed order of the coordinates \p c establishes the
            polygon path.
  \note     When \p e is not specified, it is computed from \p p using
            polytope_faces2edges().

  [specification]: \ref dt_index
*******************************************************************************/
module draft_polygon
(
  c,
  p,
  e,
  i = true,
  w = 1,
  s = 1
)
{
  $fn = $draft_line_fn;

  el  = is_defined(e) ? e           // use supplied edge list 'e'
      : polytope_faces2edges        // construct from paths
        (
            is_defined(p) ? p       // use supplied path list 'p'
          : [consts(len(c))]        // connect all points in order supplied
        );

  // draft each selected edge
  for (i = get_index(el, i))        // allow edge selection index
    draft_line(l=[c[first(el[i])], c[second(el[i])]], w=w, s=s);
}

//! @}
//! @}

//----------------------------------------------------------------------------//
// end of file
//----------------------------------------------------------------------------//
