import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/config/assets/app_vector.dart';
import 'package:spotify/presentation/Wrapper.dart';
import 'package:spotify/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify/presentation/choose_mode/bloc/theme_cubit.dart';

import '../../../common/widgets/button/basic_app_button.dart';
import '../../../core/config/assets/app_images.dart';
import '../../../core/config/theme/app_colors.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppImages.chooseModeBG
                )
                )
            ),
            
          ),

          Container(
            color: Colors.black.withOpacity(0.15),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 40
            ),
            child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topCenter,
                  ),
                  const Image(image: AssetImage(AppVectors.logo)),
                  const Spacer(),
                  const Text(
                    'Choose Mode',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
            
                  const SizedBox(height: 39,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().updateTheme(ThemeMode.dark);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF).withOpacity(0.5),
                                  shape: BoxShape.circle
                                ),
                                child: const Image(image: AssetImage(AppVectors.moon),
                                fit: BoxFit.none,
                                ),
                                
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        const Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColors.grey
                          ),
                          ),
                      ],
                    ),
                    const SizedBox(width:40 ,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().updateTheme(ThemeMode.light);
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
                              child: Container(
                                height: 80,
                                width: 80,
                                
                                decoration: BoxDecoration(
                                  color: const Color(0xffFFFFFF).withOpacity(0.5),
                                  shape: BoxShape.circle
                                ),
                                child: const Image(image: AssetImage(AppVectors.sun),
                                fit: BoxFit.none
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15,),
                        const Text(
                          'Light Mode',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColors.grey
                          ),
                          ),
                      ],
                    ),
                   ], 
                  ),
                  const SizedBox(height: 50,),
                  BasicAppButton(
                    onPressed: (){
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (BuildContext context) => const Wrapper()
                          )
                          );
            
                    }, 
                    title: 'Continue',
                  )
                ],
              ),
          ),
        ],
      ),
    );
  }
}