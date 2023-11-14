import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/config/models/list_restaurant_response.dart';

void main() {
  group('Parse RestaurantListItemResponse', () {
    var json = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
      "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    };

    test('Should be able to parse RestaurantListItemResponse from json', () {
      var result = Restaurant.fromJson(json);
      expect(result.id, 'rqdv5juczeskfw1e867');
      expect(result.name, 'Melting Pot');
      expect(result.description,
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...');
      expect(result.pictureId, '14');
      expect(result.city, 'Medan');
      expect(result.rating, 4.2);
    });

    test('Should be able to parse RestaurantListItemResponse to json', () {
      var result = Restaurant.fromJson(json).toJson();
      expect(result, json);
      expect(result['id'], 'rqdv5juczeskfw1e867');
      expect(result['name'], 'Melting Pot');
      expect(result['description'],
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...');
      expect(result['pictureId'], '14');
      expect(result['city'], 'Medan');
      expect(result['rating'], 4.2);
    });
  });

  group('Parse RestaurantListResponse', () {
    var json = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
        {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
        }
      ]
    };
    test('Should be able to parse RestaurantListResponse from json', () {
      var result = ListRestaurantResponse.fromJson(json);
      expect(result.error, false);
      expect(result.message, 'success');
      expect(result.count, 20);
      expect(result.restaurants?.length, 2);
    });
    test('Should be able to parse RestaurantListResponse to json', () {
      var result = ListRestaurantResponse.fromJson(json).toJson();
      expect(result, json);
      expect(result['error'], false);
      expect(result['message'], 'success');
      expect(result['count'], 20);
      expect(result['restaurants']?.length, 2);
    });
  });
}
