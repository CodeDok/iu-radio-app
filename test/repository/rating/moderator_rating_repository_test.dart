import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:radio_app/domain_models/five_star_rating.dart';
import 'package:radio_app/domain_models/moderator.dart';
import 'package:radio_app/domain_models/moderator_rating.dart';
import 'package:radio_app/repository/rating/moderator_rating_repository.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'moderator_rating_repository_test.mocks.dart';



@GenerateMocks([http.Client])
void main() {
  group('ModeratorRatingRepository', () {
    late MockClient mockClient;
    late ModeratorRatingRepository repository;

    setUp(() {
      dotenv.testLoad(fileInput: '''RADIO_STATION_API_URL=example.com''');
      mockClient = MockClient();
      repository = ModeratorRatingRepository();
      repository.client = mockClient;
    });

    test('retrieveCurrentModerator returns Moderator on success', () async {
      final mockResponse = {
        "id": 1,
        "firstName": "John",
        "lastName": "Doe",
        "image": "http://example.com/image.jpg"
      };

      when(mockClient.get(Uri.parse('http://example.com/api/moderator/current')))
          .thenAnswer((_) async => http.Response(jsonEncode(mockResponse), 200));

      final moderator = await repository.retrieveCurrentModerator();

      expect(moderator.id, 1);
      expect(moderator.firstName, "John");
      expect(moderator.lastName, "Doe");
      expect(moderator.image.toString(), "http://example.com/image.jpg");
    });

    test('retrieveCurrentModerator throws exception on error', () async {
      when(mockClient.get(Uri.parse('http://example.com/api/moderator/current')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(repository.retrieveCurrentModerator(), throwsException);
    });

    test('sendModeratorRating sends rating successfully', () async {
      final moderatorRating = ModeratorRating(
        moderator: Moderator(
          id: 1,
          firstName: "John",
          lastName: "Doe",
          image: Uri.parse("http://example.com/image.jpg"),
        ),
        rating: FiveStarRating(stars: 5),
        comment: "Great job!",
      );

      when(mockClient.post(
        Uri.parse('http://example.com/api/moderator/rating'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Success', 200));

      await repository.sendModeratorRating(moderatorRating);

      verify(mockClient.post(
        Uri.parse('http://example.com/api/moderator/rating'),
        body: anyNamed('body'),
      )).called(1);
    });

    test('sendModeratorRating throws exception on error', () async {
      final moderatorRating = ModeratorRating(
        moderator: Moderator(
          id: 1,
          firstName: "John",
          lastName: "Doe",
          image: Uri.parse("http://example.com/image.jpg"),
        ),
        rating: FiveStarRating(stars: 5),
        comment: "Great job!",
      );

      when(mockClient.post(
        Uri.parse('http://example.com/api/moderator/rating'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response('Error', 404));

      expect(repository.sendModeratorRating(moderatorRating), throwsException);
    });
  });
}