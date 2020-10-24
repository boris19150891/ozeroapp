import 'package:building_layout_app/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Oeschinen Lake Campground',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Kandersteg, Switzerland',
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          FavoriteWidget(),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = ButtonWidget();

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
        softWrap: true,
      ),
    );
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: ListView(children: [
          Image.asset(
            'assets/lake.jpg',
            width: 600,
            height: 400,
            fit: BoxFit.cover,
          ),
          titleSection,
          buttonSection,
          textSection,
        ]),
      ),
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true;
  int _favoriteCount = 41;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}

class ButtonWidget extends StatefulWidget {
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool _call;
  bool _route;
  bool _share;

  @override
  void initState() {
    _call = true;
    _route = true;
    _share = true;
    super.initState();
  }

  void _callTap() {
    setState(() {
      _call = !_call;
    });
    some();
  }

  void _shareTap() {
    setState(() {
      _share = !_share;
    });
    Share.share('check out my website https://example.com');
    some();
  }

  void _routeTap() {
    setState(() {
      _route = !_route;
    });
    some();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapScreen()),
    );
  }


  void some() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _call = true;
        _share = true;
        _route = true;
      });
    });
  }

  _callFunc() {launch(('tel://+79187583116'));}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(
            colorFirst: Colors.blue,
            colorSecond: Colors.red,
            icon: Icons.call,
            label: 'CALL',
            func: _callTap,
            check: _call,
            s1: 40,
            s2: 20,
            l1: 50,
            l2: 70,
            funccall: _callFunc,
          ),
          _buildButtonColumn(
            colorFirst: Colors.blue,
            colorSecond: Colors.orange,
            icon: Icons.near_me,
            label: "ROUTE",
            func: _routeTap,
            check: _route,
            s1: 40,
            s2: 20,
            l1: 50,
            l2: 70,
          ),
          _buildButtonColumn(
            colorFirst: Colors.blue,
            colorSecond: Colors.yellow,
            icon: Icons.share,
            label: "SHARE",
            func: _shareTap,
            check: _share,
            s1: 40,
            s2: 20,
            l1: 50,
            l2: 70,
          ),
        ],
      ),
    );
  }

  Column _buildButtonColumn ({
    Color colorFirst,
    Color colorSecond,
    bool check,
    Function() func,
    IconData icon,
    String label,
    double s1,
    double s2,
    double l1,
    double l2,
    Function() funccall}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          width: check ? s1 : s2,
          height: check ? l1 : l2,
          duration: Duration(milliseconds: 500),
          child: IconButton(
              color: check ? colorFirst : colorSecond,
              onPressed: func,
              icon: check
                  ? Icon(icon, color: colorFirst,
              )
                  : Icon(icon, color: colorSecond)),
        ),
        RaisedButton(
          onPressed: () => {
            func(),
            funccall(),
          },
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: check ? colorFirst : colorSecond,
            ),
          ),
        ),
      ],
    );
  }
}
