import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:personal/core/colors.dart';

import 'line_painter.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomPaint(
        painter: RPSCustomPainter(color: tertiaryColor.withAlpha(32)),
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.width * 2.229665071770335),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: SizedBox.expand(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Colors.transparent
                      ],
                    ),
                  ),
                  child: SizedBox.expand(
                    child: Center(
                        child: Text(
                      'Personal',
                      style: Theme.of(context).textTheme.displayLarge,
                    ).toGradient(const LinearGradient(colors: [
                      primarColor,
                      secondaryColor,
                      tertiaryColor,
                    ]))),
                  ),
                ),
              ),
            ),
            const SignInButtons(),
            InkWell(
              onTap: () {
                context.pushNamed('signup');
              },
              child: RichText(
                text: TextSpan(
                    style: Theme.of(context).textTheme.titleSmall,
                    children: const [
                      TextSpan(
                        text: 'Don`t have an account?',
                      ),
                      TextSpan(
                        text: ' Sign up',
                        style: TextStyle(
                          color: secondaryColor,
                        ),
                      )
                    ]),
                // 'Don`t have an account?',
                // style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      )),
    );
  }
}

extension GradientText on Text {
  Widget toGradient(Gradient gradient) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: this,
    );
  }
}

class SignInButtons extends StatelessWidget {
  const SignInButtons({super.key});
  void fakeSignIn(BuildContext context) => context.pushNamed('signin');
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
                Colors.white,
              ),
              // shape: MaterialStateProperty.all(
              //   const OutlinedBorder(
              //     side: BorderSide(color: secondaryColor, width: 1),
              //   ),
              // ),
              shape: const MaterialStatePropertyAll(StadiumBorder(
                  side: BorderSide(
                color: Colors.white,
              )))),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Log in',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            OutlinedButton.icon(
              icon: const Icon(LineIcons.googleLogo),
              label: const Text('Sign in with Google '),
              onPressed: () {
                fakeSignIn(context);
              },
            ),
            OutlinedButton.icon(
              icon: const Icon(LineIcons.apple),
              label: const Text('Sign in with Apple'),
              onPressed: () {
                fakeSignIn(context);
              },
            ),
            OutlinedButton.icon(
              icon: const Icon(LineIcons.facebook),
              label: const Text('Sign in with Facebook'),
              onPressed: () {
                fakeSignIn(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
