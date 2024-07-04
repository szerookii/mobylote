import 'package:flutter/material.dart';
import 'package:mobylote/pylote/login.dart';
import 'package:mobylote/utils/email.dart';
import 'package:mobylote/utils/dialog.dart';
import 'package:mobylote/views/login/verify_code.dart';

class AskCodePage extends StatefulWidget {
  const AskCodePage({super.key});

  @override
  State<AskCodePage> createState() => _AskCodePageState();
}

class _AskCodePageState extends State<AskCodePage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    var email = _emailController.text;

    if (email.isEmpty) {
      showDialogOk(
        context,
        'Email vide',
        'Veuillez entrer votre email',
      );
      return;
    }

    if (!isValidEmail(email)) {
      showDialogOk(
        context,
        'Email invalide',
        'Veuillez entrer un email valide',
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      var sent = await setLoginCode(email, false);
      if (sent) {
        showDialogOk(
          context,
          'Code de connexion',
          'Un code de connexion a été envoyé à $email',
        );

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => VerifyCodePage(email: email)),
        );
      } else {
        showDialogOk(
          context,
          'Erreur',
          'Une erreur est survenue lors de l\'envoi du code de connexion, veuillez réessayer plus tard.',
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Connexion',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Entrez votre email pour recevoir un code de connexion',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  hintText: 'Email',
                  hintStyle: const TextStyle(color: Colors.white70),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Text(
                        'Connexion',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
