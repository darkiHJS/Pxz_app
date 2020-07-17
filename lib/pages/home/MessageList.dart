import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';

class MessageListPage extends StatefulWidget {
  @override
  _MessageListPageState createState() => _MessageListPageState();
}

class _MessageListPageState extends State<MessageListPage> {
  List<MessageItemData> _list = [];
  int _page = 1;
  bool _isMore = true;

  Future getMessageList() async {
    var data = await PxzRequest()
        .get("/member_notify/index", data: {"page": _page, "limit": 20});
    if (data["status"] == "error") {
      return;
    }
    data["data"]["items"].forEach((e) {
      PxzRequest().post("/member_notify/read", data: {"id": e["id"]});
      _list.add(MessageItemData.fromJson(e));
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMessageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("通知"),
      ),
      body: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext contextm, int index) {
            return MessageItem(
              data: _list[index],
            );
          }),
    );
  }
}

class MessageItem extends StatelessWidget {
  final MessageItemData data;

  const MessageItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(40)),
                child: Icon(
                  Icons.volume_up,
                  color: Colors.white,
                  size: 28,
                )),
            SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "系统消息",
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "${DateTime.fromMillisecondsSinceEpoch(int.parse(data.createTime) * 1000).year}/${DateTime.fromMillisecondsSinceEpoch(int.parse(data.createTime) * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(int.parse(data.createTime) * 1000).day}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    )
                  ],
                ),
                Text(data.content),
              ],
            )),
            if (data.extend != null)
              SizedBox(
                width: 10,
              ),
            if (data.extend != null)
            Container(
              margin: EdgeInsets.only(top: 10),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(data.extend.image),
                      fit: BoxFit.cover)),
            )
          ],
        ));
  }
}

class MessageItemData {
  String id;
  String type;
  String content;
  String senderId;
  String targetId;
  String recipientId;
  String targetOwnerId;
  String targetType;
  String action;
  String createTime;
  String updateTime;
  Extend extend;

  MessageItemData(
      {this.id,
      this.type,
      this.content,
      this.senderId,
      this.targetId,
      this.recipientId,
      this.targetOwnerId,
      this.targetType,
      this.action,
      this.createTime,
      this.updateTime,
      this.extend});

  MessageItemData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    content = json['content'];
    senderId = json['sender_id'];
    targetId = json['target_id'];
    recipientId = json['recipient_id'];
    targetOwnerId = json['target_owner_id'];
    targetType = json['target_type'];
    action = json['action'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    extend =
        json['extends'] != null ? new Extend.fromJson(json['extends']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['content'] = this.content;
    data['sender_id'] = this.senderId;
    data['target_id'] = this.targetId;
    data['recipient_id'] = this.recipientId;
    data['target_owner_id'] = this.targetOwnerId;
    data['target_type'] = this.targetType;
    data['action'] = this.action;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    if (this.extend != null) {
      data['extends'] = this.extend.toJson();
    }
    return data;
  }
}

class Extend {
  String id;
  String name;
  String image;

  Extend({this.id, this.name, this.image});

  Extend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
