import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


import '../Widgets/LoadingBarrier.dart';
import '../../Controllers/AuthController.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();

  var isShowPass = true.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder<AuthController>(builder: (authC) {
      return LoadingBarrier(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/img/bg.jpg'),
              fit: BoxFit.cover,
            ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30,),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text("LOGIN PBSI PEKANBARU", textAlign: TextAlign.center, style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),),
                                
                        GetBuilder<AuthController>(builder: (authC) {
                          return Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 40),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                          controller: TextEditingController(),
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "E-mail/Username",
                                            prefixIcon: const Icon(Icons.person),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(
                                                  20.0), // Melengkungkan border
                                            ),
                                          ),
                                          onSaved: (value) {
                                            authC.email.value = value!;
                                          },
                                          onFieldSubmitted: (value) {
                                            if (_formKey.currentState!.validate()) {
                                              _formKey.currentState!.save();
                                              authC.login();
                                            }
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "E-Mail Wajib Di Isi";
                                            }
                                            if(value.length < 6 ){
                                              return "Username Terlalu Pendek";
                                            }
                                          }),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Obx(() => TextFormField(
                                        obscureText: isShowPass.value,
                                        
                                        decoration: InputDecoration(
                                          
                                          suffix: InkWell(
                                            onTap:(){
                                              isShowPass.value = !isShowPass.value;
                                            },
                                            child: (isShowPass.value ? const FaIcon(FontAwesomeIcons.solidEye, size: 20,):const FaIcon(FontAwesomeIcons.solidEyeSlash, size: 20)),
                                          ),
                                          hintText: "Password",
                                          prefixIcon: const Icon(Icons.lock),
                                          //filled: true,
                                          //fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Melengkungkan border
                                          ),
                                        ),
                                        onSaved: (value) {
                                          authC.password.value = value!;
                                        },
                                        onFieldSubmitted: (value) {
                                          if (_formKey.currentState!.validate()) {
                                            _formKey.currentState!.save();
                                            authC.login();
                                          }
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Password Wajib Di Isi";
                                          }
                                        },
                                      ),),
                                      if (authC.isLoginFail.value)
                                        const Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "username atau password salah",
                                              style: TextStyle(color: Colors.red),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: Get.width / 3,
                                  height: 60,
                                  child: ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(Colors.green)
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          authC.login();
                                        }
                                      },
                                      child: const Text("LOGIN", style: TextStyle(color: Colors.white),)),
                                )
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }
}
