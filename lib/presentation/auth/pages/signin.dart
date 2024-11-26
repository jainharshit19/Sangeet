import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/config/assets/app_vector.dart';
import 'package:spotify/data/models/signin_user_req.dart';
import 'package:spotify/domain/usecases/signin_usecase.dart';
import 'package:spotify/presentation/auth/pages/signup.dart';
import 'package:spotify/service_locator.dart';

import '../../home/home.dart';

class SigninPages extends StatelessWidget {
  SigninPages({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signupText(context),
      appBar: BasicAppbar(
        title: 
        Image(
          image: AssetImage(
            AppVectors.logo,
            ),
            height:140,width: 140,),
      ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
        horizontal: 50,
        vertical: 50,
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 50,),
            _emailField(context),
            const SizedBox(height: 20,),
            _passwordField(context),
            const SizedBox(height: 40,),
            BasicAppButton(
              onPressed: () async{
                var result = await s1<SigninUsecase> ().call(
                    params: SignINUserReq(
                      
                      email: _email.text.toString(),
                      password: _password.text.toString()
                    )
                  );
                  result.fold(
                    (l){
                      var snackbar = SnackBar(content:  Text(l));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar); 
                    }, 
                    (r){
                      Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder:(BuildContext context) => const HomePage()  ), 
                        (route) => false
                      );
                    }
                  );
              }, 
              title: 'Sign In' )
          ],
        ),
      ),
    );
  }
  Widget _registerText() {
    return const Text(
      "Sign IN",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 27,
       
      ),
      textAlign: TextAlign.center,
      );
  }

  

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
       hintText: 'Enter Email or Username' 
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme
      ),
    );
  }
  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: const InputDecoration(
       hintText: 'Password' 
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme
      ),
    );
  }
  Widget _signupText (BuildContext context){
   return  Padding(
     padding: EdgeInsets.symmetric(
      vertical: 30,
     ),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Not A Member ?',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 19,
          ),
        ),
        TextButton(
          onPressed: (){
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (BuildContext context) =>  SignupPages()
              )
            );
          }, 
          child: const Text('Register Now',style: TextStyle(fontSize: 19),)
        )
      ],
     ),
   ); 
  }
}
