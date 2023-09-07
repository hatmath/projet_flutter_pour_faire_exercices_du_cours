import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";

class Auth{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({required String email, required String password}) async{
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password);
  }

  Future<void> createUserWithEmailAndPassword({required String email, required String password}) async{
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password);
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

}



class HomePage extends StatelessWidget{
  HomePage({Key? key}):super(key:key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async{
    await Auth().signOut();
  }

  Widget _title(){
    return const Text("Firebase Auth");
  }

  Widget _signOutButton(){
    return ElevatedButton(onPressed: signOut, child: const Text("Sign out"));
  }

  Widget _userUID(){
    return Text(user?.email ?? 'User email');
  }

  @override
  Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(title: _title(),),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_userUID(), _signOutButton()],
          ),
        ),

      );
  }
}

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}):super(key: key);
  @override
  State<LoginPage> createState()=> _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  String _errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async{
    try{
      await Auth().signInWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch(e){
      setState(() {
         _errorMessage = e.message ?? '';
      });
     
    }
  }

  Future<void> createUserWithEmailAndPassword() async{
    try{
      await Auth().createUserWithEmailAndPassword(email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch(e){
      setState(() {
        _errorMessage = e.message ?? '';
      });
    }
  }

  Widget _title(){
    return const Text('Firebase Auth');
  }

  Widget _entryField(String title, TextEditingController controller){
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessageWidget(){
    return Text(_errorMessage == '' ? '' : '$_errorMessage');
  }

  Widget _submitButton(){
    return ElevatedButton(onPressed: isLogin? signInWithEmailAndPassword: createUserWithEmailAndPassword, 
    child: Text(isLogin? 'Login' : 'Register'));
  }

  Widget _loginOrRegistrationButton(){
    
    
    return TextButton(onPressed: (){
      setState(() {
        isLogin = !isLogin;
      });
    }, child: Text(isLogin ? 'Register instead': 'Login instead')

    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: _title()),
      body: Container(height: double.infinity,width: double.infinity, padding: const EdgeInsets.all(20),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _entryField('email', _controllerEmail),
          _entryField('password', _controllerPassword),
          _errorMessageWidget(),
          _submitButton(),
          _loginOrRegistrationButton()
    
        ],
      )),
    );
  }
}


class WidgetTree extends StatefulWidget{
  const WidgetTree({Key? key}): super(key: key);
  
  @override
  State<WidgetTree> createState() =>  _WidgetTreeState();

}

class _WidgetTreeState extends State<WidgetTree>{

  @override
  Widget build(BuildContext context){
    return StreamBuilder(stream: Auth().authStateChange,
    builder: (context, snapshot){
      if(snapshot.hasData){
        return HomePage();
      }
      else {
        return const LoginPage();
      }

    }
    );
  }
}

/*class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text("This is my home")),);
  }
}
*/

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({Key? key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(theme:ThemeData(
        primarySwatch: Colors.orange,
    ),
    home: const WidgetTree(),
    );
  }
}