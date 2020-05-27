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
	String resourceType;
	String type;
	String reportNum;
	String status;
	List<Resources> resources;
	MemberDetail memberDetail;
	List<PetList> petList;

	ContentDetailsData({this.id, this.title, this.linkVideo, this.mainDefaultId, this.marketable, this.desc, this.createTime, this.likeNum, this.collectNum, this.updateTime, this.commentCount, this.shareCount, this.readCount, this.pushTime, this.memberId, this.resourceType, this.type, this.reportNum, this.status, this.resources, this.memberDetail, this.petList});

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
		resourceType = json['resource_type'];
		type = json['type'];
		reportNum = json['report_num'];
		status = json['status'];
		if (json['resources'] != null) {
			resources = new List<Resources>();
			json['resources'].forEach((v) { resources.add(new Resources.fromJson(v)); });
		}
		memberDetail = json['member_detail'] != null ? new MemberDetail.fromJson(json['member_detail']) : null;
		if (json['pet_list'] != null) {
			petList = new List<PetList>();
			json['pet_list'].forEach((v) { petList.add(new PetList.fromJson(v)); });
		}
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
		data['resource_type'] = this.resourceType;
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
		return data;
	}
}

class Resources {
	String url;
	String type;
	Extends whextends;

	Resources({this.url, this.type, this.whextends});

	Resources.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		type = json['type'];
		whextends = json['extends'] != null ? new Extends.fromJson(json['extends']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url'] = this.url;
		data['type'] = this.type;
		if (this.whextends != null) {
      data['extends'] = this.whextends.toJson();
    }
		return data;
	}
}

class Extends {
	String height;
	String width;

	Extends({this.height, this.width});

	Extends.fromJson(Map<String, dynamic> json) {
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
	ImageDefaultId imageDefaultId;

	PetList({this.id, this.name, this.imageDefaultId});

	PetList.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		imageDefaultId = json['image_default_id'] != null ? new ImageDefaultId.fromJson(json['image_default_id']) : null;
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

class ImageDefaultId {
	String url;
	String type;

	ImageDefaultId({this.url, this.type});

	ImageDefaultId.fromJson(Map<String, dynamic> json) {
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