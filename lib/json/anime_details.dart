import 'package:denuanime/features/anime/domain/entities/aired_model.dart';
import 'package:denuanime/features/anime/domain/entities/anime_details_model.dart';
import 'package:denuanime/features/anime/domain/entities/broadcast_model.dart';
import 'package:denuanime/features/anime/domain/entities/external_model.dart';
import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/anime/domain/entities/licensor_model.dart';
import 'package:denuanime/features/anime/domain/entities/producer_model.dart';
import 'package:denuanime/features/anime/domain/entities/relation_model.dart';
import 'package:denuanime/features/anime/domain/entities/streaming_model.dart';
import 'package:denuanime/features/anime/domain/entities/studio_model.dart';
import 'package:denuanime/features/anime/domain/entities/theme_song_model.dart';
import 'package:denuanime/features/anime/domain/entities/title_model.dart';
import 'package:denuanime/features/anime/domain/entities/trailer_model.dart';
import 'package:denuanime/features/common/entities/image_type_model.dart';

final animeDetailsSample = AnimeDetailsModel(
  mal_id: 37999,
  url:
      "https://myanimelist.net/anime/37999/Kaguya-sama_wa_Kokurasetai__Tensai-tachi_no_Renai_Zunousen",
  images: ImageTypeModel.fromJson({
    "jpg": {
      "image_url": "https://cdn.myanimelist.net/images/anime/1295/106551.jpg",
      "small_image_url":
          "https://cdn.myanimelist.net/images/anime/1295/106551t.jpg",
      "large_image_url":
          "https://cdn.myanimelist.net/images/anime/1295/106551l.jpg",
    },
    "webp": {
      "image_url": "https://cdn.myanimelist.net/images/anime/1295/106551.webp",
      "small_image_url":
          "https://cdn.myanimelist.net/images/anime/1295/106551t.webp",
      "large_image_url":
          "https://cdn.myanimelist.net/images/anime/1295/106551l.webp",
    },
  }),
  trailer: TrailerModel.fromJson({
    "youtube_id": null,
    "url": null,
    "embed_url":
        "https://www.youtube-nocookie.com/embed/Ti2kJ-GYO68?enablejsapi=1&wmode=opaque&autoplay=1",
    "images": {
      "image_url": null,
      "small_image_url": null,
      "medium_image_url": null,
      "large_image_url": null,
      "maximum_image_url": null,
    },
  }),
  approved: true,
  titles: [
    const TitleModel(
      type: "Default",
      title: "Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen",
    ),
    const TitleModel(type: "English", title: "Kaguya-sama: Love is War"),
    const TitleModel(type: "Japanese", title: "かぐや様は告らせたい～天才たちの恋愛頭脳戦～"),
  ],
  title: "Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen",
  title_english: "Kaguya-sama: Love is War",
  title_japanese: "かぐや様は告らせたい～天才たちの恋愛頭脳戦～",
  title_synonyms: [
    "Kaguya Wants to be Confessed To: The Geniuses' War of Love and Brains",
  ],
  type: "TV",
  source: "Manga",
  episodes: 12,
  status: "Finished Airing",
  airing: false,
  aired: AiredModel.fromJson({
    "from": "2019-01-12T00:00:00+00:00",
    "to": "2019-03-30T00:00:00+00:00",
    "string": "Jan 12, 2019 to Mar 30, 2019",
    "prop": {
      "from": {"day": 12, "month": 1, "year": 2019},
      "to": {"day": 30, "month": 3, "year": 2019},
    },
  }),
  duration: "25 min per ep",
  rating: "PG-13 - Teens 13 or older",
  score: 8.4,
  scored_by: 1221648,
  rank: 229,
  popularity: 51,
  members: 1954770,
  favorites: 42701,
  synopsis:
      "At the renowned Shuchiin Academy, Miyuki Shirogane and Kaguya Shinomiya are the student body's top representatives. Ranked the top student in the nation and respected by peers and mentors alike, Miyuki serves as the student council president. Alongside him, the vice president Kaguya—eldest daughter of the wealthy Shinomiya family—excels in every field imaginable. They are the envy of the entire student body, regarded as the perfect couple.\n\nHowever, despite both having already developed feelings for the other, neither are willing to admit them. The first to confess loses, will be looked down upon, and will be considered the lesser. With their honor and pride at stake, Miyuki and Kaguya are both equally determined to be the one to emerge victorious on the battlefield of love!",
  background: "",
  season: "winter",
  year: 2019,
  broadcast: BroadcastModel.fromJson({
    "day": "Saturdays",
    "time": "23:30",
    "timezone": "Asia/Tokyo",
    "string": "Saturdays at 23:30 (JST)",
  }),
  producers: [
    const ProducerModel(mal_id: 17, type: "anime", name: "Aniplex"),
    const ProducerModel(
      mal_id: 143,
      type: "anime",
      name: "Mainichi Broadcasting System",
    ),
    const ProducerModel(mal_id: 306, type: "anime", name: "Magic Capsule"),
    const ProducerModel(mal_id: 1365, type: "anime", name: "Shueisha"),
    const ProducerModel(
      mal_id: 1501,
      type: "anime",
      name: "JR East Marketing & Communications",
    ),
  ],
  licensors: [
    const LicensorModel(mal_id: 493, type: "anime", name: "Aniplex of America"),
  ],
  studios: [const StudioModel(mal_id: 56, type: "anime", name: "A-1 Pictures")],
  genres: [
    const GenreModel(mal_id: 4, type: "anime", name: "Comedy"),
    const GenreModel(mal_id: 22, type: "anime", name: "Romance"),
  ],
  explicit_genres: [],
  themes: [const GenreModel(mal_id: 23, type: "anime", name: "School")],
  demographics: [const GenreModel(mal_id: 42, type: "anime", name: "Seinen")],
  relations: [
    RelationModel.fromJson({
      "relation": "Sequel",
      "entry": [
        {
          "mal_id": 40591,
          "type": "anime",
          "name": "Kaguya-sama wa Kokurasetai? Tensai-tachi no Renai Zunousen",
          "url":
              "https://myanimelist.net/anime/40591/Kaguya-sama_wa_Kokurasetai_Tensai-tachi_no_Renai_Zunousen",
        },
      ],
    }),
    RelationModel.fromJson({
      "relation": "Adaptation",
      "entry": [
        {
          "mal_id": 90125,
          "type": "manga",
          "name": "Kaguya-sama wa Kokurasetai: Tensai-tachi no Renai Zunousen",
          "url":
              "https://myanimelist.net/manga/90125/Kaguya-sama_wa_Kokurasetai__Tensai-tachi_no_Renai_Zunousen",
        },
      ],
    }),
  ],
  theme: ThemeSongModel.fromJson({
    "openings": ["\"Love Dramatic feat. Rikka Ihara\" by Masayuki Suzuki"],
    "endings": [
      "\"Sentimental Crisis\" by halca",
      "\"Chikatto Chika Chika♡\" by Chika Fujiwara",
    ],
  }),
  external: [
    const ExternalModel(name: "Official Site", url: "https://kaguya.love/1st/"),
    const ExternalModel(
      name: "@anime_kaguya",
      url: "https://twitter.com/anime_kaguya",
    ),
  ],
  streaming: [
    const StreamingModel(
      name: "Crunchyroll",
      url: "http://www.crunchyroll.com/series-277391",
    ),
    const StreamingModel(name: "Netflix", url: "https://www.netflix.com/"),
  ],
);
