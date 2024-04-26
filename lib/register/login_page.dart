import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belajar_register/register/profile.dart';
import 'package:belajar_register/register/register_page.dart';
import 'package:belajar_register/main.dart';

class LoginPage extends StatefulWidget {
  final UserData userData;

  const LoginPage({Key? key, required this.userData}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool visibility = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Image.asset(
            'assets/images/tw.png',
            width: 100,
            height: 100,
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Email",
                prefixIcon: Icon(Icons.email_rounded),
                hintText: "Masukkan Email",
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: passwordController,
              obscureText: visibility,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: "Password",
                prefixIcon: Icon(Icons.key),
                hintText: "Masukkan Password",
                suffixIcon: IconButton(
                  icon: visibility
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      visibility = !visibility;
                    });
                  },
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () {
                _login();
              },
              child: Text('Login'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Belum mempunyai akun? "),
                TextButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    );
                    Navigator.push(context, route);
                  },
                  child: Text(
                    "Register",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    String email = emailController.text;
    String password = passwordController.text;

    if (storedEmail != null &&
        storedPassword != null &&
        email == storedEmail &&
        password == storedPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(
            namaLengkap: widget.userData.namaLengkap ?? '',
            email: widget.userData.email ?? '',
            alamatLengkap: widget.userData.alamatLengkap ?? '',
            username: widget.userData.username ?? '',
            tanggalLahir: widget.userData.tanggalLahir ?? '',
            gender: widget.userData.gender ?? '',
            password: widget.userData.password ?? '',
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email atau password tidak valid'),
        ),
      );
    }
  }
}
