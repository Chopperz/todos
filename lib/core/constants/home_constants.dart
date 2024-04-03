import 'package:flutter/material.dart';

class HomeBottomBarProps {
  final String label;
  final Widget icon;

  const HomeBottomBarProps({
    required this.label,
    required this.icon,
  });
}

const menuList = <HomeBottomBarProps>[
  HomeBottomBarProps(
    label: "Home",
    icon: Icon(Icons.home),
  ),
  HomeBottomBarProps(
    label: "Favorites",
    icon: Icon(Icons.favorite),
  ),
];

const homeBanners = <String>[
  "https://img.freepik.com/free-psd/sales-horizontal-banner-template_23-2148912910.jpg",
  "https://img.freepik.com/free-photo/photocomposition-horizontal-shopping-banner-with-woman-big-smartphone_23-2151201773.jpg",
  "https://static.vecteezy.com/system/resources/thumbnails/002/058/986/small_2x/online-shopping-store-on-website-and-mobile-phone-design-smart-business-marketing-concept-horizontal-view-illustration-free-vector.jpg",
];
