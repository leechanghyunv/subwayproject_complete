import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../custom/TextFrame.dart';

class DialogDesign extends StatelessWidget {

  String qrdata = '1234ffov3pp5oq23lk';

  late final String designText;

  DialogDesign({
    required this.designText,
  });



  @override
  Widget build(BuildContext context) {

    double appHeight = MediaQuery.of(context).size.height; /// 896.0 IPHONE11

    return Container(

      child: Row(
        children: [
          Container(
            width: appHeight * 0.0903,  /// 80 /// 0.893
            height: appHeight * 0.0903,
            child: QrImageView(
              data: qrdata,
            ),
          ),
          SizedBox(
            width: appHeight * 0.020,
          ),   ///appHeight * 0.0280

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              TextFrame(
                comment: '${designText}',
                overflow: TextOverflow.ellipsis,
              ),
              ///
              TextFrame(
                comment: DateFormat('y-MM-dd EEE \na HH:mm:ss').
                format(DateTime.now()),),
            ],
          ),

        ],
      ),
    );
  }
}