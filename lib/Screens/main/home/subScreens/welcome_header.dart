import 'package:douga2/utils/AppString.dart';
import 'package:flutter/widgets.dart';

class WelcomeHeader extends StatelessWidget{
  const WelcomeHeader({super.key});

  String _getGreeting(){
  int hour = DateTime.now().hour;
    if(hour<12){
      return ('Good morning!');
    }else if(hour<18){
      return ('Good afternoon!');
    }else{
      return('Good evening!');
    }
  }

  @override
  Widget build(BuildContext context){
    String gretting = _getGreeting();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$gretting, Creatoor! 👋',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        Text(
          Appstring.welcomeText1,
          style: TextStyle(color:Color.fromARGB(255, 125, 125, 125)),
        )
      ],
    );
  }
}