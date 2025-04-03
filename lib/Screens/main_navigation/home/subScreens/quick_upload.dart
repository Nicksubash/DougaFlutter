import 'package:douga2/Screens/uploadScreen/upload_screen.dart';
import 'package:douga2/utils/AppString.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuickUpload extends StatelessWidget{
  final VoidCallback onStartUpload;

  const QuickUpload({super.key,required this.onStartUpload});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purpleAccent, Colors.blueAccent],
          begin:Alignment.topLeft,
          end: Alignment.bottomRight
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Iconsax.video_play, size:40, color: Colors.white),
          const SizedBox(height: 16),
          const Text(
            Appstring.uploadPlatfrom,
            style: TextStyle(
              color: Colors.white,
              fontSize:18,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            Appstring.appSlogan,
            style: TextStyle(
              color:Colors.white70,
            ),            
          ),
          const SizedBox(height: 16),
            ElevatedButton.icon(
            icon: const Icon(Iconsax.export),
            label: const Text('Start Upload'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.purpleAccent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  void _onStartUpload(){
  
  }
}