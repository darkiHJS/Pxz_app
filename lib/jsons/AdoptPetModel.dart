class AdoptPetModel {
  String id; // 资源id
  String name; // 宠物名称
  String ptsid; // 宠物id？
  String cateId; // 类型id
  String age; // 月龄
  String ageStage; // 啥？
  String sex; 
  String vaccine;
  String sterilization;
  String deworming;
  String origin;
  String bodyType;
  String hair;
  String health;
  String marketable; // 发布
  String createTime;
  String lastModify;
  String intro;
  String area;
  String addr;
  String wechatNumber;
  String wechatQrcode;
  String mobile;
  List<Item> tagList;
  ToMember toMember;
  Item category;
  List<Item> adoptionNeeds;
  String petVariety;
  List<Resources> resources;
  int adoptCount;

  AdoptPetModel(
      {this.id,
      this.name,
      this.ptsid,
      this.cateId,
      this.age,
      this.ageStage,
      this.sex,
      this.vaccine,
      this.sterilization,
      this.deworming,
      this.origin,
      this.bodyType,
      this.hair,
      this.health,
      this.marketable,
      this.createTime,
      this.lastModify,
      this.intro,
      this.area,
      this.addr,
      this.wechatNumber,
      this.wechatQrcode,
      this.mobile,
      this.tagList,
      this.toMember,
      this.category,
      this.adoptionNeeds,
      this.petVariety,
      this.resources,
      this.adoptCount});

  AdoptPetModel.fromJson(Map<String, dynamic> json) {
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
    createTime = json['create_time'];
    lastModify = json['last_modify'];
    intro = json['intro'];
    area = json['area'];
    addr = json['addr'];
    wechatNumber = json['wechat_number'];
    wechatQrcode = json['wechat_qrcode'];
    mobile = json['mobile'];
    if (json['tag_list'] != null) {
      tagList = new List<Item>();
      json['tag_list'].forEach((v) {
        tagList.add(new Item.fromJson(v));
      });
    }
    toMember = json['to_member'] != null
        ? new ToMember.fromJson(json['to_member'])
        : null;
    category = json['category'] != null
        ? new Item.fromJson(json['category'])
        : null;
    if (json['adoption_needs'] != null) {
      adoptionNeeds = new List<Item>();
      json['adoption_needs'].forEach((v) {
        adoptionNeeds.add(new Item.fromJson(v));
      });
    }
    petVariety = json['pet_variety'];
    if (json['resources'] != null) {
      resources = new List<Resources>();
      json['resources'].forEach((v) {
        resources.add(new Resources.fromJson(v));
      });
    }
    adoptCount = json['adopt_count'];
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
    data['create_time'] = this.createTime;
    data['last_modify'] = this.lastModify;
    data['intro'] = this.intro;
    data['area'] = this.area;
    data['addr'] = this.addr;
    data['wechat_number'] = this.wechatNumber;
    data['wechat_qrcode'] = this.wechatQrcode;
    data['mobile'] = this.mobile;
    if (this.tagList != null) {
      data['tag_list'] = this.tagList.map((v) => v.toJson()).toList();
    }
    if (this.toMember != null) {
      data['to_member'] = this.toMember.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.adoptionNeeds != null) {
      data['adoption_needs'] =
          this.adoptionNeeds.map((v) => v.toJson()).toList();
    }
    data['pet_variety'] = this.petVariety;
    if (this.resources != null) {
      data['resources'] = this.resources.map((v) => v.toJson()).toList();
    }
    data['adopt_count'] = this.adoptCount;
    return data;
  }
}

class Item {
  String id;
  String name;

  Item({this.id, this.name});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ToMember {
  String id;
  String nickname;

  ToMember({this.id, this.nickname});

  ToMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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