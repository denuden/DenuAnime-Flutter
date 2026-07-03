import 'package:denuanime/features/anime/domain/entities/genre_model.dart';
import 'package:denuanime/features/common/entities/base_image_model.dart';
import 'package:denuanime/features/common/entities/image_type_model.dart';
import 'package:denuanime/features/main/presentation/common/drawer_home.dart';
import 'package:denuanime/features/main/presentation/common/genre_item.dart';
import 'package:denuanime/features/people/presentation/common/person_item_view.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //? =========== variable
  int _selectedIndex = 0;

  //? ============ functions
  void _onMenuSelection(int index) {
    setState(() {
      _selectedIndex = index;
    });

    //* close drawer
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* ================= appbar
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
        ],
      ),
      //* =============== drawer
      drawer: HomeDrawer(
        selected: _selectedIndex,
        onSelect: (index) {
          _onMenuSelection(index);
        },
      ),

      //* ============== body
      body: ListView(
        children: [
          //*-------------- People List
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "TOP PEOPLE",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton.icon(
                    onPressed: () {},
                    label: Text("View all"),
                    icon: Icon(Icons.keyboard_arrow_right),
                    iconAlignment: IconAlignment.end,
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      minimumSize: const Size(
                        0,
                        0,
                      ), // removes default min constraints
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 110,
                child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: PersonItemView(
                        people: PeopleModel(
                          name: "Tomokazu Seki",
                          birthday: "1972-09-08T00:00:00+00:00",
                          images: ImageTypeModel(
                            jpg: BaseImagesModel(
                              imageUrl:
                                  "https://cdn.myanimelist.net/r/84x124/images/characters/7/618735.jpg?s=9902344694bb6579f0f271c3b9729ed0",
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          ),

          SizedBox(height: 8),
          Divider(thickness: 0.2),
          SizedBox(height: 16),

          //* ---------------------- Filter
          Row(
            children: [
              Icon(Icons.filter_alt, color: primaryDark),
              SizedBox(width: 4),
              Text("Filter", style: TextStyle(color: primaryDark)),
              SizedBox(width: 8),

              SizedBox(
                height: 22,
                child: VerticalDivider(
                  width: 1,
                  thickness: 0.2,
                  color: inversePrimary,
                ),
              ),
              SizedBox(width: 8),

              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GenreItem(
                          onSelect: (value) {
                            // list[index].isSelected = value
                          },
                          genre: GenreModel(
                            name: "Action",
                            isSelected: index == 1 ? true : false,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          //* --------------- Carousel Anime
          SizedBox(height: 8),
          SizedBox(
            height: 200,
            child: Container(
              decoration: BoxDecoration(color: Colors.black),

              child: CarouselView.weighted(
                backgroundColor: Colors.red,
                itemSnapping: true,
                flexWeights: [4, 1],
                scrollDirection: Axis.horizontal,

                children: List<Widget>.generate(10, (int index) {
                  return Center(
                    child: Text(
                      'Item $index',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ),
            ),
          ),

          //*===== END COLUMN
        ],
      ),
    );
  }
}
