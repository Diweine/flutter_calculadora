import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

const Color colorDark = Color(0xFF374352);
const Color colorText1 = Color(0xFFFFFFFF);
const Color colorText2 = Color(0xFF58C6F7);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String sum = "0", res = "0", exp1 = "";
  double fontsize1 = 35, fontsize2 = 45;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: colorDark,
        body: SafeArea(
          top: true,
          bottom: true,
          right: true,
          left: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  right: 20.0,
                  bottom: 10.0,
                  left: 20.0,
                ),
                child: Text(
                  res,
                  style: TextStyle(color: colorText1, fontSize: fontsize2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                  right: 20.0,
                  bottom: 15.0,
                  left: 20.0,
                ),
                child: Text(
                  sum,
                  style: TextStyle(color: colorText2, fontSize: fontsize1),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  botton("AC", colorText2, colorDark, w * 0.2),
                  botton("%", colorText2, colorDark, w * 0.2),
                  botton("÷", colorText2, colorDark, w * 0.2),
                  botton("C", colorText2, colorDark, w * 0.2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  botton("7", colorText1, colorDark, w * 0.2),
                  botton("8", colorText1, colorDark, w * 0.2),
                  botton("9", colorText1, colorDark, w * 0.2),
                  botton("×", colorText2, colorDark, w * 0.2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  botton("4", colorText1, colorDark, w * 0.2),
                  botton("5", colorText1, colorDark, w * 0.2),
                  botton("6", colorText1, colorDark, w * 0.2),
                  botton("-", colorText2, colorDark, w * 0.2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  botton("1", colorText1, colorDark, w * 0.2),
                  botton("2", colorText1, colorDark, w * 0.2),
                  botton("3", colorText1, colorDark, w * 0.2),
                  botton("+", colorText2, colorDark, w * 0.2),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  botton("0", colorText1, colorDark, w * 0.45),
                  botton(".", colorText1, colorDark, w * 0.2),
                  botton("=", colorText2, colorDark, w * 0.2),
                ],
              ),
              SizedBox(
                height: 15,
              )
            ],
          ),
        ));
  }

  // here will make botton design widget
  Widget botton(String text, Color fontcolor, Color _color, double w1) {
    double h = MediaQuery.of(context).size.height;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (text == "=") {
          try {
            exp1 = sum;
            exp1 = exp1.replaceAll("×", "*");
            exp1 = exp1.replaceAll("÷", "/");
            Parser P = Parser();
            Expression exp2 = P.parse(exp1);
            ContextModel con = ContextModel();
            res = "${exp2.evaluate(EvaluationType.REAL, con)}";
            fontsize2 = 45;
            fontsize1 = 35;
            setState(() {});
          } catch (e) {
            fontsize2 = 45;
            fontsize1 = 35;
            res = "ERRO";
            setState(() {});
          }
        } else if (text == "AC") {
          fontsize2 = 45;
          fontsize1 = 35;
          sum = "0";
          res = "0";
          setState(() {});
        } else if (text == "C") {
          fontsize2 = 35;
          fontsize1 = 45;
          if (sum.length == 1) {
            sum = "0";
            setState(() {});
          } else {
            sum = sum.substring(0, sum.length - 1);
            setState(() {});
          }
        } else {
          fontsize2 = 35;
          fontsize1 = 45;
          if (sum == "0") {
            sum = text;
            setState(() {});
          } else {
            sum += text;
            setState(() {});
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 18),
        alignment: Alignment.center,
        height: h * 0.09,
        width: w1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          color: _color,
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
                color: Colors.blueGrey.shade700,
                offset: Offset(-4.0, -4.0),
                blurRadius: 15.0,
                spreadRadius: 1.0)
          ],
        ),
        child: Text(
          text,
          style: TextStyle(color: fontcolor, fontSize: 30),
        ),
      ),
    );
  }
}
