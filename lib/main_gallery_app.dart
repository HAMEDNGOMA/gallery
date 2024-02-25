import 'package:flutter/material.dart';
import 'package:gallery/business_logic_layer/cubit/image_management_cubit.dart';
import 'package:gallery/presentation_layer/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainGallery extends StatelessWidget {
  const MainGallery({super.key});

  @override
  Widget build(BuildContext context) {
    // THIS IS MAIN APP WIDGET TO BE RUN AND ROOT OF THE WIDGET TREE
    //THE ROUTE TO BE RUN IS THE HOME SCREEN
    //THE HOME SCREEN IS THE MAIN SCREEN OF THE APP

    return MaterialApp(
      // app title
      title: 'Gallery App',
      // app theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      /// remove the debug banner
      debugShowCheckedModeBanner: false,
      //provide the image management cubit to the home screen
      home: BlocProvider(
        create: (context) => ImageManagementCubit()..getImages(),
        child: const HomeScreen(),
      ),
    );
  }
}
