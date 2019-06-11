/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


class GJDataStore
{
static var fetchDir:String = "/data-store/";
static var removeDir:String = "/data-store/remove/";
static var setDir:String = "/data-store/set/";
static var updateDir:String = "/data-store/update/";
static var getkeysDir:String = "/data-store/get-keys/";


  static public function fetch( key:String ):GJTransaction
  {
    return new GJTransaction( fetchDir ).addGameID().addArg( "key", key );
  }


  static public function fetchUserData( key:String ):GJTransaction
  {
    return fetch( key ).addUserName().addUserToken();
  }


  static public function remove( key:String ):GJTransaction
  {
    return new GJTransaction( removeDir ).addGameID().addArg( "key", key );
  }


  static public function removeUserData( key:String ):GJTransaction
  {
    return remove( key ).addUserName().addUserToken();
  }


  static public function set( key:String, value:String ):GJTransaction
  {
    return new GJTransaction( setDir ).addGameID().addArg( "key", key ).addArg( "data", value );
  }


  static public function setUserData( key:String, value:String ):GJTransaction
  {
    return set( key, value ).addUserName().addUserToken();
  }


static var operations = [ "add", "subtract", "multiply", "divide", "append", "prepend" ];

  static public function update( key:String, op:String, value:String ):GJTransaction
  {
    if (-1 == operations.indexOf( op )) return set( key, value );

    return new GJTransaction( updateDir ).addGameID().addArg( "key", key ).addArg( "operation", op ).addArg( "value", value );
  }


  static public function updateUserData( key:String, op:String, value:String ):GJTransaction
  {
    return update( key, op, value ).addUserName().addUserToken();
  }


  static public function getKeys( ?pattern:String=null )
  {
    if ("*" == pattern) pattern = null;

    return new GJTransaction( getkeysDir ).addGameID().addArg( "pattern", pattern );
  }


  static public function getUserKeys( ?pattern:String=null )
  {
    return getKeys( pattern ).addUserName().addUserToken();
  }
}

