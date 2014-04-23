<?php

/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//<!--Version 9.6.0.3-->

//SERVER_ERROR

if( get_magic_quotes_gpc() )
{
  $content  = empty($_REQUEST['saveit_c'])?'':stripslashes($_REQUEST['saveit_c']);
  $filename = empty($_REQUEST['saveit_f'])?'download.txt':stripslashes($_REQUEST['saveit_f']);
}
else
{
  $content  = empty($_REQUEST['saveit_c'])?'':$_REQUEST['saveit_c'];
  $filename = empty($_REQUEST['saveit_f'])?'download.txt':$_REQUEST['saveit_f'];
}

header('Content-Type: text/javascript; charset="UTF-8"');
header('Content-Disposition: attachment; filename="'.$filename.'"');
header('Pragma: public');
header('Expires: 0');

print $content;
