import 'package:flutter/material.dart';

class KartuAbsen extends StatefulWidget {
  KartuAbsen({Key? key}) : super(key: key);

  @override
  _BackdropPageState createState() => new _BackdropPageState();
}

class _BackdropPageState extends State<KartuAbsen>
    with SingleTickerProviderStateMixin {
  static const _PANEL_HEADER_HEIGHT = 10.0;

  AnimationController? _controller;

  bool get _isPanelVisible {
    final AnimationStatus status = _controller!.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 100), value: 0.0, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  Animation<RelativeRect> _getPanelAnimation(BoxConstraints constraints) {
    final double height = constraints.biggest.height;
    final double top = height - _PANEL_HEADER_HEIGHT;
    final double bottom = -_PANEL_HEADER_HEIGHT;
    return new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(0.0, top, 0.0, bottom),
      end: new RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(new CurvedAnimation(
        parent: _controller!,
        curve: Curves.linear,
        reverseCurve: Curves.bounceOut));
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Animation<RelativeRect> animation = _getPanelAnimation(constraints);
    final ThemeData theme = Theme.of(context);
    return new Container(
      color: theme.primaryColor,
      child: Column(
        children: [
          main_container("Dr. Sobari MM", "ada"),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return buildListItem(index.toString());
                    },
                    itemCount: 20,
                  ),
                ),
                new PositionedTransition(
                  rect: animation,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: new Material(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: const Radius.circular(16.0),
                          topRight: const Radius.circular(16.0)),
                      elevation: 12.0,
                      child: new Column(children: <Widget>[
                        new Container(
                          height: 100,
                          child: Column(
                            children: [
                              new IconButton(
                                onPressed: () {
                                  _controller?.fling(
                                      velocity: _isPanelVisible ? -1.0 : 1.0);
                                },
                                icon: new AnimatedIcon(
                                  icon: AnimatedIcons.close_menu,
                                  progress: _controller!.view,
                                ),
                              ),
                              new Center(child: new Text("panel")),
                            ],
                          ),
                        ),
                        new Expanded(
                            child: new Center(child: new Text("content")))
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Color.fromARGB(220, 79, 158, 223),
          elevation: 0.0,
          title: new Text(
            "Cetak Kartu Absen",
            style: TextStyle(color: Colors.white),
          )),
      body: new LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }

  Widget buildListItem(String item) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(
            item,
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text("Jadwal"),
        trailing: IconButton(
          icon: Icon(Icons.add), // Gantilah dengan ikon yang diinginkan
          onPressed: () {
            _controller?.fling(velocity: _isPanelVisible ? -1.0 : 1.0);
          },
        ),
      ),
    );
  }

  Container main_container(getusername, username) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 100,
      height: 130,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35.0),
          bottomRight: Radius.circular(35.0),
        ),
        color: Color.fromARGB(220, 79, 158, 223),
      ),
      child: Column(
        children: [
          SizedBox(height: 32),
          Text(getusername,
              style: TextStyle(color: Colors.white, fontSize: 20)),
          Text(username, style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}
