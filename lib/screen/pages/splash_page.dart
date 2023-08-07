part of './pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      context.pushAndRemoveUntil(const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 50, right: 50),
        child: Center(
          child: Container(
            width: context.width * 1,
            height: 60,
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('assets/logo_all.png'))),
          ),
        ),
      ),
    );
  }
}
