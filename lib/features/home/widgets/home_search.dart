part of '../screen/home_layout.dart';

class HomeSearch extends StatelessWidget {
  const HomeSearch({
    super.key,
    this.onSearch,
    this.onFilter,
  });

  final void Function(String)? onSearch;
  final void Function()? onFilter;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(
          width: context.mediaQuery.size.width - (30 + 40 + 10),
          height: 40,
          child: TextFormField(
            style: GoogleFonts.prompt(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade100),
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: Icon(Icons.search),
              hintText: "Search for Shops",
              hintStyle: GoogleFonts.prompt(
                color: Colors.grey.shade500,
                fontWeight: FontWeight.normal,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 10),
            ),
            // cursorHeight: 20,
            onChanged: onSearch,
          ),
        ),
        const Gap(10),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: context.theme.colorScheme.primary,
            border: Border.all(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(8),
          ),
          child: IconButton(
            onPressed: onFilter,
            style: ButtonStyle(),
            padding: EdgeInsets.zero,
            iconSize: 20,
            icon: const FaIcon(FontAwesomeIcons.sliders, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
