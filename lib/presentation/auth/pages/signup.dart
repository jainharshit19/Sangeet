import 'package:flutter/material.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/button/basic_app_button.dart';
import 'package:spotify/core/config/assets/app_vector.dart';
import 'package:spotify/data/models/user_req.dart';
import 'package:spotify/domain/usecases/signup_usecase.dart';
import 'package:spotify/presentation/auth/pages/signin.dart';
import 'package:spotify/presentation/home/home.dart';
import 'package:spotify/service_locator.dart';

class SignupPages extends StatelessWidget {
  SignupPages({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppbar(
        title: 
        Image(
          image: AssetImage(
            AppVectors.logo,
            ),
            height:140,width: 140,),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 50,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 50,),
              _fullNameField(context),
              const SizedBox(height: 20,),
              _emailField(context),
              const SizedBox(height: 20,),
              _passwordField(context),
              const SizedBox(height: 40,),
              BasicAppButton(
                onPressed: ()async{
                  print("Hello1");
                  var result = await s1<SignupUsecase> ().call(
                    params: UserReq(
                      fullName: _fullName.text.toString(),
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
                title: 'Create Account' )
            ],
          ),
        ),
      ),
    );
  }
  Widget _registerText() {
    return const Text(
      "Register",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 27,
       
      ),
      textAlign: TextAlign.center,
      );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      controller: _fullName,
      decoration: const InputDecoration(
       hintText: 'Full Name' 
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme
      ),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
       hintText: 'Enter Email' 
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
  Widget _signinText (BuildContext context){
   return  Padding(
     padding: const EdgeInsets.symmetric(
      vertical: 30,
     ),
     child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Do you have an account ?',
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
                builder: (BuildContext context) =>  SigninPages()
              )
            );
          }, 
          child: const Text('Sign in',style: TextStyle(fontSize: 19),)
        )
      ],
     ),
   ); 
  }
}
