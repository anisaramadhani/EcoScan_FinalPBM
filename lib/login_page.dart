import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'dashboard.dart';
import 'services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),

      body: SafeArea(
        child: Center(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(24),

            child: Container(

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),


              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  const Text(
                    "EcoScan",
                    style: TextStyle(
                      fontSize:18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey
                    ),
                  ),


                  const SizedBox(height:20),


                  const Text(
                    "Selamat datang kembali",
                    style: TextStyle(
                      fontSize:24,
                      fontWeight: FontWeight.bold
                    ),
                  ),


                  const SizedBox(height:8),


                  const Text(
                    "Masuk untuk melanjutkan perjalanan\nramah lingkungan Anda",
                    textAlign: TextAlign.center,
                    style: TextStyle(color:Colors.grey),
                  ),


                  const SizedBox(height:25),



                  _textField(
                    "Email",
                    "nama@email.com",
                    emailController
                  ),



                  _passwordField(),



                  Align(
                    alignment: Alignment.centerRight,

                    child: TextButton(
                      onPressed: (){},

                      child: const Text(
                        "Lupa password?",
                        style: TextStyle(
                          color:Colors.blue
                        ),
                      ),
                    ),
                  ),



                  SizedBox(
                    width:double.infinity,
                    height:50,

                    child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF436946)
                    ),

                    onPressed: _isLoading ? null : () async {
                      final email = emailController.text.trim();
                      final password = passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Email dan password tidak boleh kosong")),
                        );
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await _authService.login(email: email, password: password);
                        if (mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DashboardPage(),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Gagal masuk: ${e.toString().replaceAll(RegExp(r'\[.*?\]\s*'), '')}")),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },

                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            "Masuk",
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                    ),
                  ),



                  const Padding(

                    padding: EdgeInsets.symmetric(vertical:20),

                    child: Text("atau"),

                  ),



                  _socialButton(
                    "Masuk dengan Google",
                    Icons.g_mobiledata
                  ),


                  const SizedBox(height:10),



                  _socialButton(
                    "Masuk dengan Apple",
                    Icons.apple
                  ),



                  const SizedBox(height:20),



                  Row(

                    mainAxisAlignment:
                    MainAxisAlignment.center,


                    children:[


                      const Text(
                        "Belum punya akun? "
                      ),



                      GestureDetector(

                        onTap:(){

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:(context)
                              => const SignUpPage()
                            )
                          );

                        },


                        child: const Text(
                          "Daftar",

                          style:TextStyle(
                            color:Colors.blue,
                            fontWeight:FontWeight.bold
                          ),
                        ),
                      )

                    ],
                  )


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




  Widget _textField(
      String label,
      String hint,
      TextEditingController controller
      ){

    return Column(

      crossAxisAlignment:CrossAxisAlignment.start,

      children:[


        Text(
          label,
          style:
          const TextStyle(
            fontWeight:FontWeight.bold
          ),
        ),


        const SizedBox(height:8),


        TextField(

          controller:controller,

          decoration:InputDecoration(

            hintText:hint,

            filled:true,

            fillColor:Colors.grey[100],

            border:OutlineInputBorder(

              borderRadius:
              BorderRadius.circular(10),

              borderSide:BorderSide.none

            )

          ),
        ),


        const SizedBox(height:16)

      ],
    );

  }





  Widget _passwordField(){

    return Column(

      crossAxisAlignment:CrossAxisAlignment.start,

      children:[


        const Text(
          "Password",
          style:TextStyle(
            fontWeight:FontWeight.bold
          ),
        ),


        const SizedBox(height:8),



        TextField(

          controller:passwordController,


          obscureText:hidePassword,


          decoration:InputDecoration(


            hintText:"Masukkan password",


            suffixIcon:IconButton(

              icon:Icon(

                hidePassword
                ? Icons.visibility_off
                : Icons.visibility

              ),


              onPressed:(){

                setState((){

                  hidePassword =
                  !hidePassword;

                });

              },

            ),


            filled:true,


            fillColor:Colors.grey[100],


            border:OutlineInputBorder(

              borderRadius:
              BorderRadius.circular(10),

              borderSide:BorderSide.none

            )

          ),

        )

      ],
    );

  }





  Widget _socialButton(
      String text,
      IconData icon
      ){

    return OutlinedButton.icon(

      style:OutlinedButton.styleFrom(

        minimumSize:
        const Size(double.infinity,50)

      ),


      onPressed:(){},


      icon:Icon(icon,size:28),


      label:Text(text),

    );

  }

}