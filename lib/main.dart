import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'admin/views/state.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
      authProviders: AuthProviders(emailAndPassword: true),
      child: MaterialApp(
        home: LitAuthState(
          authenticated: Home(),
          unauthenticated: LoginPage(),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Samrajya"),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: LitAuth.custom(
            child: CustomSignInWidget(),
          ),
        ));
  }
}

class CustomSignInWidget extends StatelessWidget {
  const CustomSignInWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,40,0,0),
          child: Text('Welcome', style: Theme.of(context).textTheme.headline4),
        ),
        SignInForm(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'ADMIN',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: EmailTextFormField(
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Admin',
                    icon: Icon(Icons.person),
                    hintText: 'Email',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PasswordTextFormField(
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.remove_red_eye),
                    hintText: 'Password',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  context.signInWithEmailAndPassword();
                },
                child: Text('Sign In'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Admin panel"),
        backgroundColor: Colors.teal,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              context.signOut();
            },
          ),
        ],
      ),
      body: Rules(),
    );
  }
}
