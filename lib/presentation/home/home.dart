import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spotify/common/helipers/mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/core/config/assets/app_images.dart';
import 'package:spotify/core/config/assets/app_vector.dart';
import 'package:spotify/presentation/home/widget/news_songs.dart';
import 'package:spotify/presentation/home/widget/play_list.dart';
import 'package:spotify/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
   late TabController tabController ;

  @override
  void initState(){
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        hideBack: true,
        action: IconButton(
          onPressed: (){
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (BuildContext context) =>  const ProfilePage())
            );
          }, 
          icon: const Icon(Icons.person,
          
          )
        ),
        title: 
        Image(
          image: AssetImage(
            AppVectors.logo,
            ),
            height:140,width: 140,),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height:260,
              child: TabBarView(
                controller: tabController,
                children: [
                  const NewsSongs(),
                  Container(),
                  Container(),
                  Container(),
                ],
              ),
            ),
            
            const PlayList()
          ],
        ),
      ),
    );
  }

  Widget _homeTopCard(){
    return Center(
      child: SizedBox(
        height: 148,
        child: Stack(
          children: [
            Align
            (
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                AppVectors.homeTopCard
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 60
                ),
                child: Image.asset(
                  AppImages.homeArtist
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Widget _tabs (){
    return  TabBar(
      controller: tabController,
      isScrollable: true,
      labelColor: context.isDarkmode ? Colors.white: Colors.black,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20
      ),
      tabs: const [
        Text('News',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14),),
        Text('Videos',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14),),
        Text('Artist',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14),),
        Text('Podcasts',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14),),
    ], 
  );
  }
}