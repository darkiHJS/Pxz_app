
class ContentDetailsData {
  String id;
  String title;
  String linkVideo;
  String mainDefaultId;
  String marketable;
  String desc;
  String createTime;
  String likeNum;
  String collectNum;
  String updateTime;
  String commentCount;
  String shareCount;
  String readCount;
  String pushTime;
  String memberId;
  String type;
  String reportNum;
  String status;
  List<Resources> resources;
  MemberDetail memberDetail;
  List<PetList> petList;
  CommentList commentList;

  ContentDetailsData(
      {this.id,
      this.title,
      this.linkVideo,
      this.mainDefaultId,
      this.marketable,
      this.desc,
      this.createTime,
      this.likeNum,
      this.collectNum,
      this.updateTime,
      this.commentCount,
      this.shareCount,
      this.readCount,
      this.pushTime,
      this.memberId,
      this.type,
      this.reportNum,
      this.status,
      this.resources,
      this.memberDetail,
      this.petList,
      this.commentList});

  ContentDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    linkVideo = json['link_video'];
    mainDefaultId = json['main_default_id'];
    marketable = json['marketable'];
    desc = json['desc'];
    createTime = json['create_time'];
    likeNum = json['like_num'];
    collectNum = json['collect_num'];
    updateTime = json['update_time'];
    commentCount = json['comment_count'];
    shareCount = json['share_count'];
    readCount = json['read_count'];
    pushTime = json['push_time'];
    memberId = json['member_id'];
    type = json['type'];
    reportNum = json['report_num'];
    status = json['status'];
    if (json['resources'] != null) {
      resources = new List<Resources>();
      json['resources'].forEach((v) {
        resources.add(new Resources.fromJson(v));
      });
    }
    memberDetail = json['member_detail'] != null
        ? new MemberDetail.fromJson(json['member_detail'])
        : null;
    if (json['pet_list'] != null) {
      petList = new List<PetList>();
      json['pet_list'].forEach((v) {
        petList.add(new PetList.fromJson(v));
      });
    }
    commentList = json['comment_list'].length > 0
        ? new CommentList.fromJson(json['comment_list'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['link_video'] = this.linkVideo;
    data['main_default_id'] = this.mainDefaultId;
    data['marketable'] = this.marketable;
    data['desc'] = this.desc;
    data['create_time'] = this.createTime;
    data['like_num'] = this.likeNum;
    data['collect_num'] = this.collectNum;
    data['update_time'] = this.updateTime;
    data['comment_count'] = this.commentCount;
    data['share_count'] = this.shareCount;
    data['read_count'] = this.readCount;
    data['push_time'] = this.pushTime;
    data['member_id'] = this.memberId;
    data['type'] = this.type;
    data['report_num'] = this.reportNum;
    data['status'] = this.status;
    if (this.resources != null) {
      data['resources'] = this.resources.map((v) => v.toJson()).toList();
    }
    if (this.memberDetail != null) {
      data['member_detail'] = this.memberDetail.toJson();
    }
    if (this.petList != null) {
      data['pet_list'] = this.petList.map((v) => v.toJson()).toList();
    }
    if (this.commentList != null) {
      data['comment_list'] = this.commentList.toJson();
    }
    return data;
  }
}

class Resources {
  String url;
  String type;

  Resources({this.url, this.type});

  Resources.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['type'] = this.type;
    return data;
  }
}

class MemberDetail {
  String id;
  String nickname;
  String avatar;
  String memberFriend;

  MemberDetail({this.id, this.nickname, this.avatar, this.memberFriend});

  MemberDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatar = json['avatar'];
    memberFriend = json['member_friend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    data['member_friend'] = this.memberFriend;
    return data;
  }
}

class PetList {
  String id;
  String name;
  Resources imageDefaultId;

  PetList({this.id, this.name, this.imageDefaultId});

  PetList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageDefaultId = json['image_default_id'] != null
        ? new Resources.fromJson(json['image_default_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.imageDefaultId != null) {
      data['image_default_id'] = this.imageDefaultId.toJson();
    }
    return data;
  }
}

class CommentList {
  List<Items> items;
  int first;
  int before;
  int previous;
  int current;
  int last;
  int next;
  int totalPages;
  int totalItems;
  int limit;

