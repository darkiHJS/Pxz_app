class PetItemData {
  String id;
	String name;
	String ptsid;
	String cateId;
	String age;
	String ageStage;
	String sex;
	String vaccine;
	String sterilization;
	String deworming;
	String origin;
	String bodyType;
	String hair;
	String health;
	String marketable;
	String uptime;
	String createTime;
	String lastModify;
	String imageDefaultId;
	String intro;
	String area;
	String addr;
	String wechatNumber;
	String wechatQrcode;
	String mobile;
	String petVarietyId;
	List<PetTagList> petTagList;
	MemberDetail memberDetail;
	List<Resources> resources;

	PetItemData({this.id, this.name, this.ptsid, this.cateId, this.age, this.ageStage, this.sex, this.vaccine, this.sterilization, this.deworming, this.origin, this.bodyType, this.hair, this.health, this.marketable, this.uptime, this.createTime, this.lastModify, this.imageDefaultId, this.intro, this.area, this.addr, this.wechatNumber, this.wechatQrcode, this.mobile, this.petVarietyId, this.petTagList, this.memberDetail, this.resources});

	PetItemData.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		ptsid = json['ptsid'];
		cateId = json['cate_id'];
		age = json['age'];
		ageStage = json['age_stage'];
		sex = json['sex'];
		vaccine = json['vaccine'];
		sterilization = json['sterilization'];
		deworming = json['deworming'];
		origin = json['origin'];
		bodyType = json['body_type'];
		hair = json['hair'];
		health = json['health'];
		marketable = json['marketable'];
		uptime = json['uptime'];
		createTime = json['create_time'];
		lastModify = json['last_modify'];
		imageDefaultId = json['image_default_id'];
		intro = json['intro'];
		area = json['area'];
		addr = json['addr'];
		wechatNumber = json['wechat_number'];
		wechatQrcode = json['wechat_qrcode'];
		mobile = json['mobile'];
		petVarietyId = json['pet_variety_id'];
		if (json['pet_tag_list'] != null) {
			petTagList = new List<PetTagList>();
			json['pet_tag_list'].forEach((v) { petTagList.add(new PetTagList.fromJson(v)); });
		}
		memberDetail = json['member_detail'] != null ? new MemberDetail.fromJson(json['member_detail']) : null;
		if (json['resources'] != null) {
			resources = new List<Resources>();
			json['resources'].forEach((v) { resources.add(new Resources.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['ptsid'] = this.ptsid;
		data['cate_id'] = this.cateId;
		data['age'] = this.age;
		data['age_stage'] = this.ageStage;
		data['sex'] = this.sex;
		data['vaccine'] = this.vaccine;
		data['sterilization'] = this.sterilization;
		data['deworming'] = this.deworming;
		data['origin'] = this.origin;
		data['body_type'] = this.bodyType;
		data['hair'] = this.hair;
		data['health'] = this.health;
		data['marketable'] = this.marketable;
		data['uptime'] = this.uptime;
		data['create_time'] = this.createTime;
		data['last_modify'] = this.lastModify;
		data['image_default_id'] = this.imageDefaultId;
		data['intro'] = this.intro;
		data['area'] = this.area;
		data['addr'] = this.addr;
		data['wechat_number'] = this.wechatNumber;
		data['wechat_qrcode'] = this.wechatQrcode;
		data['mobile'] = this.mobile;
		data['pet_variety_id'] = this.petVarietyId;
		if (this.petTagList != null) {
      data['pet_tag_list'] = this.petTagList.map((v) => v.toJson()).toList();
    }
		if (this.memberDetail != null) {
      data['member_detail'] = this.memberDetail.toJson();
    }
		if (this.resources != null) {
      data['resources'] = this.resources.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class PetTagList {
	String id;
	String name;
	Null imageId;
	String createTime;
	String updateTime;

	PetTagList({this.id, this.name, this.imageId, this.createTime, this.updateTime});

	PetTagList.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		imageId = json['image_id'];
		createTime = json['create_time'];
		updateTime = json['update_time'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['image_id'] = this.imageId;
		data['create_time'] = this.createTime;
		data['update_time'] = this.updateTime;
		return data;
	}
}

class MemberDetail {
	String id;
	String avatar;
	String nickname;

	MemberDetail({this.id, this.avatar, this.nickname});

	MemberDetail.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		avatar = json['avatar'];
		nickname = json['nickname'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['avatar'] = this.avatar;
		data['nickname'] = this.nickname;
		return data;
	}
}

class Resources {
	String url;
	String type;
	String md5;

	Resources({this.url, this.type, this.md5});

	Resources.fromJson(Map<String, dynamic> json) {
		url = json['url'];
		type = json['type'];
		md5 = json['md5'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url'] = this.url;
		data['type'] = this.type;
		data['md5'] = this.md5;
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