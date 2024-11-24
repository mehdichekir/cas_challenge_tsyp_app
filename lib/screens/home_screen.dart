import 'package:cas_tsyp_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  static const routeName= '/Home_screen';
  const HomeScreen({super.key});

  void showSheet(BuildContext ctx) {
    print('button pressed');
  showModalBottomSheet(
    context: ctx,
    isScrollControlled: true, 
    backgroundColor: Colors.transparent, 
    builder: (_) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque, 
        child: Container(
          width: double.infinity, 
          height: 400,
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom, 
          ),
          decoration: const BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), 
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              const SizedBox(height: 16),
              const Text(
                'Welcome to Energify',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.green),
              ),
              const SizedBox(height: 10),
              const Text(
                'Power up your life with clean energy.',
                style: TextStyle(fontSize: 16,
                color: Colors.lightBlue),
                textAlign: TextAlign.center,
                
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap:()=> Navigator.of(ctx).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const AuthScreen(),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    width: double.infinity,
                    height: 50,
                    child: const Center(child: Text('Continue'),),
                  ),
              ),
           
            ],
          ),
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25,),
            Image.asset('assets/home-screen-image.png',
            height: 350,
            width: 350,
            errorBuilder: (context, error, stackTrace) {
            return const Text('Asset not found');
  },),
            const Text('Energify',
            style: TextStyle(color: Color.fromRGBO(150, 226, 77, 1),fontSize: 35,fontWeight: FontWeight.bold),
            ),
            const Text('Power up your life with clean energy',
            style:TextStyle(color: Color.fromRGBO(0, 166, 225, 1),
            fontSize: 15) ,),
            const SizedBox(
              height: 10,
            ),
            const Text('Allow users to purchase and manage their solar energy usage in advance, using prepaid tokens or credits. A fast, efficient, and secure, providing users with a convenient and cost-effective way to access clean energy.',
            style: TextStyle(
              fontSize: 13,
            )),
           const  SizedBox(height: 60,),
             Stack(
               children:[
                Container(
                padding: const EdgeInsets.all(9),
                decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.green, 
                    width: 2, 
                  ),
                ),
                 child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20), 
                          backgroundColor: const Color.fromRGBO(150, 226, 77, 1),
                          ),
                        onPressed: ()=>showSheet(context),
                        child:const Icon(Icons.arrow_forward,color: Colors.white,) ,
                  
                        ),
               ),

               ] 
             ),
            
          ],
        ),
      ),
    );
  }
}