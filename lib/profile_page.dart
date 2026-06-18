import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'riwayat_page.dart';
import 'scan.dart';


class ProfilePage extends StatelessWidget {

  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: const Color(0xFFE8F5E9),



      body: SafeArea(


        child: SingleChildScrollView(


          padding: const EdgeInsets.all(16),



          child: Column(


            crossAxisAlignment: CrossAxisAlignment.start,


            children: [



              const Text(

                "Profil",

                style: TextStyle(

                  fontSize:24,

                  fontWeight:FontWeight.bold,

                ),

              ),



              const SizedBox(height:16),






              Card(


                shape: RoundedRectangleBorder(

                  borderRadius:
                  BorderRadius.circular(12),

                ),



                child: ListTile(


                  leading: const CircleAvatar(

                    radius:30,

                    backgroundImage: NetworkImage(

                      "https://via.placeholder.com/150",

                    ),

                  ),



                  title: const Text(

                    "Pengguna EcoScan",

                    style:TextStyle(

                      fontWeight:FontWeight.bold,

                    ),

                  ),



                  subtitle: const Text(

                    "EcoScan@email.com",

                  ),



                  trailing: OutlinedButton(


                    onPressed:(){},


                    child:const Text(

                      "Edit",

                    ),

                  ),


                ),


              ),






              const SizedBox(height:16),





              Card(


                child: Padding(


                  padding:
                  const EdgeInsets.all(20),



                  child:Row(


                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,



                    children:[


                      _buildStatItem(

                        "47",

                        "Total Scan",

                      ),



                      _buildStatItem(

                        "8.7 kg",

                        "CO2 Hemat",

                      ),


                    ],


                  ),


                ),


              ),






              const SizedBox(height:16),





              const Text(

                "Pengaturan",

                style:TextStyle(

                  fontWeight:FontWeight.bold,

                ),

              ),



              const SizedBox(height:8),



              _buildSettingList(),





              const SizedBox(height:16),




              const Text(

                "Akun",

                style:TextStyle(

                  fontWeight:FontWeight.bold,

                ),

              ),




              const SizedBox(height:8),




              _buildAccountOptions(),






              const SizedBox(height:16),




              SizedBox(


                width:double.infinity,


                child:OutlinedButton.icon(


                  onPressed:(){},



                  icon:const Icon(

                    Icons.logout,

                  ),



                  label:const Text(

                    "Keluar",

                  ),


                ),


              ),




              const SizedBox(height:8),




              const Center(


                child:Text(

                  "EcoScan v1.0.0",

                  style:TextStyle(

                    color:Colors.grey,

                    fontSize:12,

                  ),

                ),

              ),


            ],


          ),


        ),


      ),






      bottomNavigationBar: BottomNavigationBar(


        currentIndex:3,


        type:BottomNavigationBarType.fixed,


        selectedItemColor:Colors.green.shade900,



        onTap:(index){



          if(index==0){


            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder:(_)=> DashboardPage(),

              ),

            );


          }



          if(index==1){


            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder:(_)=> const RiwayatPage(),

              ),

            );


          }




          if(index==2){


            Navigator.pushReplacement(

              context,

              MaterialPageRoute(

                builder:(_)=> const ScanPage(),

              ),

            );


          }



        },



        items: const [


          BottomNavigationBarItem(

            icon:Icon(Icons.home_outlined),

            label:"Home",

          ),



          BottomNavigationBarItem(

            icon:Icon(Icons.history),

            label:"Riwayat",

          ),



          BottomNavigationBarItem(

            icon:Icon(Icons.qr_code_scanner),

            label:"Scan",

          ),



          BottomNavigationBarItem(

            icon:Icon(Icons.person),

            label:"Profil",

          ),


        ],


      ),


    );


  }






  Widget _buildStatItem(String value,String label){


    return Column(


      children:[


        Text(

          value,

          style:const TextStyle(

            fontSize:20,

            fontWeight:FontWeight.bold,

          ),

        ),



        Text(

          label,

          style:const TextStyle(

            color:Colors.grey,

          ),

        ),


      ],


    );


  }







  Widget _buildSettingList(){


    return Card(


      child:Column(


        children:[



          ListTile(

            leading:const Icon(Icons.notifications_none),

            title:const Text("Notifikasi"),

            onTap:(){},

          ),



          ListTile(

            leading:const Icon(Icons.language),

            title:const Text("Bahasa"),

            onTap:(){},

          ),



          ListTile(

            leading:const Icon(Icons.palette_outlined),

            title:const Text("Tema"),

            onTap:(){},

          ),



        ],


      ),


    );


  }







  Widget _buildAccountOptions(){


    return Card(


      child:Column(


        children:[


          ListTile(

            leading:const Icon(Icons.person_outline),

            title:const Text("Edit Profil"),

            onTap:(){},

          ),



          ListTile(

            leading:const Icon(Icons.lock_outline),

            title:const Text("Kebijakan Privasi"),

            onTap:(){},

          ),



          ListTile(

            leading:const Icon(Icons.description_outlined),

            title:const Text("Syarat & Ketentuan"),

            onTap:(){},

          ),


        ],


      ),


    );


  }



}