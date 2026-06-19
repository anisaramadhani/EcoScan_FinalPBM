import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'scan_result.dart';


class ScanPage extends StatefulWidget {
  const ScanPage({super.key});


  @override
  State<ScanPage> createState() => _ScanPageState();
}



class _ScanPageState extends State<ScanPage> {


  final MobileScannerController controller =
      MobileScannerController();


  bool scanned = false;

  bool torchEnabled = false;


  String barcodeValue = '';



  @override
  void dispose() {

    controller.dispose();

    super.dispose();

  }




  void _showManualInput(BuildContext context) {
    final txtController = TextEditingController();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text("Input Barcode Manual"),
          content: TextField(
            controller: txtController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: "Contoh: 8992326110301",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF436946)),
              onPressed: () {
                final barcode = txtController.text.trim();
                if (barcode.isNotEmpty) {
                  Navigator.pop(dialogContext);
                  _openScanResult(barcode);
                }
              },
              child: const Text("Cari", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  void _openScanResult(String barcode) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScanResultPage(barcode: barcode),
      ),
    );
  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor: const Color(0xFFEAF1E3),



      appBar: AppBar(


        title: const Text(
          "Scan Produk",
        ),


        centerTitle:true,


        backgroundColor:
        const Color(0xFFEAF1E3),


        elevation:0,

        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF436946)),
            tooltip: "Input Barcode Manual",
            onPressed: () => _showManualInput(context),
          ),
        ],

      ),




      body:Stack(


        children:[



          /// Kamera

          MobileScanner(


            controller:controller,


            onDetect:(capture){


              if(scanned) return;



              final barcode =
              capture.barcodes.first;



              final value =
              barcode.rawValue ?? '';



              if(value.isNotEmpty){


                setState((){


                  scanned=true;


                  barcodeValue=value;


                });



                _openScanResult(value);



              }


            },

          ),





          /// Flash

          Positioned(


            top:20,


            left:20,


            child:Container(


              decoration:BoxDecoration(

                color:Colors.black45,

                borderRadius:
                BorderRadius.circular(30),

              ),


              child:IconButton(


                onPressed:() async {


                  await controller.toggleTorch();



                  setState((){


                    torchEnabled =
                    !torchEnabled;


                  });


                },



                icon:Icon(


                  torchEnabled

                  ? Icons.flash_on

                  : Icons.flash_off,


                  color:Colors.white,


                ),


              ),


            ),


          ),






          /// Ganti kamera


          Positioned(


            top:20,


            right:20,


            child:Container(


              decoration:BoxDecoration(


                color:Colors.black45,


                borderRadius:
                BorderRadius.circular(30),

              ),



              child:IconButton(


                onPressed:(){


                  controller.switchCamera();


                },


                icon:const Icon(


                  Icons.cameraswitch,


                  color:Colors.white,


                ),


              ),


            ),


          ),






          /// Kotak scan


          Center(


            child:Container(


              width:260,


              height:260,



              decoration:BoxDecoration(


                border:Border.all(

                  color:Colors.green,

                  width:3,

                ),



                borderRadius:
                BorderRadius.circular(20),


              ),



            ),


          ),







          /// Text petunjuk


          Positioned(


            bottom:100,


            left:0,


            right:0,


            child:Center(


              child:Container(


                padding:
                const EdgeInsets.symmetric(

                  horizontal:24,

                  vertical:12,

                ),



                decoration:BoxDecoration(


                  color:Colors.black54,


                  borderRadius:
                  BorderRadius.circular(25),


                ),



                child:const Text(


                  "Arahkan kamera ke barcode produk",


                  style:TextStyle(


                    color:Colors.white,

                    fontSize:14,


                  ),


                ),


              ),


            ),


          ),



        ],


      ),


    );

  }

}