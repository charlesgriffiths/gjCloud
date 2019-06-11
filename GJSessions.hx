/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


class GJSessions
{
static var openDir:String = "/sessions/open/";
static var pingDir:String = "/sessions/ping/";
static var checkDir:String = "/sessions/check/";
static var closeDir:String = "/sessions/close/";


  static public function open():GJTransaction
  {
    return new GJTransaction( openDir ).addGameID().addUserName().addUserToken();
  }


  static public function ping( ?status:String=null ):GJTransaction
  {
    if (-1 == ["active","idle"].indexOf( status )) status = null;

    return new GJTransaction( pingDir ).addGameID().addUserName().addUserToken().addArg( "status", status );
  }
  

  static public function check():GJTransaction
  {
    return new GJTransaction( checkDir ).addGameID().addUserName().addUserToken();
  }


  static public function close():GJTransaction
  {
    return new GJTransaction( closeDir ).addGameID().addUserName().addUserToken();
  }
}