  CommentList(
      {this.items,
      this.first,
      this.before,
      this.previous,
      this.current,
      this.last,
      this.next,
      this.totalPages,
      this.totalItems,
      this.limit});

  CommentList.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = new List<Items>();
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
    first = json['first'];
    before = json['before'];
    previous = json['previous'];
    current = json['current'];
    last = json['last'];
    next = json['next'];
    totalPages = json['total_pages'];
    totalItems = json['total_items'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    data['first'] = this.first;
    data['before'] = this.before;
    data['previous'] = this.previous;
    data['current'] = this.current;
    data['last'] = this.last;
    data['next'] = this.next;
    data['total_pages'] = this.totalPages;
    data['total_items'] = this.totalItems;
    data['limit'] = this.limit;
    return data;
  }
}

class Items {
  String id;
  String content;
  Null createTime;
  String memberId;
  String praiseNum;
  String rescueId;
  Null startId;
  Null toMemberId;
  Null toMemberNickname;
  MemberDetail memberDetail;
  int childrenCount;
  Childrens childrens;

  Items(
      {this.id,
      this.content,
      this.createTime,
      this.memberId,
      this.praiseNum,
      this.rescueId,
      this.startId,
      this.toMemberId,
      this.toMemberNickname,
      this.memberDetail,
      this.childrenCount,
      this.childrens});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    createTime = json['create_time'];
    memberId = json['member_id'];
    praiseNum = json['praise_num'];
    rescueId = json['rescue_id'];
    startId = json['start_id'];
    toMemberId = json['to_member_id'];
    toMemberNickname = json['to_member_nickname'];
    memberDetail = json['member_detail'] != null
        ? new MemberDetail.fromJson(json['member_detail'])
        : null;
    childrenCount = json['children_count'];
    childrens = json['childrens'].length > 0
        ? new Childrens.fromJson(json['childrens'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    data['create_time'] = this.createTime;
    data['member_id'] = this.memberId;
    data['praise_num'] = this.praiseNum;
    data['rescue_id'] = this.rescueId;
    data['start_id'] = this.startId;
    data['to_member_id'] = this.toMemberId;
    data['to_member_nickname'] = this.toMemberNickname;
    if (this.memberDetail != null) {
      data['member_detail'] = this.memberDetail.toJson();
    }
    data['children_count'] = this.childrenCount;
    if (this.childrens != null) {
      data['childrens'] = this.childrens.toJson();
    }
    return data;
  }
}

class Childrens {
  String id;
  String startId;
  String pid;
  String content;
  String rescueId;
  String level;
  String memberId;
  String toMemberId;
  String toMemberNickname;
  String praiseNum;
  String status;
  Null createTime;
  Null updateTime;
  MemberDetail memberDetail;

  Childrens(
      {this.id,
      this.startId,
      this.pid,
      this.content,
      this.rescueId,
      this.level,
      this.memberId,
      this.toMemberId,
      this.toMemberNickname,
      this.praiseNum,
      this.status,
      this.createTime,
      this.updateTime,
      this.memberDetail});

  Childrens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startId = json['start_id'];
    pid = json['pid'];
    content = json['content'];
    rescueId = json['rescue_id'];
    level = json['level'];
    memberId = json['member_id'];
    toMemberId = json['to_member_id'];
    toMemberNickname = json['to_member_nickname'];
    praiseNum = json['praise_num'];
    status = json['status'];
    createTime = json['create_time'];
    updateTime = json['update_time'];
    memberDetail = json['member_detail'] != null
        ? new MemberDetail.fromJson(json['member_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_id'] = this.startId;
    data['pid'] = this.pid;
    data['content'] = this.content;
    data['rescue_id'] = this.rescueId;
    data['level'] = this.level;
    data['member_id'] = this.memberId;
    data['to_member_id'] = this.toMemberId;
    data['to_member_nickname'] = this.toMemberNickname;
    data['praise_num'] = this.praiseNum;
    data['status'] = this.status;
    data['create_time'] = this.createTime;
    data['update_time'] = this.updateTime;
    if (this.memberDetail != null) {
      data['member_detail'] = this.memberDetail.toJson();
    }
    return data;
  }
}