import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify/common/helipers/mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/config/assets/app_images.dart';
import 'package:spotify/core/config/assets/app_vector.dart';
import 'package:spotify/core/config/theme/app_colors.dart';
import 'package:spotify/presentation/auth/pages/signin.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';

class SignupSignin extends StatelessWidget {
  bool? flag;
  SignupSignin({super.key,this.flag=false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BasicAppbar(hideBack: flag!,),
          const Align(
            alignment: Alignment.topRight,
            child:
            Image(image: AssetImage(AppVectors.topPattern)
            )
          ),
          const Align(
            alignment: Alignment.bottomRight,
            child:
            Image(image: AssetImage(AppVectors.lowerPattern)
            )
          ),
          const Align(
            alignment: Alignment.bottomLeft,
            child:
            Image(image: AssetImage(AppImages.authbg)
            )
          ),
          Align(
            alignment: Alignment.center,
            child:Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(image: AssetImage(AppVectors.logo)
                  ),
                  const SizedBox(height: 55,),
                  const Text(
                   'Enjoy Listening To Music',
                   style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                   ), 
                  ),
                  const SizedBox(height: 23,),
                  const Text(
                    'Spotify is a proprietary Swedish audio streaming and media services provider ',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      
                      //color: Colors.black87
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30,),
              
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (BuildContext context) =>  SignupPages()
                              )
                           );
                          }, 
                          title: "Register"
                          ),
                      ),
                      const SizedBox(width: 20,),

                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: (){
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (BuildContext context) =>  SigninPages()
                              )
                           );
                          },
                          child:  Text("Sign in",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color:context.isDarkmode ? Colors.white: Color(0xff313131)
                          ),
                          )
                         ),
                      )
                    ],
                  )
                ],
              ),
            )
            
          ),
          
        ],
      ),
    );
  }
}
