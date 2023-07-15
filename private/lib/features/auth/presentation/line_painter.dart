// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// //Add this CustomPaint widget to the Widget Tree
// CustomPaint(
//     size = Size(WIDTH, (WIDTH*2.229665071770335).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
//     painter = RPSCustomPainter(),
// )

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  final Color color;
  RPSCustomPainter({
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.01435407, size.height * 0.4781330);
    path_0.lineTo(size.width * -0.01435407, size.height * -0.003894185);
    path_0.lineTo(size.width * 0.2703349, size.height * -0.04572961);
    path_0.lineTo(size.width * 0.2703349, size.height * 0.4362972);
    path_0.lineTo(size.width * -0.01435407, size.height * 0.4781330);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004784689;
    paint0Stroke.color = color;
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * -0.01435407, size.height * 1.040365);
    path_1.lineTo(size.width * -0.01435407, size.height * 0.5583380);
    path_1.lineTo(size.width * 0.2703349, size.height * 0.5165021);
    path_1.lineTo(size.width * 0.2703349, size.height * 0.9985290);
    path_1.lineTo(size.width * -0.01435407, size.height * 1.040365);
    path_1.close();

    Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004784689;
    paint1Stroke.color = color;
    canvas.drawPath(path_1, paint1Stroke);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.3516746, size.height * 0.1250826);
    path_2.lineTo(size.width * 0.3516746, size.height * -0.3569217);
    path_2.lineTo(size.width * 0.6100478, size.height * -0.3986878);
    path_2.lineTo(size.width * 0.6100478, size.height * 0.08331706);
    path_2.lineTo(size.width * 0.3516746, size.height * 0.1250826);
    path_2.close();

    Paint paint2Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004784689;
    paint2Stroke.color = color;
    canvas.drawPath(path_2, paint2Stroke);

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3588517, size.height * 1.250622);
    path_3.lineTo(size.width * 0.3588517, size.height * 0.7686148);
    path_3.lineTo(size.width * 0.6172249, size.height * 0.7268487);
    path_3.lineTo(size.width * 0.6172249, size.height * 1.208852);
    path_3.lineTo(size.width * 0.3588517, size.height * 1.250622);
    path_3.close();

    Paint paint3Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004784689;
    paint3Stroke.color = color;
    canvas.drawPath(path_3, paint3Stroke);

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_3, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.7392344, size.height * 0.8943712);
    path_4.lineTo(size.width * 0.7392344, size.height * 0.4123788);
    path_4.lineTo(size.width * 0.9856459, size.height * 0.3706502);
    path_4.lineTo(size.width * 0.9856459, size.height * 0.8526427);
    path_4.lineTo(size.width * 0.7392344, size.height * 0.8943712);
    path_4.close();

    Paint paint4Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004784689;
    paint4Stroke.color = color;
    canvas.drawPath(path_4, paint4Stroke);

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_4, paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.7296651, size.height * 0.3460601);
    path_5.lineTo(size.width * 0.7296651, size.height * -0.1359174);
    path_5.lineTo(size.width * 0.9641148, size.height * -0.1776052);
    path_5.lineTo(size.width * 0.9641148, size.height * 0.3043723);
    path_5.lineTo(size.width * 0.7296651, size.height * 0.3460601);
    path_5.close();

    Paint paint5Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004784689;
    paint5Stroke.color = color;
    canvas.drawPath(path_5, paint5Stroke);

    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_5, paint5Fill);

    Path path_6 = Path();
    path_6.moveTo(size.width * 0.7511962, size.height * 1.471620);
    path_6.lineTo(size.width * 0.7511962, size.height * 0.9896320);
    path_6.lineTo(size.width * 0.9976077, size.height * 0.9479034);
    path_6.lineTo(size.width * 0.9976077, size.height * 1.429893);
    path_6.lineTo(size.width * 0.7511962, size.height * 1.471620);
    path_6.close();

    Paint paint6Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004784689;
    paint6Stroke.color = color;
    canvas.drawPath(path_6, paint6Stroke);

    Paint paint6Fill = Paint()..style = PaintingStyle.fill;
    paint6Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_6, paint6Fill);

    Path path_7 = Path();
    path_7.moveTo(size.width * 0.3516746, size.height * 0.6755118);
    path_7.lineTo(size.width * 0.3516746, size.height * 0.1935075);
    path_7.lineTo(size.width * 0.6100478, size.height * 0.1517414);
    path_7.lineTo(size.width * 0.6100478, size.height * 0.6337468);
    path_7.lineTo(size.width * 0.3516746, size.height * 0.6755118);
    path_7.close();

    Paint paint7Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.004784689;
    paint7Stroke.color = color;
    canvas.drawPath(path_7, paint7Stroke);

    Paint paint7Fill = Paint()..style = PaintingStyle.fill;
    paint7Fill.color = const Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_7, paint7Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
