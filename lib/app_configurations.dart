import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigurations{

  static SharedPreferences prefs;

  static get getSharedPrefInstance async{
    prefs = await SharedPreferences.getInstance();
  }
}

class UserConfig{

  static AllHandles allHandles;
  static String userName;
  static String bio;

  static saveName(String name){
    userName = name;
    AppConfigurations.prefs.setString('userName', name);
  }

  static getName(){
    var val = AppConfigurations.prefs.getString('userName') ?? false;
    if(val == false){
      userName = "";
    } else {
      userName = val;
    }
  }

  static saveBio(String name){
    bio = name;
    AppConfigurations.prefs.setString('bio', name);
  }

  static getBio(){
    var val = AppConfigurations.prefs.getString('bio') ?? false;
    if(val == false){
      bio = "";
    } else {
      bio = val;
    }
  }

  static saveAllHandles(AllHandles allHandles){
    AppConfigurations.prefs.setString('allHandles', jsonEncode(allHandles));
  }

  static getAllHandles(){
    var val = AppConfigurations.prefs.getString('allHandles') ?? false;
    if(val == false){
      allHandles = AllHandles(
          list: SocialHandles.getInitialHandles(),
      );
    } else {
      allHandles = AllHandles.fromJson(jsonDecode(val));
    }
  }

  static clearAllHandles() async{
    AppConfigurations.prefs.clear();
  }

  static saveImage(_image) async{
    Uint8List image = await _image.readAsBytes();
    String base64Image = Base64Encoder().convert(image);
    AppConfigurations.prefs.setString('userPicture', base64Image);
  }

  static deleteImage() async{
    AppConfigurations.prefs.remove('userPicture');
  }

  static Future<Uint8List> getImage() async{
    final base64Image = AppConfigurations.prefs.getString('userPicture');
    if (base64Image != null) return Base64Decoder().convert(base64Image);
    return null;
  }
}

class Handle {
  String value;
  String iconFileName;
  String handleHintText;
  int copiedCount;
  String key;

  Handle({
    this.value,
    this.iconFileName,
    this.handleHintText,
    this.copiedCount,
    this.key
  });

  factory Handle.fromJson(Map<String, dynamic> json) => Handle(
    value: json["value"],
    iconFileName: json["iconFileName"],
    handleHintText: json["handleHintText"],
    copiedCount: json["copiedCount"],
    key: json["key"]
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "iconFileName": iconFileName,
    "handleHintText": handleHintText,
    "copiedCount": copiedCount,
    "key": key
  };
}

class AllHandles {
  List<Handle> list;

  AllHandles({
    this.list,
  });

  factory AllHandles.fromJson(Map<String, dynamic> json) => AllHandles(
    list: List<Handle>.from(json["list"].map((x) => Handle.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class SocialHandles{

  static List<String> handleNames = [
    "handle",
    "badoo",
    "swarm",
    "viber",
    "dropbox",
    "foursquare",
    "behance",
    "deviantart",
    "tumblr",
    "vimeo",
    "snapchat",
    "yelp",
    "skype",
    "dribbble",
    "twitter",
    "myspace",
    "line",
    "instagram",
    "quora",
    "whatsapp",
    "spotify",
    "google-plus",
    "flickr",
    "path",
    "pinterest",
    "youtube",
    "facebook",
    "vine",
    "linkedin",
    "telegram",
    "soundcloud",
  ];

  static List<Handle> getInitialHandles(){
    return [
      Handle(
          copiedCount: -1,
          iconFileName: 'youtube',
          handleHintText: 'YOUTUBE',
          value: '',
          key: UniqueKey().toString()
      ),
      Handle(
          copiedCount: -1,
          iconFileName: 'facebook',
          handleHintText: 'FACEBOOK',
          value: '',
          key: UniqueKey().toString()
      ),
      Handle(
          copiedCount: -1,
          iconFileName: 'pinterest',
          handleHintText: 'PINTEREST',
          value: '',
          key: UniqueKey().toString()
      ),
      Handle(
          copiedCount: -1,
          iconFileName: 'snapchat',
          handleHintText: 'SNAPCHAT',
          value: '',
          key: UniqueKey().toString()
      ),
      Handle(
          copiedCount: -1,
          iconFileName: 'twitter',
          handleHintText: 'TWITTER',
          value: '',
          key: UniqueKey().toString()
      ),
    ];
  }
}