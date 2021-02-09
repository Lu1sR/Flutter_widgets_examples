import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gridlist/features/gridlist/presentation/bloc/gridlist_bloc.dart';
import 'package:flutter_gridlist/features/gridlist/presentation/widgets/listView_builder.dart';
import 'package:flutter_gridlist/features/gridlist/presentation/widgets/loading_widget.dart';
import 'package:flutter_gridlist/features/gridlist/presentation/widgets/message_display.dart';

import '../../../../injection_container.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<GridlistBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => sl.get<GridlistBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<GridlistBloc, GridlistState>(
                builder: (context, state) {
                  if (state is GridlistLoading) {
                    return LoadingWidget();
                  } else if (state is GridlistLoaded) {
                    return NewsListView(
                      newsData: state.articles,
                    );
                  } else if (state is GridlistError) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  } else if (state is GridlistInitial) {
                    return Container(
                      child: Text("State initial"),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Btn()
            ],
          ),
        ),
      ),
    );
  }
}

class Btn extends StatefulWidget {
  @override
  _BtnState createState() => _BtnState();
}

class _BtnState extends State<Btn> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        BlocProvider.of<GridlistBloc>(context).add(GetArticlesEvent("us"));
      },
      child: Text("Buttom"),
    );
  }
}
