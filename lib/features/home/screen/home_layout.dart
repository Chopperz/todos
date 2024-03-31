import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todos_by_bloc/core/constants/home_constants.dart';
import 'package:todos_by_bloc/core/extensions/src/context.dart';
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
    context.read<HomeBloc>().add(const FetchCategoriesEvent());
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
          const Gap(20),
          const HomeCategories(),
          const Gap(20),
          Text(
            "Tops",
            style: GoogleFonts.prompt(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      );
    });
  }
}
