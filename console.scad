//! Message logging functions.
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

    \amu_define group_name  (Console)
    \amu_define group_brief (Console message logging.)

  \ingroup \amu_eval(${parent} ${group})
*******************************************************************************/

//----------------------------------------------------------------------------//
// group.
//----------------------------------------------------------------------------//

/***************************************************************************//**
  \defgroup \amu_eval(${group}) Console
  \brief    Console message logging.

  \details

    \b Example

      \dontinclude \amu_scope(index=1).scad
      \skip include
      \until log_error( message );

    \b Result \include \amu_scope(index=1).log
*******************************************************************************/

//----------------------------------------------------------------------------//

//! Format the function call stack as a string.
/***************************************************************************//**
  \param    b <integer> The stack index bottom offset.
            Return function names above this offset.
  \param    t <integer> The stack index top offset.
            Return function names below this offset.

  \returns  <string> A string-formatted colon-separated list of
            functions names for the current function call stack.

  \note     Returns \b undef when \p b is greater than the current number
            of function instances (ie: <tt>b > $parent_modules-1</tt>).
  \note     Returns the string \c "root()" when the function call stack
            is empty (ie: at the root of a script).
*******************************************************************************/
function stack
(
  b = 0,
  t = 0
) = let
  (
    bo = abs(b),
    to = abs(t),
    i = $parent_modules - 1 - bo
  )
  ($parent_modules == undef) ? "root()"
  : (bo > $parent_modules-1) ? undef
  : (i  < to) ? "root()"
  : (i == to) ? str( parent_module( i ), "()" )
  : str( parent_module( i ), "(): ", stack( bo + 1, to ) );

//! Output message to console.
/***************************************************************************//**
  \param    m <string> An output message.
*******************************************************************************/
module log_echo( m )
{
  um = (m==undef) ? "" : m;

  echo ( um );
}

//! Output diagnostic message to console.
/***************************************************************************//**
  \param    t <string> An output message type.
  \param    m <string> An output message.
*******************************************************************************/
module log_type( t, m )
{
  um = (m==undef) ? "" : m;
  mt = (t==undef) ? "NO_TYPE" : t;

  sp = chr( 32 );

  echo ( str("[", sp, mt, sp, "]", sp, um) );
}

//! Output diagnostic message to console.
/***************************************************************************//**
  \param    m <string> An output message.

  \details

    Message is written if and only if \p $log_debug is \p true.
*******************************************************************************/
module log_debug( m )
{
  um = (m==undef) ? "" : m;

  mt = "[ DEBUG ]";
  sp = chr( 32 );
  cs = stack( t = 1 );

  if ( $log_debug == true )
    echo ( str(mt, sp, cs, ";", sp, um) );
}

//! Output information message to console.
/***************************************************************************//**
  \param    m <string> An output message.
*******************************************************************************/
module log_info( m )
{
  um = (m==undef) ? "" : m;

  mt = "[ INFO ]";
  sp = chr( 32 );
  cs = stack( t = 1 );

  echo ( str(mt, sp, cs, ";", sp, um) );
}

//! Output warning message to console.
/***************************************************************************//**
  \param    m <string> An output message.
*******************************************************************************/
module log_warn( m )
{
  um = (m==undef) ? "" : m;

  mt = "[ WARNING ]";
  bc = 35;
  sp = chr( 32 );
  cs = stack( t = 1 );
  hb = chr( [for (i=[0:1:len(um)+len(mt)+4]) bc] );
  ms = str(chr(bc), sp, mt, sp, um, sp, chr(bc));

  echo ();
  echo (cs);
  echo (hb);
  echo (ms);
  echo (hb);
}

//! Output error message to console.
/***************************************************************************//**
  \param    m <string> An output message.

  \details

    Output an error message to the console. Ideally, rendering should halt
    and the script should exit. However, no suitable abort function exists.
    To alert of the critical error, the error message is also rendered
    graphically.
*******************************************************************************/
module log_error( m )
{
  um = (m==undef) ? "" : m;

  mt = "[ ERROR ]";
  bc = 35;
  sp = chr( 32 );
  cs = stack( t = 1 );
  hb = chr( [for (i=[0:1:len(um)+len(mt)+6]) bc] );
  hs = chr( concat([bc, bc],[for (i=[0:1:len(um)+len(mt)+2]) 32],[bc, bc]) );
  ms = str(chr(bc), chr(bc), sp, mt, sp, um, sp, chr(bc), chr(bc));

  echo ();
  echo (cs);
  echo (hb); echo (hb);
  echo (hs);
  echo (ms);
  echo (hs);
  echo (hb); echo (hb);

  color( "red" )
  text( ms );
}

//! @}
//! @}

//----------------------------------------------------------------------------//
// openscad-amu auxiliary scripts
//----------------------------------------------------------------------------//

/*
BEGIN_SCOPE example;
  BEGIN_OPENSCAD;
    include <console.scad>;

    $log_debug = true;
    message = "console log message";

    // general
    log_echo( message );

    // type
    log_type( "MY_TYPE", message );

    // debugging
    log_debug( message );
    log_debug( message, $log_debug = false );

    // information
    log_info( message );

    // warning
    log_warn( message );

    // error
    log_error( message );
  END_OPENSCAD;

  BEGIN_MFSCRIPT;
    include --path "${INCLUDE_PATH}" {config_base,config_csg}.mfs;
    include --path "${INCLUDE_PATH}" script_std.mfs;
  END_MFSCRIPT;
END_SCOPE;
*/

//----------------------------------------------------------------------------//
// end of file
//----------------------------------------------------------------------------//
