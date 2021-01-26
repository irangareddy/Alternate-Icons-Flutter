
//  Constants


import 'package:flutter/foundation.dart';

final folder = 'ios/';
final assetExtension = '.png';

enum PremimumIcons { appletv, appstore, cal, calc, contacts, facetime, finder, locate, maps, memo, messages, music, news, notes, numbers, pages, photobooth, photos, safari, smarthome, stock, terminal}


List<String> getPremiumIcons(List enumEntry) {
  print(enumEntry.runtimeType);
  List<String> icons = [];
  enumEntry.forEach((name){
    print(name.toString());
    icons.add(name.toString());
  });
  return icons;
}


extension StringExtension on String {
  get asIconAsset {
    final icon = this.toString()
        .split('.')
        .last;
    final iconName = '${folder + icon + assetExtension}';
    return iconName;
  }

  get asIconName {
    return this.toString()
        .split('.')
        .last;
  }
}