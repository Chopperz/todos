import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todos_by_bloc/core/extensions/src/context.dart';
import 'package:todos_by_bloc/core/widgets/widgets.dart';

class HomeInitial extends StatelessWidget {
  const HomeInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      key: const Key("app-layout-initialize-screen"),
      title: "Todos",
      appBarBackgroundColor: context.theme.scaffoldBackgroundColor,
      centerTitle: false,
      actions: [
        CircleAvatar(
          radius: 20,
          child: ShimmerView.circle(width: 30, height: 30),
        ),
      ],
      body: LayoutBuilder(builder: (_, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
          child: Column(
            children: [
              ConstrainedBox(
                constraints: constraints.copyWith(maxHeight: 200),
                child: ShimmerView.rect(
                  width: constraints.maxWidth,
                  height: 200,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const Gap(20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(7, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ShimmerView.circle(width: 30, height: 30),
                          const Gap(5),
                          ShimmerView.rect(
                            width: 7,
                            height: 3,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              const Gap(20),
            ],
          ),
        );
      }),
    );
  }
}
