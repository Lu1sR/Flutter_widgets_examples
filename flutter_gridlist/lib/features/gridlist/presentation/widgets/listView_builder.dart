import 'package:flutter/material.dart';
import 'package:flutter_gridlist/features/gridlist/domain/entities/articles_entity.dart';
import 'package:flutter_gridlist/features/gridlist/presentation/widgets/gridlist_display.dart';

class NewsListView extends StatefulWidget {
  final List<Article> newsData;

  const NewsListView({Key key, this.newsData}) : super(key: key);
  @override
  _NewsListViewState createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: ListView.builder(
        itemCount: widget.newsData.length,
        padding: const EdgeInsets.only(top: 8),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          final int count =
              widget.newsData.length > 10 ? 10 : widget.newsData.length;
          final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animationController,
                  curve: Interval((1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn)));
          animationController.forward();
          return ArticleListViewItem(
            callback: () {},
            newsData: widget.newsData[index],
            animation: animation,
            animationController: animationController,
          );
        },
      ),
    );
  }
}
