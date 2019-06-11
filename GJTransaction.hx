/*
 * Copyright (c) 2019 Charles Griffiths
 */

package gjCloud;


import haxe.crypto.Sha1;
import haxe.Json;
import haxe.ds.StringMap;
import js.html.XMLHttpRequest;


class GJTransaction
{
static var gjurl:String = "https://api.gamejolt.com/api/game/v1_2";
public static var appID:String = null;
public static var appPrivateKey:String = null;
public static var userName:String = null;
public static var userAuth:String = null;
public static var userID:String = null;

public var requestSentTime:Float;
public var responseReceivedTime:Float;
public var response:Dynamic;
public var responseStatus:Int;
var fields:StringMap<String>;

var id:String;
var key:String;
var url:String;


  public function new( dir:String )
  {
    requestSentTime = -1;
    responseReceivedTime = -1;
    response = null;
    responseStatus = -1;
    fields = new StringMap();

    setAppId( appID, appPrivateKey );

    url = null==dir?"":dir;
  }


  public function setAppId( id:String, key:String ):GJTransaction
  {
    this.id = id;
    this.key = key;

    return this;
  }


  public function add( batch:GJTransaction ):GJTransaction
  {
    return addArg( "requests[]", StringTools.urlEncode( addSignature( batch.url )));
  }


  public function addGameID():GJTransaction
  {
    return addArg( "game_id", id );
  }


  public function addUserName( ?name:String = null ):GJTransaction
  {
    if (null == name) name = userName;

    return addArg( "username", name );
  }


  public function addUserID( ?id:String = null ):GJTransaction
  {
    if (null == id) id = userID;

    return addArg( "user_id", id );
  }


  public function addUserToken( ?token:String = null ):GJTransaction
  {
    if (null == token) token = userAuth;

    return addArg( "user_token", token );
  }


  public function addTableID( ?id:Int=null ):GJTransaction
  {
    if (null == id) return this;

    return addArg( "table_id", Std.string( id ));
  }


  public function addLimit( limit:Int, def:Int, max:Int ):GJTransaction
  {
    if (null == limit || def == limit) return this;
    if (limit > max) limit = max;

    return addArg( "limit", Std.string( limit ));
  }


  public function addArg( name:String, value:String ):GJTransaction
  {
    url = addStringArg( url, name, value );
    return this;
  }


  public function addArgs( names:Array<String>, values:Array<String> ):GJTransaction
  {
    url = addStringArgs( url, names, values );
    return this;
  }


  public function addSignature( url:String, ?data:String=null ):String
  {
    if (null == data) data = "";

    return addStringArg( url, "signature", Sha1.encode( url + data + key ));
  }


  public static function addStringArg( url:String, name:String, value:String ):String
  {
    if (null == value || "" == value || "null" == value) return url;

    return url + (-1==url.indexOf("?") ? "?" : "&") + name + "=" + value;
  }


  public static function addStringArgs( url:String, names:Array<String>, values:Array<String> ):String
  {
    for (index in 0...names.length)
      url = addStringArg( url, names[index], values[index] );

    return url;
  }


  public function get( ?callbackData:()->Void=null, ?callbackError:()->Void=null ):GJTransaction
  {
    sendGet( addSignature( gjurl+url ), null, callbackData, callbackError );

    return this;
  }


  public function sendGet( url:String, ?headers:StringMap<String>=null, ?callbackData:()->Void=null, ?callbackError:()->Void=null ):Void
  {
    requestSentTime = Date.now().getTime();

  var req = new XMLHttpRequest( "" );

    req.open( "GET", url, true );

    if (null != headers)
      for (key in headers.keys())
        req.setRequestHeader( key, headers.get( key ));

    req.onreadystatechange = function() { onResponse( req, callbackData, callbackError ); }

    req.send();
  }


  public function sendPost( url:String, data:String, ?headers:StringMap<String>=null, callbackData:()->Void, callbackError:()->Void ):Void
  {
    requestSentTime = Date.now().getTime();

  var req = new XMLHttpRequest( "" );

    req.open( "POST", url, true );

    if (null != headers)
      for (key in headers.keys())
        req.setRequestHeader( key, headers.get( key ));

    req.onreadystatechange = function() { onResponse( req, callbackData, callbackError ); }

    req.send( data );    
  }


  function onResponse( request:XMLHttpRequest, callbackData:()->Void, callbackError:()->Void ):Void
  {
    if (4 != request.readyState) return;

    responseReceivedTime = Date.now().getTime();
    response = Json.parse( request.responseText );
    responseStatus = request.status;

    if (200 == request.status && null != callbackData)
      callbackData();

    if (200 != request.status && null != callbackError)
      callbackError();
  }
}

