import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_state_management/flutter_redux/screens/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'products_screen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _obscureText = true;
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text('Login', style: Theme.of(context).textTheme.headline3),
                  _emailInputForm(),
                  _passwordInputForm(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        _isSubmitting
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).primaryColor),
                              )
                            : RaisedButton(
                                child: Text(
                                  'Submit',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(color: Colors.white),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                color: Theme.of(context).primaryColor,
                                onPressed: _submit,
                              ),
                        FlatButton(
                          child: Text('Don\'t have account? Register'),
                          onPressed: () => Navigator.of(context)
                              .pushReplacementNamed(RegisterScreen.routeName),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailInputForm() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Email',
            hintText: 'Enter a valid email',
            icon: Icon(Icons.mail, color: Colors.grey)),
        validator: (value) => !value.contains('@') ? 'Email not valid' : null,
        onSaved: (newValue) => _email = newValue,
      ),
    );
  }

  Widget _passwordInputForm() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: TextFormField(
        obscureText: _obscureText,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() => _obscureText = !_obscureText);
                }),
            border: OutlineInputBorder(),
            labelText: 'Password',
            hintText: 'Enter password',
            icon: Icon(Icons.lock, color: Colors.grey)),
        validator: (value) => value.length < 6 ? 'Password too weak' : null,
        onSaved: (newValue) => _password = newValue,
      ),
    );
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      print('form valid');
      form.save();
      _login();
      print('email: $_email, password: $_password');
    } else {
      print('form invalid');
    }
  }

  void _login() async {
    setState(() {
      _isSubmitting = true;
    });
    http.Response response =
        await http.post('http://10.0.2.2:1337/auth/local', body: {
      "identifier": _email,
      "password": _password,
    });
    setState(() {
      _isSubmitting = false;
    });
    final responseData = json.decode(response.body);
    print(responseData);
    if (response.statusCode == 200) {
      _showSuccessSnackBar();
      _storeUserData(responseData);
      _redirectUser();
    } else {
      _showErrorSnackBar(responseData['message'][0]['messages'][0]['message']);
    }
  }

  void _showSuccessSnackBar() {
    final snackBar = SnackBar(content: Text('User successfully logged in!'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // _scaffoldKey.currentState.showSnackBar(snackBar);
    _formKey.currentState.reset();
  }

  void _storeUserData(responseData) async{
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> user = responseData['user'];
    user.putIfAbsent('jwt', () => responseData['jwt']);
    prefs.setString('user', json.encode(user));
  }

  void _redirectUser() {
    Navigator.of(context).pushReplacementNamed(ProductsScreen.routeName);
  }

  void _showErrorSnackBar(String errorMessage) {
    final snackBar = SnackBar(
        content: Text(
      errorMessage,
      style: TextStyle(color: Colors.red),
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    throw Exception('Error logging in: $errorMessage');
  }
}
