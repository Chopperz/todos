part of '../screen/home_layout.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FontAwesomeIcons.mobile,
          FontAwesomeIcons.shirt,
          FontAwesomeIcons.shoePrints,
          FontAwesomeIcons.couch,
          FontAwesomeIcons.motorcycle,
          FontAwesomeIcons.icons,
        ].map<Widget>((category) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              onTap: () {
                //
              },
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor:
                    Colors.primaries.elementAt(Random().nextInt(Colors.primaries.length)),
                    radius: 30,
                    child: FaIcon(
                      category,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(5),
                  Text(
                    getCategoryName(category),
                    style: GoogleFonts.prompt(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  String getCategoryName(IconData icon) {
    late String name;

    switch (icon) {
      case FontAwesomeIcons.mobile:
        name = "Mobile";
        break;
      case FontAwesomeIcons.shirt:
        name = "Fashion";
        break;
      case FontAwesomeIcons.shoePrints:
        name = "Shoes";
        break;
      case FontAwesomeIcons.motorcycle:
        name = "Motorcycle";
        break;
      case FontAwesomeIcons.couch:
        name = "Furniture";
        break;
      default:
        name = "More";
    }

    return name;
  }
}
