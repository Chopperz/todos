part of '../screen/home_layout.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> with SingleTickerProviderStateMixin {
  late TabController homeBannerTabController;

  @override
  void initState() {
    homeBannerTabController = TabController(length: homeBanners.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    homeBannerTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: homeBanners.length,
          itemBuilder: (__, index, realIndex) => ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: homeBanners.elementAt(index),
              fit: BoxFit.scaleDown,
            ),
          ),
          options: CarouselOptions(
            autoPlay: true,
            height: 210,
            enableInfiniteScroll: homeBanners.length > 1,
            initialPage: 0,
            viewportFraction: 1,
            aspectRatio: 16 / 9,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() => homeBannerTabController.animateTo(index));
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: TabPageSelector(
              color: Colors.grey.shade400,
              borderStyle: BorderStyle.none,
              selectedColor: Theme.of(context).colorScheme.primary,
              controller: homeBannerTabController,
            ),
          ),
        ),
      ],
    );
  }
}
