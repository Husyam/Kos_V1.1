part of '../app_router.dart';

enum RootTab {
  home('0'),
  maps('1'),
  like('2'),
  account('3'),
  search('4'),
  cart('5');
  // dataDiri('5'),

  final String value;
  const RootTab(this.value);

  factory RootTab.fromIndex(int index) {
    return values.firstWhere(
      (value) => value.value == '$index',
      orElse: () => RootTab.home,
    );
  }
}
