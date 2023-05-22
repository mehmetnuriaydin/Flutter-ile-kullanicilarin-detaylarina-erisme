import 'package:abt_proje/helper/helper_function.dart';
import 'package:abt_proje/pages/home_page.dart';
import 'package:abt_proje/service/auth_service.dart';
import 'package:flutter/material.dart';

import '../../service/firebase_analytics.dart';
import '../../widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  List<bool> isSelected = [false, false];
  String gender = "";
  String category = "Sağlık";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 90),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Kayıt Ol",
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: "Ad Soyad",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Theme.of(context).primaryColor,
                            )),
                        onChanged: (val) {
                          setState(() {
                            fullName = val;
                          });
                        },
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return "Ad soyad boş bırakılamaz.";
                          }
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Theme.of(context).primaryColor,
                            )),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },

                        //check the validation

                        validator: (val) {
                          return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)
                              ? null
                              : "Lütfen geçerli bir email giriniz";
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: textInputDecoration.copyWith(
                            labelText: "Şifre",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Theme.of(context).primaryColor,
                            )),
                        validator: (val) {
                          if (val!.length < 6) {
                            return "En az 6 karakter girilmeli";
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() {
                            password = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ToggleButtons(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text('Erkek'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text('Kadın'),
                              )
                            ],
                            isSelected: isSelected,
                            borderRadius: BorderRadius.circular(13),
                            onPressed: (int newIndex) {
                              setState(() {
                                for (int index = 0; index < isSelected.length; index++) {
                                  if (index == newIndex) {
                                    isSelected[index] = true;
                                    if (index == 0) {
                                      gender = 'Erkek';
                                    } else {
                                      gender = 'Kadın';
                                    }
                                  } else {
                                    isSelected[index] = false;
                                  }
                                }
                              });
                            },
                            fillColor: Colors.lightBlue.shade800,
                            color: Colors.blue,
                            selectedColor: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButton<String>(
                          items: const [
                            DropdownMenuItem(
                              child: Text('Sağlık'),
                              value: 'Sağlık',
                            ),
                            DropdownMenuItem(
                              child: Text('Eğitim'),
                              value: 'Eğitim',
                            ),
                            DropdownMenuItem(
                              child: Text('Teknoloji'),
                              value: 'Teknoloji',
                            )
                          ],
                          value: category,
                          icon: Icon(Icons.menu),
                          onChanged: (String? newCategory) {
                            setState(() {
                              category = newCategory!;
                            });
                          }),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                          child: Text(
                            "Kayıt Ol",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onPressed: () {
                            register();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  register() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailandPassword(fullName, email, password, gender, category)
          .then((value) async {
        if (value == true) {
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(email);
          await HelperFunctions.saveUserNameSF(fullName);
          nextScreenReplace(context, HomePage());
        } else {
          showSnackbar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
