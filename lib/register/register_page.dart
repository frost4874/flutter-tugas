import 'package:belajar_register/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:belajar_register/register/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool visibility = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController tanggalLahirController = TextEditingController();
  TextEditingController alamatLengkapController = TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Laki-laki', 'Perempuan'];
  final form_key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      namaLengkapController.text = prefs.getString('namaLengkap') ?? '';
      usernameController.text = prefs.getString('username') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      tanggalLahirController.text = prefs.getString('tanggalLahir') ?? '';
      selectedGender = prefs.getString('gender') ?? null;
      alamatLengkapController.text = prefs.getString('alamatLengkap') ?? '';
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        tanggalLahirController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form_key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: namaLengkapController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Nama Lengkap",
                    prefixIcon: Icon(Icons.person),
                    hintText: "Masukkan Nama Lengkap",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama Lengkap Harus di isi';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Masukkan Username",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username Harus di isi';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    hintText: "Masukkan Email",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email Harus di isi';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: visibility,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password Harus di isi';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: tanggalLahirController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Tanggal Lahir",
                    prefixIcon: Icon(Icons.calendar_today),
                    hintText: "Pilih Tanggal Lahir",
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal Lahir Harus di isi';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Jenis Kelamin",
                    prefixIcon: Icon(Icons.wc_outlined),
                  ),
                  value: selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  items: genderOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Jenis Kelamin Harus di isi';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: alamatLengkapController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    labelText: "Alamat Lengkap",
                    prefixIcon: Icon(Icons.place),
                    hintText: "Masukkan Alamat Lengkap",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Alamat Lengkap Harus di isi';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    _register();
                  },
                  child: Text('Daftar'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sudah punya akun? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Login"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _register() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (form_key.currentState!.validate()) {
      UserData userData = UserData(
        namaLengkap: namaLengkapController.text,
        username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        tanggalLahir: tanggalLahirController.text,
        gender: selectedGender,
        alamatLengkap: alamatLengkapController.text,
      );

      await prefs.setString('namaLengkap', userData.namaLengkap ?? '');
      await prefs.setString('username', userData.username ?? '');
      await prefs.setString('email', userData.email ?? '');
      await prefs.setString('password', userData.password ?? '');
      await prefs.setString('tanggalLahir', userData.tanggalLahir ?? '');
      await prefs.setString('gender', userData.gender ?? '');
      await prefs.setString('alamatLengkap', userData.alamatLengkap ?? '');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(userData: userData),
        ),
      );
    }
  }
}
