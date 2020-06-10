import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:launch_review/launch_review.dart';
import 'package:myportfolio/app_configurations.dart';
import 'package:myportfolio/app_rating.dart';
import 'package:provider/provider.dart';
import 'package:myportfolio/app_theme.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _readOnly;
  AllHandles _allHandles;

  bool openSettings;

  File _image;
  ImageProvider widgetImage;
  final picker = ImagePicker();

  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
      widgetImage = FileImage(_image);
      UserConfig.saveImage(_image);
    });
  }

  void clearImage() async{
    if(widgetImage!=null){
      await widgetImage.evict();
      await UserConfig.deleteImage();
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
    }
  }


  void saveHandles() async{
    UserConfig.saveAllHandles(_allHandles);
    UserConfig.saveName(userNameController.text);
    UserConfig.saveBio(bioController.text);
  }

  void getImageFromPref() async{
    final imageList = await UserConfig.getImage();
    if(imageList != null){
      widgetImage = MemoryImage(imageList);
      setState(() {});
    }
  }

  void showAppRatingPrompt() async{
    if(!AppRating.doNotShowAgain) {
      if(AppRating.launchesLeft <= 0) {
        await Future.delayed(Duration(seconds: 2), () =>
            showDialog(
                barrierDismissible: true,
                useRootNavigator: true,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Do you like the app?'),
                    content: Text(
                        'If you like the app, take a minute to rate app on play store, it will help us to improve and serve you better.'),
                    contentPadding: EdgeInsets.only(
                        left: 24.0, right: 24.0, bottom: 5.0, top: 20.0),
                    actionsPadding: EdgeInsets.symmetric(horizontal: 2.0),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          AppRating.saveRatingInfo(0, true);
                          LaunchReview.launch();
                        },
                        child: Text('Rate'),
                      ),
                      FlatButton(
                        onPressed: () {
                          AppRating.saveRatingInfo(0, true);
                          Navigator.of(context).pop();
                        },
                        child: Text('No Thanks'),
                      ),
                      FlatButton(
                        onPressed: () {
                          AppRating.saveRatingInfo(
                              AppRating.showAgainAfter, false);
                          Navigator.of(context).pop();
                        },
                        child: Text('Maybe Later'),
                      ),
                    ],
                  );
                }
            )
        );
      } else {
        AppRating.saveRatingInfo(AppRating.launchesLeft - 1, AppRating.doNotShowAgain);
      }
    }
  }

  @override
  void initState() {
    _readOnly = true;
    openSettings = false;
    _allHandles = UserConfig.allHandles ?? SocialHandles.getInitialHandles();
    _allHandles.list.sort((a,b) => b.copiedCount.compareTo(a.copiedCount));
    userNameController.text = UserConfig.userName;
    bioController.text = UserConfig.bio;
    getImageFromPref();
    showAppRatingPrompt();
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text('HANDY HANDLES', style: Theme.of(context).textTheme.headline1,),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        bottom: openSettings ? PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,100.0),
          child: Theme(
            data: Theme.of(context),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Color Mode: ',
                                    style: Theme.of(context).textTheme.headline3
                                ),
                                TextSpan(
                                    text: '  Dark',
                                    style: Theme.of(context).textTheme.headline3
                                ),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Switch(
                                      activeColor: Colors.blueAccent,
                                      value: Provider.of<ThemeModeNotifier>(context, listen: false).themeMode == 'dark' ? true : false,
                                      onChanged: (boolVal) {
                                        Provider.of<ThemeModeNotifier>(context, listen: false).setThemeModeData(boolVal ? 'dark' : 'light');
                                        Navigator.of(context).pushReplacementNamed('/homePage');
                                      },
                                    )
                                ),
                                TextSpan(
                                    text: ' Auto',
                                    style: Theme.of(context).textTheme.headline3
                                ),
                                WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Switch(
                                      activeColor: Colors.blueAccent,
                                      value: Provider.of<ThemeModeNotifier>(context, listen: false).autoMode ? true : false,
                                      onChanged: (boolVal) {
                                        Provider.of<ThemeModeNotifier>(context, listen: false).setThemeModeData(boolVal ? 'auto' : 'light');
                                        Navigator.of(context).pushReplacementNamed('/homePage');
                                      },
                                    )
                                ),
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  Wrap(
                    children: [
                      RawMaterialButton(
                        onPressed: () async{
                          await UserConfig.clearAllHandles();
                          await UserConfig.getAllHandles();
                          setState(() {
                            _allHandles = UserConfig.allHandles;
                          });
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomePage()));
                        },
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text('Clear Data', style: Theme.of(context).textTheme.headline3,),
                      ),
                      RawMaterialButton(
                        onPressed: clearImage,
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Text('Remove Picture', style: Theme.of(context).textTheme.headline3,),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ) : null,
        leading: IconButton(
          onPressed: (){
            setState(() {
              openSettings = !openSettings;
            });
          },
          icon: Icon(Icons.settings, color: Theme.of(context).textTheme.headline1.color,),
        ),
        actions: [
          IconButton(
            onPressed: (){
              if(_readOnly == false){
                saveHandles();
              }
              _readOnly = !_readOnly;
              setState((){});
            },
            icon: Icon(_readOnly ? Icons.edit : Icons.save, color: Theme.of(context).textTheme.headline1.color,),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: _readOnly ? null : FloatingActionButton.extended(
        focusElevation: 0.0,
        elevation: 5.0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        icon: Icon(Icons.add, color: Theme.of(context).textTheme.headline1.color,),
        label: Text('Add Handles', style: Theme.of(context).textTheme.headline3,),
        onPressed: (){
          showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isDismissible: true,
              enableDrag: true,
              builder: (context){
                return Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).primaryColorDark,
                            offset: Offset(1.0,1.0),
                            blurRadius: 5.0,
                            spreadRadius: 5.0
                        ),
                      ]
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Click to Add', style: Theme.of(context).textTheme.headline4,),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.2,
                        child: GridView.extent(
                          padding: EdgeInsets.all(8.0),
                          shrinkWrap: false,
                          crossAxisSpacing: 6.0,
                          mainAxisSpacing: 6.0,
                          scrollDirection: Axis.horizontal,
                          primary: true,
                          physics: BouncingScrollPhysics(),
                          semanticChildCount: 5,
                          maxCrossAxisExtent: 100,
                          children: List.generate(31,
                                  (index) => InkWell(
                                    splashColor: Colors.red,
                            child: Container(
                              height: 50.0,
                              width: 50.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Theme.of(context).primaryColorDark,
                                        offset: Offset(1.0,1.0),
                                        blurRadius: 3.0,
                                        spreadRadius: 2.0
                                    ),
                                    BoxShadow(
                                        color: Theme.of(context).primaryColorLight,
                                        offset: Offset(-1.0,-1.0),
                                        blurRadius: 3.0,
                                        spreadRadius: 2.0
                                    ),
                                  ]
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/${SocialHandles.handleNames[index]}.svg',
                                semanticsLabel: SocialHandles.handleNames[index],
                              ),
                            ),
                            onTap: (){
                              _allHandles.list.add(
                                  Handle(
                                    value: '',
                                    iconFileName: SocialHandles.handleNames[index],
                                    handleHintText: SocialHandles.handleNames[index],
                                    copiedCount: -1,
                                    key: UniqueKey().toString()
                                  )
                              );
                              setState(() {

                              });
                            },
                          )),
                        ),
                      ),
                    ],
                  ),
                );
              }
          );
        },
      ),
      bottomNavigationBar: _readOnly ? null : BottomAppBar(
        shape: AutomaticNotchedShape(
            ContinuousRectangleBorder()
        ),
        notchMargin: 4.0,
        elevation: 2.0,
        color: Theme.of(context).bottomAppBarColor,
        child: SizedBox(height: 30.0, width: double.maxFinite,),
      ),
      body: Builder(
        builder: (context){
          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 40.0, top: 8.0),
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).canvasColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).primaryColorDark,
                              offset: Offset(2.0,2.0),
                              blurRadius: 5.0,
                              spreadRadius: 3.0
                          ),
                          BoxShadow(
                              color: Theme.of(context).primaryColorLight,
                              offset: Offset(-2.0,-2.0),
                              blurRadius: 4.0,
                              spreadRadius: 3.0
                          ),
                        ]
                    ),
                    child: GestureDetector(
                      onTap: getImage,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: widgetImage != null ? DecorationImage(
                            image: widgetImage,
                            fit: BoxFit.cover,
                          ) : null,
                        ),
                        child: widgetImage == null ? Icon(Icons.person, color: Theme.of(context).textTheme.headline2.color,) : null,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    String val = userNameController.text;
                    Clipboard.setData(ClipboardData(text: val));
                    if(val != '') {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(
                            shape: StadiumBorder(),
                            content: Text('Copied $val'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color(0xff33383e),
                            behavior: SnackBarBehavior.floating,
                          )
                      );
                    }
                  },
                  child: AbsorbPointer(
                    absorbing: _readOnly,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        enableInteractiveSelection: false,
                        enabled: !_readOnly,
                        readOnly: _readOnly,
                        autofocus: false,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,
                        controller: userNameController,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Your Name',
                            hintStyle: Theme.of(context).textTheme.headline2
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    String val = bioController.text;
                    Clipboard.setData(ClipboardData(text: val));
                    if(val != '') {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(
                            shape: StadiumBorder(),
                            content: Text('Copied $val'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color(0xff33383e),
                            behavior: SnackBarBehavior.floating,
                          )
                      );
                    }
                  },
                  child: AbsorbPointer(
                    absorbing: _readOnly,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        enableInteractiveSelection: false,
                        enabled: !_readOnly,
                        readOnly: _readOnly,
                        autofocus: false,
                        textAlign: TextAlign.center,
                        controller: bioController,
                        style: Theme.of(context).textTheme.headline3,
                        decoration: InputDecoration.collapsed(
                            hintText: 'Biography',
                            hintStyle: Theme.of(context).textTheme.headline3
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Divider(
                    indent: 25.0,
                    endIndent: 20.0,
                    thickness: 1.0,
                    color: Theme.of(context).textTheme.headline2.color.withOpacity(0.5),
                  ),
                ),
                ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: _allHandles.list?.length,
                  itemBuilder: (_,index){
                    return GestureDetector(
                      onTap: (){
                        String val = _allHandles.list[index].value;
                        Clipboard.setData(ClipboardData(text: val));
                        if(val != '') {
                          _allHandles.list[index].copiedCount = (_allHandles.list[index].copiedCount ?? 0) + 1;
                          saveHandles();
                          Scaffold.of(context).showSnackBar(
                              SnackBar(
                                shape: StadiumBorder(),
                                content: Text('Copied $val'),
                                duration: Duration(seconds: 1),
                                backgroundColor: Color(0xff33383e),
                                behavior: SnackBarBehavior.floating,
                              )
                          );
                        }
                      },
                      child: AbsorbPointer(
                        absorbing: _readOnly,
                        child: Dismissible(
                          key: Key(_allHandles.list[index].key),
                          onDismissed: (d){
                            setState(() {
                              _allHandles.list.removeAt(index);
                            });
                          },
                          child: HandleInputField(
                            readOnly: _readOnly,
                            iconFileName: _allHandles.list[index].iconFileName,
                            handleName: _allHandles.list[index].handleHintText,
                            initialValue: _allHandles.list[index].value,
                            onTextChanged: (s){
                              _allHandles.list[index].value = s;
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class HandleInputField extends StatefulWidget {

  bool readOnly;
  String iconFileName;
  String handleName;
  String initialValue;
  Function(String) onTextChanged;

  HandleInputField({this.readOnly, this.iconFileName, this.handleName, this.onTextChanged, this.initialValue});
  @override
  _HandleInputFieldState createState() => _HandleInputFieldState();
}

class _HandleInputFieldState extends State<HandleInputField> {

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    _textEditingController.text = widget.initialValue ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Theme.of(context).buttonColor,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).primaryColorDark,
                  offset: Offset(1.0,1.0),
                  blurRadius: 3.0,
                  spreadRadius: 2.0
              ),
              BoxShadow(
                  color: Theme.of(context).primaryColorLight,
                  offset: Offset(-1.0,-1.0),
                  blurRadius: 2.0,
                  spreadRadius: 2.0
              ),
            ]
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 25.0,
              width: 25.0,
              margin: EdgeInsets.only(right: 10.0, left: 6.0),
              child: SvgPicture.asset('assets/icons/${widget.iconFileName}.svg'),
            ),
            Expanded(
              child: TextField(
                enableInteractiveSelection: false,
                enabled: !widget.readOnly,
                autofocus: false,
                readOnly: widget.readOnly,
                controller: _textEditingController,
                onChanged: (s) => widget.onTextChanged(s),
                style: Theme.of(context).textTheme.headline4,
                decoration: InputDecoration.collapsed(
                  hintText: widget.handleName.toUpperCase(),
                  hintStyle: Theme.of(context).textTheme.headline5.copyWith(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}