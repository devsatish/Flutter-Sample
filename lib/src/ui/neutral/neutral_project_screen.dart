import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NeutralProjectScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () => _launchURL(),
            child: Container(
              width: 100,
              height: 100,
              child: Image.asset(
                "assets/images/neutral_logo.png",
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 20,
          ),
          Text(
            "Neutral Project. \n A Superior Digital Dollar",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  _launchURL() async {
    const url = 'https://github.com/devsatish/flutterdemo';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
