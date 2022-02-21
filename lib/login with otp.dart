import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedemo/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _MobileNumberController = TextEditingController();
  final TextEditingController _codecontroller = TextEditingController();
  final FirebaseAuth _firebasauth = FirebaseAuth.instance;

  String phoneNumber = " ";
  void _onCountryChange(CountryCode countryCode) {
    this.phoneNumber = countryCode.toString();
    print("======>>>New Country selected: " + countryCode.toString());
  }

  Future<void> SignOutMe() async {
    await _firebasauth.signOut();
    print("Sign Out");
  }

  Future<bool?> loginuser(String phone, BuildContext context) async {
    _firebasauth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential result =
            await _firebasauth.signInWithCredential(credential);
        User? itsuser = result.user;

        if (itsuser != null) {
          print('User login Succesfully');
        } else {
          print("eror");
        }
      },
      verificationFailed: (exception) {
        print(exception);
      },
      codeSent: (String verificationID, [int? forceResendingToken]) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (Context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text('Give the code?'),
              content: Column(
                children: [
                  TextField(
                    controller: _codecontroller,
                  ),
                ],
              ),
              actions: [
                FlatButton(
                  onPressed: () async {
                    final _code = _codecontroller.text.trim();
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationID, smsCode: _code);
                    UserCredential result =
                        await _firebasauth.signInWithCredential(credential);
                    User? itsuser = result.user;

                    if (itsuser != null) {
                      print('User login Succesfully');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Fire(),
                        ),
                      );
                    } else {
                      print("eror");
                    }
                  },
                  child: Text("Confirm"),
                ),
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("Timeout");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login with Otp"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 25),
        child: Column(
          children: [
            TextField(
              controller: _MobileNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(13),
              ],
              decoration: InputDecoration(
                prefixIcon: CountryCodePicker(
                  onChanged: _onCountryChange,
                  initialSelection: 'IN',
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Mobile Number",
                hintText: "Enter Your Mobile Number",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final phone =
                    this.phoneNumber + _MobileNumberController.text.trim();
                print("======>>>>country code${phone} ${_codecontroller.text}");
                loginuser(phone, context);
              },
              child: Text("Send Otp"),
            ),
            ElevatedButton(
              onPressed: () {
                SignOutMe();
              },
              child: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
