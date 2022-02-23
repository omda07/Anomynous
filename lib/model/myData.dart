class MyData {
  List<Result>? result;

  MyData({this.result});

  MyData.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? id;
  bool? isActive;
  String? price;
  String? company;
  String? picture;
  String? buyer;
  List<String>? tags;
  String? status;
  String? registered;

  Result(
      {this.id,
        this.isActive,
        this.price,
        this.company,
        this.picture,
        this.buyer,
        this.tags,
        this.status,
        this.registered});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isActive = json['isActive'];
    price = json['price'];
    company = json['company'];
    picture = json['picture'];
    buyer = json['buyer'];
    tags = json['tags'].cast<String>();
    status = json['status'];
    registered = json['registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isActive'] = this.isActive;
    data['price'] = this.price;
    data['company'] = this.company;
    data['picture'] = this.picture;
    data['buyer'] = this.buyer;
    data['tags'] = this.tags;
    data['status'] = this.status;
    data['registered'] = this.registered;
    return data;
  }
}
