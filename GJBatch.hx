/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


class GJBatch
{
static var batchDir:String = "/batch/";


  static public function batch():GJTransaction
  {
    return new GJTransaction( batchDir ).addGameID();
  }


  static public function batchParallel():GJTransaction
  {
    return batch().addArg( "parallel", "true" );
  }


  static public function batchBreakOnError():GJTransaction
  {
    return batch().addArg( "break_on_error", "true" );
  }
}

