/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


class GJFriends
{
static var fetchDir:String = "/friends/";


  static public function fetch():GJTransaction
  {
    return new GJTransaction( fetchDir ).addGameID().addUserName().addUserToken();
  }
}

