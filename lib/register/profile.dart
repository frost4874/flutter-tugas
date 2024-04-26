import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belajar_register/register/login_page.dart';
import 'package:belajar_register/main.dart';

class ProfilePage extends StatelessWidget {
  final String namaLengkap;
  final String email;
  final String alamatLengkap;
  final String username;
  final String tanggalLahir;
  final String gender;
  final String password;

  ProfilePage({
    required this.namaLengkap,
    required this.email,
    required this.alamatLengkap,
    required this.username,
    required this.tanggalLahir,
    required this.gender,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // Handle edit profile action
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello', // Teks di luar kotak
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '$namaLengkap', // Teks di luar kotak
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Lebar kontainer = lebar layar
              decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 66, 66, 66), // Warna latar belakang kotak
                borderRadius:
                    BorderRadius.circular(0), // Mengatur border radius kotak
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$username',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$email',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$gender',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$tanggalLahir',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$alamatLengkap',
                    style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => LoginPage(
                  userData: UserData(
                password: password,
                namaLengkap: namaLengkap,
                email: email,
                alamatLengkap: alamatLengkap,
                username: username,
                tanggalLahir: tanggalLahir,
                gender: gender,
              ))),
      (route) => false,
    );
  }
}
