// item data class
///
class DiscoveryDataItem {
  String id;
  String title;
  String likeNum;
  String mainDefaultId;
  String resourceType;
  MemberDetail memberDetail;
  DiscoveryDataItem(
      {this.id, this.title, this.likeNum, this.mainDefaultId, this.memberDetail, this.resourceType});

  factory DiscoveryDataItem.fromJson(Map<String, dynamic> parsedJson) {
    return DiscoveryDataItem(
        id: parsedJson["id"],
        title: parsedJson["title"],
        likeNum: parsedJson["like_num"],
        mainDefaultId: parsedJson["main_default_id"],
        resourceType: parsedJson["resource_type"],
        memberDetail: MemberDetail.fromJson(parsedJson["member_detail"]),
      );
  }
}

class MemberDetail {
  String id;
  String avatar;
  String nickname;

  MemberDetail({this.id, this.avatar, this.nickname});

  factory MemberDetail.fromJson(Map<String, dynamic> parsedJson) {
    return MemberDetail(
        id: parsedJson["id"],
        avatar: parsedJson["avatar"],
        nickname: parsedJson["nickname"]);
  }
}