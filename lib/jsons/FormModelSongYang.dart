class FormModelSongYang {
  List<SelectItem> petVariety;
  List<SelectItem> sex;
  List<SelectItem> vaccine;
  List<SelectItem> sterilization;
  List<SelectItem> deworming;
  List<SelectItem> origin;
  List<SelectItem> bodyType;
  List<SelectItem> hair;
  List<SelectItem> health;
  List<SelectItem> cate;
  List<SelectItem> petTag;
  List<SelectItem> adoptionNeeds;

  FormModelSongYang(
      {this.petVariety,
      this.cate,
      this.petTag,
      this.adoptionNeeds,
      this.sex,
      this.vaccine,
      this.sterilization,
      this.deworming,
      this.origin,
      this.bodyType,
      this.hair,
      this.health});

  FormModelSongYang.fromJson(Map<String, dynamic> json) {
    // 特征
    if (json['pet_variety'] != null) {
      petVariety = new List<SelectItem>();
      json['pet_variety'].forEach((v) {
        petVariety.add(SelectItem.fromJson(v));
      });
    }

    // 种类
    if (json['cate'] != null) {
      cate = new List<SelectItem>();
      json['cate'].forEach((v) {
        cate.add(SelectItem.fromJson(v));
      });
    }

    // 宠物标签
    if (json['pet_tag'] != null) {
      petTag = new List<SelectItem>();
      json['pet_tag'].forEach((v) {
        petTag.add(SelectItem.fromJson(v));
      });
    }

    // 领养要求
    if (json['adoption_needs'] != null) {
      adoptionNeeds = new List<SelectItem>();
      json['adoption_needs'].forEach((v) {
        adoptionNeeds.add(SelectItem.fromJson(v));
      });
    }

    // 多套一层就贼难受
    if (json['columns'] != null) {
      var columns = json['columns'];

      // sex
      if (columns['sex'] != null) {
        Map<String, dynamic> type = columns['sex']['type'];
        sex = new List<SelectItem>();
        type.keys.toList().forEach((element) {
          sex.add(SelectItem.fromJson({"id": element, "name": type[element]}));
        });
      }

      // 疫苗
      if (columns['vaccine'] != null) {
        Map<String, dynamic> type = columns['vaccine']['type'];
        vaccine = new List<SelectItem>();
        type.keys.toList().forEach((element) {
          vaccine
              .add(SelectItem.fromJson({"id": element, "name": type[element]}));
        });
      }

      // 绝育
      if (columns['sterilization'] != null) {
        Map<String, dynamic> type = columns['sterilization']['type'];
        sterilization = new List<SelectItem>();
        type.keys.toList().forEach((element) {
          sterilization
              .add(SelectItem.fromJson({"id": element, "name": type[element]}));
        });
      }

      // 驱虫
      if (columns['deworming'] != null) {
        Map<String, dynamic> type = columns['deworming']['type'];
        deworming = new List<SelectItem>();
        type.keys.toList().forEach((element) {
          deworming
              .add(SelectItem.fromJson({"id": element, "name": type[element]}));
        });
      }

      // 来源
      if (columns['origin'] != null) {
        Map<String, dynamic> type = columns['origin']['type'];
        origin = new List<SelectItem>();
        type.keys.toList().forEach((element) {
          origin
              .add(SelectItem.fromJson({"id": element, "name": type[element]}));
        });
      }

      // 体型
      if (columns['body_type'] != null) {
        Map<String, dynamic> type = columns['body_type']['type'];
        bodyType = new List<SelectItem>();
        type.keys.toList().forEach((element) {
          bodyType
              .add(SelectItem.fromJson({"id": element, "name": type[element]}));
        });
      }

      // 毛发
      if (columns['hair'] != null) {
        Map<String, dynamic> type = columns['hair']['type'];
        hair = new List<SelectItem>();
        type.keys.toList().forEach((element) {
          hair.add(SelectItem.fromJson({"id": element, "name": type[element]}));
        });
      }

      // 健康
      if (columns['health'] != null) {
        Map<String, dynamic> type = columns['health']['type'];
        health = new List<SelectItem>();
        type.keys.toList().forEach((element) {
          health
              .add(SelectItem.fromJson({"id": element, "name": type[element]}));
        });
      }
    }
  }
}

class SelectItem {
  String id;
  String name;

  SelectItem({this.id, this.name});

  SelectItem.fromJson(Map<String, dynamic> json) {
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

class FormDataSongYang {
  String name;// 宠物名称
  String cateId;// 宠物类别
  String age;// 宠物年龄
  String sex;// 性别
  String vaccine; // 疫苗
  String sterilization;// 绝育
  String deworming;// 驱虫
  String origin;// 来源
  String bodyType;// 体型
  String hair;// 毛发
  String health;// 健康状况
  String marketable;// 发布情况
  String intro;// 故事
  List<String> area;// 地址
  String addr;// 详细地址
  String wechatQrcode; // 微信二维码
  String wechatNumber;// 微信号
  String mobile; // 手机号
  String petVarietyId; // 宠物特征
  List<String> resources; // 资源组
  List<String> tags; // 宠物特点
  String id; // 编辑用
  List<String> aboptionNeeds; // 收养条件 

  // verifyForm() {
  //   String msg = '';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(cateId == null || cateId == "") msg += '类别';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(name == null || name == "") msg += '宠物名';
  //   if(name == null || name == "") msg += '宠物名';


  //   return name;
  // }
}