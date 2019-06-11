/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


class GJTrophies
{
static var fetchDir:String = "/trophies/";
static var addDir:String = "/trophies/add-achieved/";
static var removeDir:String = "/trophies/remove-achieved/";


  static public function fetchAll():GJTransaction
  {
    return new GJTransaction( fetchDir ).addGameID().addUserName().addUserToken();
  }


  static public function fetchAchieved():GJTransaction
  {
    return fetchAll().addArg( "achieved", "true" );
  }


  static public function fetchUnachieved():GJTransaction
  {
    return fetchAll().addArg( "achieved", "false" );
  }


  static public function fetchByID( id:Int ):GJTransaction
  {
    return fetchAll().addArg( "trophy_id", Std.string( id ) );
  }


  static public function fetchByIDs( ids:Array<Int> ):GJTransaction
  {
    if (null == ids || 0 == ids.length) return fetchAll();

  var idlist = Std.string( ids[0] );

    for (index in 1...ids.length)
      idlist += "," + Std.string( ids[index] );
      
    return fetchAll().addArg( "trophy_id", idlist );
  }


  static public function addAchieved( id:Int ):GJTransaction
  {
    return new GJTransaction( addDir ).addGameID().addUserName().addUserToken().addArg( "trophy_id", Std.string( id ) );
  }


  static public function removeAchieved( id:Int ):GJTransaction
  {
    return new GJTransaction( removeDir ).addGameID().addUserName().addUserToken().addArg( "trophy_id", Std.string( id ) );
  }
}

