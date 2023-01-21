import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? Id;
  String? title;
  String? subTitle;
  String? desc;
  Timestamp? date;
  String? imageUrl;

  PostModel({
    this.Id,
    this.title,
    this.subTitle,
    this.desc,
    this.date,
    this.imageUrl,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    Id = json['Id'];
    title = json['Title'];
    subTitle = json['SubTitle'];
    desc = json['desc'];
    date = json['date'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'Id': Id,
      'Title': title,
      'SubTitle': subTitle,
      'desc': desc,
      'date': date,
      'imageUrl': imageUrl,
    };
  }
}
