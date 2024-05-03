import 'package:flutter/material.dart';

import 'package:puzzle/ui/app/theme_provider.dart';

class SvgModify {
  static hintSvg(Color color, {bool? isWhite}) {
    String path =
        "<svg width=\"20\" height=\"20\" viewBox=\"0 0 20 20\" fill=\"none\" xmlns=\"http://www.w3.org/2000/svg\"><path d=\"M11.5431 15.8285H8.45565C8.42756 14.7077 7.95828 13.6425 7.14866 12.865C5.9899 11.712 5.63951 9.97427 6.26127 8.46208C6.8836 6.9485 8.35705 5.95942 9.99353 5.95669C10.1545 5.95674 10.3152 5.96586 10.475 5.98403C12.3267 6.20701 13.7875 7.66454 14.0146 9.51587C14.1675 10.7705 13.7226 12.0243 12.813 12.9019L12.812 12.9028C12.0181 13.6723 11.5623 14.7246 11.5431 15.8285Z\" stroke=\"black\" stroke-width=\"1.2\"/><mask id=\"path-2-inside-1_1660_52275\" fill=\"white\"><path d=\"M9.99945 19.9999C10.4534 19.9994 10.8579 19.7134 11.0097 19.2856H8.98926C9.14105 19.7134 9.54555 19.9994 9.99945 19.9999Z\"/></mask><path d=\"M9.99945 19.9999L9.99833 20.9999L10.0006 20.9999L9.99945 19.9999ZM11.0097 19.2856L11.9521 19.6201L12.4258 18.2856H11.0097V19.2856ZM8.98926 19.2856V18.2856H7.57331L8.04683 19.6201L8.98926 19.2856ZM10.0006 20.9999C10.8775 20.999 11.6588 20.4464 11.9521 19.6201L10.0673 18.9511C10.0569 18.9804 10.0293 18.9999 9.99833 18.9999L10.0006 20.9999ZM11.0097 18.2856H8.98926V20.2856H11.0097V18.2856ZM8.04683 19.6201C8.34007 20.4464 9.12147 20.999 9.99833 20.9999L10.0006 18.9999C9.96963 18.9999 9.94204 18.9804 9.93168 18.9512L8.04683 19.6201Z\" fill=\"black\" mask=\"url(#path-2-inside-1_1660_52275)\"/><path d=\"M11.2853 18.0714H8.71387V17.6428H11.2853V18.0714Z\" stroke=\"black\"/><path d=\"M10.2147 2.5C10.2147 2.61835 10.1188 2.7143 10.0004 2.7143C9.88208 2.7143 9.78613 2.61835 9.78613 2.5V0.714297C9.78613 0.595947 9.88208 0.5 10.0004 0.5C10.1188 0.5 10.2147 0.595948 10.2147 0.714297V2.5Z\" stroke=\"#FCBB10\"/><path d=\"M4.62855 4.32538L4.62857 4.3254C4.66874 4.36556 4.69133 4.42007 4.69133 4.47691C4.69133 4.53188 4.6702 4.58467 4.63249 4.6244C4.54394 4.7049 4.40833 4.70453 4.32021 4.6233L3.06283 3.3658L3.06276 3.36573C3.02255 3.32553 3 3.27108 3 3.2143C3 3.15747 3.02258 3.10302 3.06271 3.06291L3.06286 3.06276C3.10305 3.02256 3.15754 3 3.2143 3C3.27107 3 3.32552 3.02257 3.36564 3.06271L3.36578 3.06284L4.62855 4.32538Z\" stroke=\"#FCBB10\"/><path d=\"M2.5 9.78564C2.61835 9.78564 2.7143 9.88159 2.7143 9.99994C2.7143 10.1183 2.61835 10.2142 2.5 10.2142H0.71462C0.596284 10.214 0.500385 10.1182 0.500001 9.99994C0.500385 9.88165 0.596284 9.78585 0.71462 9.78564H2.5Z\" stroke=\"#FCBB10\"/><path d=\"M4.32538 15.3714L4.32604 15.3707C4.38015 15.3164 4.45912 15.2951 4.53321 15.3149C4.60724 15.3347 4.66515 15.3926 4.68496 15.4667L5.16801 15.3376L4.68496 15.4667C4.70475 15.5407 4.68349 15.6197 4.62913 15.6739L4.62851 15.6745L3.37091 16.9319C3.28287 17.0131 3.14733 17.0135 3.05886 16.933C3.02109 16.8933 3 16.8405 3 16.7856C3 16.7288 3.02258 16.6743 3.06271 16.6342L3.06284 16.6341L4.32538 15.3714Z\" stroke=\"#FCBB10\"/><path d=\"M15.6738 15.3707L15.6738 15.3707L15.6745 15.3714L16.937 16.634L16.9371 16.6341C16.9773 16.6743 16.9999 16.7287 16.9999 16.7855C16.9999 16.8405 16.9787 16.8932 16.941 16.9329C16.8526 17.0134 16.717 17.0131 16.629 16.9318L15.3714 15.6744L15.3714 15.6744L15.3707 15.6738C15.3164 15.6197 15.2951 15.5407 15.3149 15.4666C15.3347 15.3925 15.3925 15.3347 15.4666 15.3149C15.5407 15.2951 15.6197 15.3164 15.6738 15.3707Z\" stroke=\"#FCBB10\"/><path d=\"M17.5004 9.78564H19.2861C19.4045 9.78564 19.5004 9.88159 19.5004 9.99994C19.5004 10.1183 19.4045 10.2142 19.2861 10.2142H17.5004C17.3821 10.2142 17.2861 10.1183 17.2861 9.99994C17.2861 9.88159 17.3821 9.78564 17.5004 9.78564Z\" stroke=\"#FCBB10\"/><path d=\"M16.9371 3.36573L16.9371 3.36576L15.6797 4.6233C15.5917 4.70448 15.4561 4.70491 15.3674 4.62435C15.3297 4.58462 15.3086 4.53183 15.3086 4.47686C15.3086 4.42002 15.3312 4.3655 15.3714 4.32535L15.3714 4.32532L16.6341 3.06278L16.6341 3.06276C16.6883 3.00864 16.7671 2.98751 16.841 3.00732C16.915 3.02714 16.9727 3.08487 16.9925 3.15883C17.0124 3.23275 16.9912 3.31161 16.9371 3.36573Z\" stroke=\"#FCBB10\"/></svg>";
    var hexCode = '#${color.value.toRadixString(16).substring(2, 8)}';
    String newPath = path.replaceAll("#FCBB10", hexCode);
    if (color == Colors.white ||
        themeMode == ThemeMode.dark && isWhite == null) {
      newPath = newPath.replaceAll("black", 'white');
    }
    return newPath;
  }
}
