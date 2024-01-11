class DurationModel {
  List<Items>? items;

  DurationModel({this.items});

  DurationModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  ContentDetails? contentDetails;

  Items({this.contentDetails});

  Items.fromJson(Map<String, dynamic> json) {
    contentDetails = json['contentDetails'] != null
        ? new ContentDetails.fromJson(json['contentDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contentDetails != null) {
      data['contentDetails'] = this.contentDetails!.toJson();
    }
    return data;
  }
}

class ContentDetails {
  String? duration;

  ContentDetails({this.duration});

  ContentDetails.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    return data;
  }
}
