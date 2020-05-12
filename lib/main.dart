import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 15.0),
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 50.0,
                child: Icon(Icons.person, color: Colors.black,),
              ),
            ),
            Text(
              'Ronak Jain',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 25.0, fontWeight: FontWeight.w700),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(fontFamily: 'Poppins', fontSize: 18.0),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Divider(
                indent: 25.0,
                endIndent: 25.0,
                thickness: 2.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffF3F5F7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: SvgPicture.asset('assets/icons/facebook.svg'),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Facebook',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffF3F5F7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: SvgPicture.asset('assets/icons/google-plus.svg'),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Google+',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffF3F5F7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: SvgPicture.asset('assets/icons/linkedin.svg'),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'LinkedIn',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffF3F5F7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: SvgPicture.asset('assets/icons/twitter.svg'),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Twitter',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffF3F5F7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: SvgPicture.asset('assets/icons/telegram.svg'),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Telegram',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xffF3F5F7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 25.0,
                      width: 25.0,
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: SvgPicture.asset('assets/icons/spotify.svg'),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                          hintText: 'Spotify',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins'
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

