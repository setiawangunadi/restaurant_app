class FavoriteRestaurant {
  String? id;
  String? name;
  String? description;
  String? city;
  String? pictureId;

  FavoriteRestaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.pictureId,
  });

  factory FavoriteRestaurant.fromJson(Map<String, dynamic> json) => FavoriteRestaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city
  };
}