
import 'package:clima/utilities/constants.dart';
import 'package:flutter/cupertino.dart';

class DetailsWidget extends StatelessWidget {
  final String title , value;
  const DetailsWidget({required this.title ,required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: kDetailesTextStyle,
            ),
            Visibility(
                visible: title == 'WIND' ? true : false,
                child: Text(' km/hr',style:kDetailsSuffixTextStyle,)),
          ],
        ),
        Text(
          title,
          style: kDetailsTitleTextStyle,
        ),
      ],
    );
  }
}
