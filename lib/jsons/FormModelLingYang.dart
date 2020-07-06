class FormModelLingYang {
  List<ItemLingYang> sex = [
    ItemLingYang(id: "1", title: "女"),
    ItemLingYang(id: "2", title: "男")
  ];
  List<ItemLingYang> age = [
    ItemLingYang(id: "1", title: "18岁以下"),
    ItemLingYang(id: "2", title: "18~25"),
    ItemLingYang(id: "3", title: "26~30"),
    ItemLingYang(id: "4", title: "31~40"),
    ItemLingYang(id: "5", title: "41~50"),
    ItemLingYang(id: "6", title: "51~60"),
    ItemLingYang(id: "7", title: "60以上"),
  ];
  List<ItemLingYang> liviEnvironment = [
    ItemLingYang(id: "1", title: "自己整租"),
    ItemLingYang(id: "2", title: "合租单间"),
    ItemLingYang(id: "3", title: "自有房"),
    ItemLingYang(id: "4", title: "父母同住"),
  ];
  List<ItemLingYang> budget = [
    ItemLingYang(id: "1", title: "200~300"),
    ItemLingYang(id: "2", title: "300~500"),
    ItemLingYang(id: "3", title: "500~800"),
    ItemLingYang(id: "4", title: "1000+"),
  ];
  List<ItemLingYang> occupation = [
    ItemLingYang(id: "1", title: "高中"),
    ItemLingYang(id: "2", title: "大学"),
    ItemLingYang(id: "3", title: "国企"),
    ItemLingYang(id: "4", title: "私企"),
    ItemLingYang(id: "5", title: "自由职业"),
    ItemLingYang(id: "6", title: "创业"),
  ];
  List<ItemLingYang> allergy = [
    ItemLingYang(id: "1", title: "不过敏"),
    ItemLingYang(id: "2", title: "过敏"),
    ItemLingYang(id: "3", title: "未发现"),
  ];
}

class ItemLingYang {
  String id;
  String title;
  ItemLingYang({this.id, this.title});
}

class FormDataLingyang {
  String occupation; // 职业
  String contact; // 联系方式
  String wechat; // 微信
  String wechatImg; // 微信二维码
  String sex; // 性别
  String age; // 年龄
  bool experience = false; // 养宠经验
  String liviEnvironment; // 居住条件
  bool marriage = false; // 婚姻情况
  bool familyConsent = true; // 家人是否同意养宠
  String allergy; // 过敏
  bool paid = true; // 有偿领养
  String budget; // 养宠预算
  List<String> area; // 地区
  List<String> giveUp = [];
}