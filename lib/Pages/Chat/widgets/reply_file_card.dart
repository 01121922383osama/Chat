import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';

class ReplyFileCard extends StatelessWidget {
  const ReplyFileCard(
      {super.key,
      required this.path,
      required this.message,
      required this.time});
  final String path;
  final String message;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.grey[300],
          ),
          child: Card(
            // margin: const EdgeInsets.all(3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.grey[300],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: InteractiveViewer(
                  panAxis: PanAxis.free,
                  child: FullScreenWidget(
                    disposeLevel: DisposeLevel.Medium,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://fair-typhoon-event.glitch.me/uploads/$path'),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                  ),
                )
                    //  Image.network(
                    //   'http://192.168.1.33:5000/uploads/$path',
                    //   fit: BoxFit.fitHeight,
                    // ),
                    ),
                message.isNotEmpty
                    ? Container(
                        height: 48,
                        padding: const EdgeInsets.only(
                          left: 15,
                          top: 8,
                        ),
                        child: Text(
                          message,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
