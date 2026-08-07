import 'package:denuanime/features/people/domain/entities/voices_model.dart';
import 'package:denuanime/features/people/presentation/common/person_character_item.dart';
import 'package:denuanime/theme/dark_mode.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PersonDetailsViewSkeleton extends StatelessWidget {
  const PersonDetailsViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CustomScrollView(
        //* body
        slivers: [
          //* Header
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
                  if (true)
                    SizedBox(
                      height: 200,
                      child: PageView.builder(
                        onPageChanged: (index) {},
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Bone.square(size: 200),
                              ),
                            ], //*end image stack
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
                  Positioned(
                    bottom: 8,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2),
                          child: Icon(
                            Icons.circle,
                            size: 10,
                            color: textSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ], //*end stack
              ),
            ),
          ),

          //*Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        ' Unknown Name',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(width: 10),
                      const Text("sgwegw"),
                    ],
                  ),
                  const Text("Alternate name:  NA"),

                  const SizedBox(height: 16),
                  //*birthday
                  Row(
                    children: [
                      const Icon(Icons.calendar_month, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "MMMM dd, yyyy",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: inversePrimary),
                      ),
                    ],
                  ),
                  //*favorites
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.favorite, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        "fwgwgwgw",
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: inversePrimary),
                      ),
                    ],
                  ),
                  //*Link
                  Row(
                    children: [
                      const Icon(Icons.link, size: 20, color: Colors.blue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '---',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blue,
                              ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: Text(
                      'Nondescript',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: white,
                        height: 1.5,
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "See more",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ], // * end column
              ),
            ),
          ),

          //* ====== VOICES
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Text("Voices", style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
              ],
            ),
          ),

          SliverList.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return PersonCharacterItem(
                voicesModel: const VoicesModel(),
                onClick: () {},
              );
            },
          ),
        ], //* end
      ),
    );
  }
}
