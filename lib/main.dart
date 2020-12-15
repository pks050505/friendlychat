import 'package:flutter/material.dart';
import 'src/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Article> _article = article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          setState(() {
            _article.removeAt(0);
          });
          return;
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 8),
          physics: BouncingScrollPhysics(),
          children: _article.map(_buildItem).toList(),
        ),
      ),
    );
  }

  Widget _buildItem(Article article) {
    // if (article.text.startsWith('This')) return null;
    return Card(
      child: ExpansionTile(
        childrenPadding: EdgeInsets.all(8),
        expandedAlignment: Alignment.centerLeft,
        tilePadding: EdgeInsets.all(8),
        title: Text(
          article.text,
          style: TextStyle(
            fontSize: 24,
          ),
        ),

        // leading: Text(article.age),
        // trailing: Text("${article.commentsCount} comments"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${article.commentsCount} Comments",
                style: Theme.of(context).textTheme.caption,
              ),
              IconButton(
                // child: Text(
                //   'Open',
                //   style: Theme.of(context).textTheme.bodyText1,
                // ),
                icon: Icon(Icons.launch),

                onPressed: () async {
                  final fakeUrl = "https://${article.domain}";
                  if (await canLaunch(fakeUrl)) {
                    launch(fakeUrl);
                  } else {
                    throw "${article.domain}";
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
