import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_contact_button.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:self_project/provider/provider_user.dart';

class MyProfileFragment extends ConsumerStatefulWidget {
  const MyProfileFragment({super.key});

  @override
  ConsumerState<MyProfileFragment> createState() => _MyProfileFragmentState();
}

class _MyProfileFragmentState extends ConsumerState<MyProfileFragment>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 3, vsync: this);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userCredentialProvider);
    return Column(
        //appBar: const ProfileAppBar(),
        children: [
          AppBar(
            backgroundColor: context.appColors.backgroundColor,
            scrolledUnderElevation: 0,
            toolbarHeight: appBarHeight,
          ),
          Expanded(
            child: CustomScrollView(
              //physics: const ClampingScrollPhysics(),
              slivers: [
                _ProfileBox(
                  user: user!,
                ),
                SliverStickyHeader(
                  header: Container(
                    color: context.appColors.backgroundColor,
                    height: 60,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TabBar(
                            onTap: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            controller: tabController,
                            labelStyle: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500),
                            labelColor: context.appColors.primaryText,
                            unselectedLabelColor:
                                context.appColors.secondaryText,
                            labelPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            indicatorColor: context.appColors.iconButton,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            tabs: const [
                              Text('소개'),
                              Text('경력'),
                              Text('평가'),
                            ],
                          ),
                          const Line(),
                        ]),
                  ),
                  sliver: const SliverToBoxAdapter(
                    child: Column(
                      children: [Placeholder(), Placeholder()],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}

class _ProfileBox extends StatelessWidget {
  final UserCredential user;
  const _ProfileBox({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          IntrinsicHeight(
            //delete this widget if possible
            child: Container(
              color: context.appColors.backgroundColor,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text('${user.user?.email}')
              ),
            ),
          ),
        ],
      ),
    );
  }
}
