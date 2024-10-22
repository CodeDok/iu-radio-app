
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:radio_app/domain_models/moderator.dart';
import 'package:radio_app/domain_models/moderator_rating.dart';
import 'package:http/http.dart' as http;
import 'package:radio_app/repository/rating/dto/moderator_rating_dto.dart';

import 'dto/moderator_dto.dart';

class ModeratorRatingRepository {
  final String radioStationApi = dotenv.get("RADIO_STATION_API_URL");
  final client = http.Client();

  Future<Moderator> retrieveCurrentModerator() async {
    var response = await client.get(Uri.http(radioStationApi, "/api/moderator/current"));

    if (response.statusCode != 200) {
      throw Exception("Error while trying to retrieve current moderator");
    }

    Map decodedResponse = jsonDecode(response.body) as Map;
    var dto = ModeratorDto.fromJson(decodedResponse);

    return Moderator(
        id: dto.id,
        firstName: dto.firstName,
        lastName: dto.lastName,
        image: Uri.parse(dto.image)
    );
  }

  Future<void> sendModeratorRating(ModeratorRating moderatorRating) async {
    var moderatorRatingDto = ModeratorRatingDto.fromDomain(moderatorRating);
    var response = await client.post(Uri.http(radioStationApi, "/api/moderator/rating"), body: moderatorRatingDto.toJson());
    if (response.statusCode != 200) {
      throw Exception("Error while trying to submit rating");
    }
  }

}