import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{

  TabController tabController;
  var fabIcon = Icons.message;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 4)
      ..addListener(() {
      setState(() {
        switch(tabController.index) {
          case 0:
            break;
          case 1:
            fabIcon = Icons.message;
            break;
          case 2:
            fabIcon = Icons.camera_enhance;
            break;
          case 3:
            fabIcon = Icons.call;
            break;
        }
      });
      });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //////////////////////////////////////////////////////////////////////
      appBar: new AppBar(
        title: new Text("WhatsApp X", style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w600),),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Icon(Icons.search),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(Icons.more_vert),
          ),
        ],
        backgroundColor: Colors.black,

        bottom: TabBar(
          tabs: [
            Tab(icon: Icon(Icons.camera_alt),),
            Tab(child: Text("CHATS"),),
            Tab(child: Text("STATUS",)),
            Tab(child: Text("CALLS",)),
          ], indicatorColor: Colors.cyanAccent,
          controller: tabController,
        ),
      ),

      /////////////////////////////////////////////////////////////////////////
      body: TabBarView(
        controller: tabController,
        children: [
          Icon(Icons.camera_alt),
            ListView.builder(
            itemBuilder: (context, position) {
              ChatItemModel chatItem = ChatHelper.getChatItem(position);

              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.account_circle,
                          size: 64.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      chatItem.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20.0),
                                    ),
                                    Text(
                                      chatItem.messageDate,
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: Text(
                                    chatItem.mostRecentMessage,
                                    style: TextStyle(
                                        color: Colors.black45, fontSize: 16.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            }),
          Text("Status Screen"),
          Text("Call Screen"),
        ],

      ),


///////////////////////////////////////////////////////////////////////////////
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(fabIcon),
        backgroundColor: Colors.black,
      ),
    );
  }
}

class ChatItemModel {

  String name;
  String mostRecentMessage;
  String messageDate;

  ChatItemModel(this.name, this.mostRecentMessage, this.messageDate);

}

class ChatHelper {

  static var chatList = [ChatItemModel("Tia", "Lunch in the evening?", "Now"),ChatItemModel("Karan", "Sure", "Today"),ChatItemModel("Ritu", "Meet this week?", "Yesterday"),
  ChatItemModel("Rajesh", "Received!", "Yesterday"),ChatItemModel("Ariana", "I'll come too!", "Yesterday")];

  static ChatItemModel getChatItem(int position) {
    return chatList[position];
  }

  static var itemCount = chatList.length;

}