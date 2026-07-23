import 'dart:convert';

import 'package:denuanime/features/common/entities/image_type_model.dart';
import 'package:denuanime/features/common/presentation/custom_image_network.dart';
import 'package:denuanime/features/people/domain/entities/people_model.dart';
import 'package:denuanime/json/person_images.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';

class PersonDetailsView extends StatefulWidget {
  final PeopleModel peopleModel;
  const PersonDetailsView({super.key, required this.peopleModel});

  @override
  State<PersonDetailsView> createState() => _PersonDetailsViewState();
}

class _PersonDetailsViewState extends State<PersonDetailsView> {
  final List<ImageTypeModel>? personImages =
      (jsonDecode(person_images_json) as List?)
          ?.map((e) => ImageTypeModel.fromJson(e as Map<String, dynamic>))
          .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("VA Details")),
      body: CustomScrollView(
        //* body
        slivers: [
          //* Header
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
                  if (personImages?.isNotEmpty == true)
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        itemCount: personImages!.length,
                        itemBuilder: (context, index) {
                          return CustomImageNetwork(
                            personImages![index].jpg?.image_url ?? '',
                            height: 200,
                            boxFit: BoxFit.fitHeight,
                          );
                        },
                      ),
                    ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          secondary.withValues(alpha: 0.4),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_left),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          secondary.withValues(alpha: 0.4),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.keyboard_arrow_right),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
