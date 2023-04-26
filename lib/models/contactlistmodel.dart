import 'dart:convert';

List<Contactlistmodel> contactlistmodelFromJson(String str) =>
    List<Contactlistmodel>.from(
        json.decode(str).map((x) => Contactlistmodel.fromJson(x)));

String contactlistmodelToJson(List<Contactlistmodel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())));

class Contactlistmodel {
  Contactlistmodel({
    this.id,
    this.name,
    this.contacts,
    this.url,
  });

  String? id;
  String? name;
  String? contacts;
  String? url;

  factory Contactlistmodel.fromJson(Map<String, dynamic> json) =>
      Contactlistmodel(
        id: json["id"],
        name: json["name"],
        contacts: json["Contacts"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "Contacts": contacts,
        "url": url,
      };
}
