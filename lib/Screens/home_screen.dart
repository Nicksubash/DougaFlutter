import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import './subScreens/connected_platform.dart';
import './subScreens/recent_upload.dart';
import './subScreens/performance_metrics.dart';
import './subScreens/welcome_header.dart';
import './subScreens/quick_upload.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen>{
    File? _selectedMedia; // To store the picked file (image or video)

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildMultiUploadButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        '',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Iconsax.notification),
          onPressed: () {
            // TODO: Implement notification functionality
          },
        ),
        IconButton(
          icon: const Icon(Iconsax.setting_2),
          onPressed: () {
            // TODO: Implement settings functionality
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WelcomeHeader(), // Use the new WelcomeHeader widget
          const SizedBox(height: 24),
          QuickUpload(onStartUpload: _onStartUpload), // Use QuickUploadCard
          const SizedBox(height: 24),
          ConnectedPlatforms(onPlatformConnect: _onPlatformConnect), // Use ConnectedPlatforms
          const SizedBox(height: 24),
          RecentUploads(onViewAllUploads: _onViewAllUploads), // Use RecentUploads
          const SizedBox(height: 24),
          const PerformanceMetrics(), // Use PerformanceMetrics
          const SizedBox(height: 24),
          // Display the selected media (for testing)
          if(_selectedMedia !=null)
            _selectedMedia!.path.endsWith('.mp4') //check if its video
            ? Text('Selected Video : ${_selectedMedia!.path}')
            :Image.file(_selectedMedia!,height: 200),
          
        ],
      ),
    );
  }

  // ... rest of your HomeScreen class ( _buildAppBar, _buildMultiUploadButton, _onStartUpload, _onPlatformConnect, _onViewAllUploads, _onNewUpload )
    Widget _buildMultiUploadButton() {
    return FloatingActionButton.extended(
      icon: const Icon(Iconsax.export),
      label: const Text('New Upload'),
      backgroundColor: Colors.purpleAccent,
      foregroundColor: Colors.white,
      onPressed: _onNewUpload,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }

  // Placeholder methods for navigation and actions
  void _onStartUpload() {
    // TODO: Implement upload functionality
  }

  void _onPlatformConnect(String platformName) {
    // TODO: Implement platform connection logic
  }

  void _onViewAllUploads() {
    // TODO: Implement view all uploads navigation
  }

  // void _onNewUpload() {
  //   // TODO: Implement new upload functionality
  // }

  // void _onNewUpload() async{
  //   final ImagePicker picker = ImagePicker();

  //   //showing dialog to let the user choose between image or video
  //   final String? choice  =await showDialog(
  //     context: context,
  //     builder: (BuildContext context){
  //       return SimpleDialog(
  //         title: const Text("Select Media"),
  //         children: [
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 'image'),
  //             child: const Text('Pick Image'),
  //           ),
  //           SimpleDialogOption(
  //             onPressed: () => Navigator.pop(context, 'video'),
  //             child: const Text('Pick Video'),
  //           )
  //         ],
  //       );
  //     }
  //   );

  //   if(choice == null) return;

  //   final XFile? media = await (choice == 'image'
  //   ? picker.pickImage(source: ImageSource.gallery)
  //   : picker.pickVideo(source: ImageSource.gallery));

  //   if(media !=null){
  //     setState(() {
  //       _selectedMedia = File(media.path);
  //     });
  //     //Todo: Add logic to upload the file(eg.to firebase or AWS S3)
  //     print('Selected media path: ${media.path}');
  //   }
  // }

  void _onNewUpload() async {
    final ImagePicker picker = ImagePicker();
    final String? userChoice = await showDialog(
      context: context,
      builder: (BuildContext context){
        return SimpleDialog(
          title: const Text("Choose Media Source"),
          children: [
            SimpleDialogOption(
              onPressed: ()=> Navigator.pop(context,'gallery'),
              child: const Text("Select from Gallery"),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context,'camera'),
              child: const Text("Camera"),
            )
          ],
        );
      }
    );

    if(userChoice == null) return;

    final XFile? media = userChoice == 'gallery'
    ? await picker.pickMedia()
    : await picker.pickImage(source: ImageSource.camera);

    if(media != null){
      setState(() {
        _selectedMedia = File(media.path);
      });
      // TODO: Add logic to upload the file (e.g., to Firebase or AWS S3)
      print('Selected media path: ${media.path}');
    }
  }
}