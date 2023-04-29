import 'package:flutter/material.dart';

import 'constant/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Update extends StatelessWidget {
  String text;
  String button;
  String ADDRESS;
  Update({Key? key,required this.text,required this.button,required this.ADDRESS}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mHeight=MediaQuery.of(context).size.height;
    final mWidth=MediaQuery.of(context).size.width;
    return  WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: grapeColor,
        body: SingleChildScrollView(
          child:
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height:MediaQuery.of(context).size.height*0.84,

                child:     Stack(
                  children:  [Center(
                    child: Text("LOGO",style: TextStyle(color: clc00a618,fontSize: 36,fontWeight: FontWeight.bold),),


              ),

                  ],
                ),
              ),

              Center(
                child: Text(text,  textAlign: TextAlign.center,style: const TextStyle(

                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  color: Colors.white



                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: (){
                    print(ADDRESS.toString()+"VRGBTHYJu");
                    launchURL(ADDRESS);
                  },
                  child: Container(
                    height: 40,
                    width: 150,

                    decoration: BoxDecoration(
                        color:Colors.white,
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,),
                            child: Text(button,style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,


                              color: Colors.black,
                            ),),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.all(15.0),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       const Text("Powered by  ",style: TextStyle(color:Colors.black,fontSize:12),
        //       ),
        //       Image.asset("assets/Logo_theme_letters.png",scale:7),
        //     ],
        //   ),
        // ),


      ),
    );

  }
  void launchURL(String _url) async {
    print(_url+"vjnfjnv");
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
