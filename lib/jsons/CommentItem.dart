class CommentItem {
  String id;
  String content;
  // Null createTime;
  String memberId;
  String praiseNum;
  String rescueId;
  // Null startId;
  // Null toMemberId;
  // Null toMemberNickname;
  MemberDetail memberDetail;
  int childrenCount;
  List<CommentItemChildrens> commentItemChildrens;

  CommentItem(
      {this.id,
      this.content,
      // this.createTime,
      this.memberId,
      this.praiseNum,
      this.rescueId,
      // this.startId,
      // this.toMemberId,
      // this.toMemberNickname,
      this.memberDetail,
      this.childrenCount,
      this.commentItemChildrens});

  CommentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
    // createTime = json['create_time'];
    memberId = json['member_id'];
    praiseNum = json['praise_num'];
    rescueId = json['rescue_id'];
    // startId = json['start_id'];
    // toMemberId = json['to_member_id'];
    // toMemberNickname = json['to_member_nickname'];
    memberDetail = json['member_detail'] != null
        ? new MemberDetail.fromJson(json['member_detail'])
        : null;
    childrenCount = json['children_count'];
    if (json['childrens'] != null) {
      commentItemChildrens = new List<CommentItemChildrens>();
      json['childrens'].forEach((v) {
        commentItemChildrens.add(new CommentItemChildrens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    // data['create_time'] = this.createTime;
    data['member_id'] = this.memberId;
    data['praise_num'] = this.praiseNum;
    data['rescue_id'] = this.rescueId;
    // data['start_id'] = this.startId;
    // data['to_member_id'] = this.toMemberId;
    // data['to_member_nickname'] = this.toMemberNickname;
    if (this.memberDetail != null) {
      data['member_detail'] = this.memberDetail.toJson();
    }
    data['children_count'] = this.childrenCount;
    if (this.commentItemChildrens != null) {
      data['childrens'] = this.commentItemChildrens.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MemberDetail {
  String id;
  String nickname;
  String avatar;

  MemberDetail({this.id, this.nickname, this.avatar});

  MemberDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickname'] = this.nickname;
    data['avatar'] = this.avatar;
    return data;
  }
}

class CommentItemChildrens {
  String id;
  String startId;
  // String pid;
  String content;
  String rescueId;
  // String level;
  String memberId;
  String toMemberId;
  String toMemberNickname;
  String praiseNum;
  String status;
  // Null createTime;
  // Null updateTime;
  MemberDetail memberDetail;

  CommentItemChildrens(
      {this.id,
      this.startId,
      // this.pid,
      this.content,
      this.rescueId,
      // this.level,
      this.memberId,
      this.toMemberId,
      this.toMemberNickname,
      this.praiseNum,
      this.status,
      // this.createTime,
      // this.updateTime,
      this.memberDetail});

  CommentItemChildrens.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startId = json['start_id'];
    // pid = json['pid'];
    content = json['content'];
    rescueId = json['rescue_id'];
    // level = json['level'];
    memberId = json['member_id'];
    toMemberId = json['to_member_id'];
    toMemberNickname = json['to_member_nickname'];
    praiseNum = json['praise_num'];
    status = json['status'];
    // createTime = json['create_time'];
    // updateTime = json['update_time'];
    memberDetail = json['member_detail'] != null
        ? new MemberDetail.fromJson(json['member_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_id'] = this.startId;
    // data['pid'] = this.pid;
    data['content'] = this.content;
    data['rescue_id'] = this.rescueId;
    // data['level'] = this.level;
    data['member_id'] = this.memberId;
    data['to_member_id'] = this.toMemberId;
    data['to_member_nickname'] = this.toMemberNickname;
    data['praise_num'] = this.praiseNum;
    data['status'] = this.status;
    // data['create_time'] = this.createTime;
    // data['update_time'] = this.updateTime;
    if (this.memberDetail != null) {
      data['member_detail'] = this.memberDetail.toJson();
    }
    return data;
  }
}