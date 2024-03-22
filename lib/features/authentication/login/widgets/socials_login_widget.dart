part of '../screen/login_screen.dart';

class SocialsLoginWidget extends StatelessWidget {
  const SocialsLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Image.asset(
                  "assets/icons/facebook_icon.png",
                  width: 45,
                ),
              ),
            ),
            const Gap(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Image.asset(
                  "assets/icons/google_icon.png",
                  width: 45,
                ),
              ),
            ),
            const Gap(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
                height: 50,
                padding: EdgeInsets.all(8),
                color: Colors.white,
                child: Image.asset(
                  "assets/icons/apple_icon.png",
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        const Gap(20),
        Text(
          'OR',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
