/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


class GJUsers
{
static var fetchDir:String = "/users/";
static var authDir:String = "/users/auth/";


  static public function fetchByUsername( ?name:String=null ):GJTransaction
  {
    return new GJTransaction( fetchDir ).addGameID().addUserName( name );
  }


  static public function fetchByUserID( ?id:Int=null ):GJTransaction
  {
    return new GJTransaction( fetchDir ).addGameID().addUserID( Std.string( id ));
  }


  static public function fetchByUserIDs( ids:Array<Int> ):GJTransaction
  {
    if (null == ids || 0 == ids.length) return fetchByUserID();

  var idlist = Std.string( ids[0] );

    for (index in 1...ids.length)
      idlist += "," + Std.string( ids[index] );

    return new GJTransaction( fetchDir ).addGameID().addUserID( idlist );
  }


  static public function auth( ?userName:String=null, ?userToken:String=null )
  {
    return new GJTransaction( authDir ).addGameID().addUserName( userName ).addUserToken( userToken );
  }
}

