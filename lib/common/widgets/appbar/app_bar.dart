import 'package:flutter/material.dart';
import 'package:spotify/common/helipers/mode.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget ? title;
  final Widget ? action;
  final bool hideBack;
  final Color ? backgroundColor;
  const BasicAppbar({
    this.title,
    this.hideBack =false,
    this.action,
    this.backgroundColor,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? const Text(''),
      actions: [
        action ?? Container()
      ],
      leading: hideBack ? null : IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Container(
          height:50 ,
          width: 50,
          decoration: BoxDecoration(
            color:context.isDarkmode ? Colors.white.withOpacity(0.05) :Colors.black.withOpacity(0.05),
            shape: BoxShape.circle
          ),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: context.isDarkmode ? Colors.white : Colors.black,
          ),
        ) 
        ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}