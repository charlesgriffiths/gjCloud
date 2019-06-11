/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


class GJTime
{
static var fetchDir:String = "/time/";


  static public function fetch():GJTransaction
  {
    return new GJTransaction( fetchDir ).addGameID();
  }
}

