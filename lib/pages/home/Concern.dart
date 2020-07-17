import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/utils/Request.dart';
import './components/ConcernItem.dart';

class ConcernPage extends StatefulWidget {
  ConcernPage({Key key}) : super(key: key);

  @override
  _ConcernPageState createState() => _ConcernPageState();
}

class _ConcernPageState extends State<ConcernPage> {
  int _page = 1;
  bool _isMore = true;
  List<ConcernData> _list = [];

  Future getConcernList() async {
    var data = await PxzRequest().get(
      "/member_friends/index",
      data: {
        "page": _page,
        "limit": 20
      }); 
    if(data["status"] == "error") {
      BotToast.showText(text: data["msg"]);
      return;
    }
    var list = data["data"]["items"];
    if(list.length < 20) _isMore = false;
    list.forEach((e) {
      _list.add(ConcernData.fromJson(e));
    });
    if (this.mounted) {
      setState(() {});
    }
  }
  
  @override
  void initState() {
    super.initState();
    getConcernList();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              if(index%20 == 0 && _isMore) {
                getConcernList();
                return Container();
              }
              return ConcernItem(data: _list[index],);
           },
          ),
        );
  }
}

class ConcernData {
	String id;
	String title;
	String linkVideo;
	String mainDefaultId;
	String marketable;
	String createTime;
	String likeNum;
	String collectNum;
	String updateTime;
	String commentCount;
	String shareCount;
	String readCount;
	String pushTime;
	String memberId;
	String resourceType;
	String type;
	String reportNum;
	String weightNum;
	String status;
	String desc;
	String nickname;
	String avatar;
	List<Resource> resource;

	ConcernData({this.id, this.title, this.linkVideo, this.mainDefaultId, this.marketable, this.createTime, this.likeNum, this.collectNum, this.updateTime, this.commentCount, this.shareCount, this.readCount, this.pushTime, this.memberId, this.resourceType, this.type, this.reportNum, this.weightNum, this.status, this.desc, this.nickname, this.avatar, this.resource});

	ConcernData.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
		linkVideo = json['link_video'];
		mainDefaultId = json['main_default_id'];
		marketable = json['marketable'];
		createTime = json['create_time'];
		likeNum = json['like_num'];
		collectNum = json['collect_num'];
		updateTime = json['update_time'];
		commentCount = json['comment_count'];
		shareCount = json['share_count'];
		readCount = json['read_count'];
		pushTime = json['push_time'];
		memberId = json['member_id'];
		resourceType = json['resource_type'];
		type = json['type'];
		reportNum = json['report_num'];
		weightNum = json['weight_num'];
		status = json['status'];
		desc = json['desc'];
		nickname = json['nickname'];
		avatar = json['avatar'];
		if (json['resource'] != null) {
			resource = new List<Resource>();
			json['resource'].forEach((v) { resource.add(new Resource.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		data['link_video'] = this.linkVideo;
		data['main_default_id'] = this.mainDefaultId;
		data['marketable'] = this.marketable;
		data['create_time'] = this.createTime;
		data['like_num'] = this.likeNum;
		data['collect_num'] = this.collectNum;
		data['update_time'] = this.updateTime;
		data['comment_count'] = this.commentCount;
		data['share_count'] = this.shareCount;
		data['read_count'] = this.readCount;
		data['push_time'] = this.pushTime;
		data['member_id'] = this.memberId;
		data['resource_type'] = this.resourceType;
		data['type'] = this.type;
		data['report_num'] = this.reportNum;
		data['weight_num'] = this.weightNum;
		data['status'] = this.status;
		data['desc'] = this.desc;
		data['nickname'] = this.nickname;
		data['avatar'] = this.avatar;
		if (this.resource != null) {
      data['resource'] = this.resource.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Resource {
	String url;
	String type;
	Extend extend;
	String md5;

	Resource({this.url, this.type, this.extend, this.md5});

	Resource.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		type = json['type'];
		extend = json['extends'] != null ? new Extend.fromJson(json['extends']) : null;
		md5 = json['md5'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url'] = this.url;
		data['type'] = this.type;
		if (this.extend != null) {
      data['extends'] = this.extend.toJson();
    }
		data['md5'] = this.md5;
		return data;
	}
}

class Extend {
	String height;
	String width;

	Extend({this.height, this.width});

	Extend.fromJson(Map<String, dynamic> json) {
		height = json['height'];
		width = json['width'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['height'] = this.height;
		data['width'] = this.width;
		return data;
	}
}