class CommentItem {
  String id;
  String startId;
  String pid;
  String content;
  String petId;
  String level;
  String memberId;
  String toMemberId;
  String toMemberNickname;
  String praiseNum;
  String status;
  String createTime;
  String updateTime;
  MemberDetail memberDetail;
  bool isLike;
  int childrenCount;
  List<CommentItem> childrens;

  CommentItem(
      {this.id,
      this.startId,
      this.pid,
      this.content,
      this.petId,
      this.level,
      this.memberId,
      this.toMemberId,
      this.toMemberNickname,
      this.praiseNum,
      this.status,
      this.createTime,
      this.updateTime,
      this.memberDetail,
      this.isLike,
      this.childrenCount,
      this.childrens});
  
   CommentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startId = json['start_id'];
    pid = json['pid'];
    content = json['content'];
    petId = json['pet_id'];
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
    isLike = json['is_like'];
    childrenCount = json['children_count'];
    if (json['childrens'] != null) {
      childrens = new List<CommentItem>();
      json['childrens'].forEach((v) {
        childrens.add(new CommentItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['start_id'] = this.startId;
    data['pid'] = this.pid;
    data['content'] = this.content;
    data['pet_id'] = this.petId;
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
    data['is_like'] = this.isLike;
    data['children_count'] = this.childrenCount;
    if (this.childrens != null) {
      data['childrens'] = this.childrens.map((v) => v.toJson()).toList();
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