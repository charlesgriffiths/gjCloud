/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


class GJScores
{
static var fetchDir:String = "/scores/";
static var tablesDir:String = "/scores/tables/";
static var addDir:String = "/scores/add/";
static var getrankDir:String = "/scores/get-rank/";


  static public function fetch( ?tableID:Int=null, ?limit:Int=null, ?betterThan:Int=null, ?worseThan:Int=null ):GJTransaction
  {
    return new GJTransaction( fetchDir ).addGameID().addUserName().addUserToken()
      .addTableID( tableID ).addLimit( limit, 10, 100 )
      .addArg( "better_than", Std.string( betterThan )).addArg( "worse_than", Std.string( worseThan ));
  }


  static public function tables():GJTransaction
  {
    return new GJTransaction( tablesDir ).addGameID();
  }


  static public function add( score:Int, scoreString:String, ?tableID:Int=null, ?extra:String=null ):GJTransaction
  {
    return new GJTransaction( addDir ).addGameID().addUserName().addUserToken()
      .addArg( "sort", Std.string( score )).addArg( "score", scoreString ).addTableID( tableID ).addArg( "extra_data", extra );
  }


  static public function getRank( score:Int, ?tableID:Int=null ):GJTransaction
  {
    return new GJTransaction( getrankDir ).addGameID()
      .addArg( "sort", Std.string( score )).addTableID( tableID );
  }
}

