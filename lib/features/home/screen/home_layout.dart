import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/constants/home_constants.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/widgets/widgets.dart';
import 'package:todos_by_bloc/features/home/bloc/home_bloc.dart';

part '../widgets/home_banner.dart';

part '../widgets/home_categories.dart';

part '../widgets/home_search.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    context.read<HomeBloc>()
      ..add(const FetchCategoriesEvent())
      ..add(const FetchTopSellingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
        children: [
          HomeSearch(
            onSearch: (String search) {
              //
            },
            onFilter: () {},
          ),
          const Gap(20),
          ConstrainedBox(
            constraints: constraints.copyWith(maxHeight: 200),
            child: const HomeBanner(),
          ),
          const Gap(30),
          const HomeCategories(),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "TOP SELLING",
                style: GoogleFonts.prompt(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                  letterSpacing: .8,
                ),
              ),
              IconButton(
                onPressed: () {},
                color: Colors.grey.shade400,
                iconSize: 18,
                icon: Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
          const Gap(10),
          SizedBox(
            height: 249,
            child: BlocBuilder<HomeBloc, HomeState>(
              key: const Key("home-tops-selling"),
              buildWhen: (prev, curr) =>
                  prev.status.topSellingStatus != curr.status.topSellingStatus,
              builder: (_, state) {
                if (state.status.topSellingStatus.isInit ||
                    state.status.topSellingStatus.isProcessing) {
                  return ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, __) => ProductCard.loading(),
                    separatorBuilder: (_, __) => const Gap(10),
                    itemCount: 3,
                  );
                }

                if (state.status.topSellingStatus.isError || state.topSelling.isEmpty) {
                  return Center(
                    child: Text(
                      "Data not found",
                      style: GoogleFonts.prompt(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) => ProductCard(product: state.topSelling[i]),
                  separatorBuilder: (_, __) => const Gap(10),
                  itemCount: state.topSelling.take(10).length,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}
