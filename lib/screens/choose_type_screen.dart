import 'package:cas_tsyp_app/screens/energy_dashboard.dart';
import 'package:cas_tsyp_app/screens/energy_history.dart';
import 'package:cas_tsyp_app/screens/real_time_visualtion.dart';
import 'package:cas_tsyp_app/screens/system_status.dart';
import 'package:cas_tsyp_app/widgets/screen_type.dart';
import 'package:flutter/material.dart';

class ChooseTypeScreen extends StatelessWidget {
  const ChooseTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenTypesMap = {
      'Energy Management Dashboard': EnergyDashboard.routeName,
      'Energy History': EnergyHistory.routeName,
      'System Status': SystemStatus.routeName,
      'Real Time Data Visualisation': RealTimeVisualtion.routeName,
    };

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            const SizedBox(height: 100,),
            Padding(
                    padding: const EdgeInsets.all(20),
                    child: GridView.builder(
                      shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10),
                        
                        itemCount: screenTypesMap.length,
                        itemBuilder: (context, i) {
                          final title = screenTypesMap.keys.elementAt(i);  
                          final routeName = screenTypesMap[title]!;  
                          return 
                             ScreenType(
                              title: title,   
                              routeName: routeName, 
                            );
                          
                        },
                      ),
                  ),
          ],
        ),
      
          
        
      
      
    );
  }
}
