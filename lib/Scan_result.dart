import 'package:flutter/material.dart';
import 'alternative_products.dart';



class ScanResultPage extends StatelessWidget {

  const ScanResultPage({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(


      backgroundColor: const Color(0xFFE8F5E9),



      appBar: AppBar(


        backgroundColor: Colors.transparent,

        elevation: 0,



        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),


          onPressed: () {

            Navigator.pop(context);

          },

        ),



        title: const Text(

          "Hasil Scan",

          style: TextStyle(

            color: Colors.black,

            fontWeight: FontWeight.bold,

          ),

        ),



        actions: [


          IconButton(

            onPressed: () {},


            icon: const Icon(

              Icons.share,

              color: Colors.black,

            ),

          ),


        ],


      ),




      body: SingleChildScrollView(


        padding: const EdgeInsets.all(16),



        child: Column(


          children: [



            // Produk

            Card(


              shape: RoundedRectangleBorder(

                borderRadius:
                BorderRadius.circular(12),

              ),



              child: ListTile(


                leading: Container(


                  width:50,

                  height:50,


                  color:Colors.grey[200],


                ),



                title: const Text(

                  "Sabun Cuci Piring Ekologis",

                  style:TextStyle(

                    fontWeight:FontWeight.bold,

                  ),

                ),



                subtitle: const Text(

                  "EcoClean\nProduk Pembersih",

                ),


              ),


            ),





            const SizedBox(height:16),





            // Eco Score


            Container(


              width:double.infinity,


              padding:
              const EdgeInsets.all(24),



              decoration:BoxDecoration(


                color:Colors.white,


                border:Border.all(

                  color:Colors.green,

                ),



                borderRadius:
                BorderRadius.circular(12),


              ),



              child:Column(


                children:[


                  const Text(

                    "Eco Score",

                    style:TextStyle(

                      color:Colors.green,

                    ),

                  ),



                  const Text(

                    "A",

                    style:TextStyle(

                      fontSize:64,

                      fontWeight:FontWeight.bold,

                      color:Color(0xFF436946),

                    ),

                  ),



                  const Text(

                    "Sangat Ramah Lingkungan",

                    style:TextStyle(

                      fontWeight:FontWeight.bold,

                    ),

                  ),


                ],


              ),


            ),






            const SizedBox(height:16),





            // Detail Penilaian


            Column(


              crossAxisAlignment:
              CrossAxisAlignment.start,



              children:[



                const Text(

                  "Detail Penilaian",

                  style:TextStyle(

                    fontSize:18,

                    fontWeight:FontWeight.bold,

                  ),

                ),



                const SizedBox(height:8),



                _buildProgressItem(

                  "Lihat Kemasan Produk",

                  "Bahan Baku",

                  0.95,

                  "95%",

                ),



                _buildProgressItem(

                  "Lihat Detail Jejak Karbon",

                  "Jejak Karbon",

                  0.92,

                  "92%",

                ),



              ],


            ),






            // Fakta Menarik


            Container(


              margin:
              const EdgeInsets.symmetric(vertical:16),



              padding:
              const EdgeInsets.all(16),



              decoration:BoxDecoration(


                color:Colors.white,


                borderRadius:
                BorderRadius.circular(12),


              ),



              child:const Column(


                crossAxisAlignment:
                CrossAxisAlignment.start,



                children:[



                  Row(


                    children:[


                      Icon(

                        Icons.star,

                        color:Colors.amber,

                      ),


                      Text(

                        " Fakta Menarik",

                        style:TextStyle(

                          fontWeight:FontWeight.bold,

                        ),

                      ),


                    ],


                  ),




                  SizedBox(height:8),



                  Text(

                    "Produk ini menggunakan 100% bahan yang dapat terurai secara alami dan diproduksi dengan energi terbarukan, mengurangi jejak karbon hingga 75% dibanding produk konvensional.",

                  ),


                ],


              ),


            ),






            // Tombol alternatif


            SizedBox(


              width:double.infinity,


              height:50,



              child:ElevatedButton(



                style:ElevatedButton.styleFrom(


                  backgroundColor:
                  const Color(0xFF436946),


                ),



                onPressed:(){



                  Navigator.push(


                    context,


                    MaterialPageRoute(


                      builder:(context)
                      => const AlternativeProductsPage(),


                    ),


                  );



                },



                child:const Text(


                  "Lihat Alternatif Lebih Hijau",


                  style:TextStyle(

                    color:Colors.white,

                  ),


                ),


              ),


            ),






            const SizedBox(height:10),






            // Simpan Riwayat


            OutlinedButton.icon(


              style:OutlinedButton.styleFrom(


                minimumSize:
                const Size(double.infinity,50),


              ),



              onPressed:(){},



              icon:const Icon(

                Icons.bookmark_border,

              ),



              label:const Text(

                "Simpan ke Riwayat",

              ),



            ),



          ],


        ),


      ),


    );

  }






  Widget _buildProgressItem(

      String title,

      String subtitle,

      double value,

      String percentage,

      ){


    return Card(


      margin:
      const EdgeInsets.only(bottom:12),



      child:ExpansionTile(


        title:Text(title),



        children:[



          Padding(


            padding:
            const EdgeInsets.all(16),



            child:Column(


              children:[



                Row(


                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,



                  children:[


                    Text(subtitle),


                    Text(percentage),


                  ],


                ),




                const SizedBox(height:8),





                LinearProgressIndicator(


                  value:value,


                  color:
                  const Color(0xFF436946),


                  backgroundColor:
                  Colors.grey[200],


                ),



              ],


            ),


          ),


        ],


      ),


    );

  }


}