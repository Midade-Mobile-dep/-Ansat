import 'package:audiobook/presentation/widget/slide_page_transitions.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/cubit/ansat_cubit.dart';
import '../../domain/models/Get_all_categories.dart';
import '../categoryItem/category_Item.dart';

import '../resources/color_manager.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CategoryGridView extends StatelessWidget {
  const CategoryGridView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AnsatCubit, AnsatState>(
        listener: (context, state) {},
        builder: (context, state) {
          GetAllCategory? catemodel = AnsatCubit.get(context).category;
          return catemodel != null
              ? SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AnimationLimiter(
                    child:
                     GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 3.1,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: catemodel.data!.length,
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 40),
                        itemBuilder: (BuildContext ctx, index) {
                          return AnimationConfiguration.staggeredGrid(
                            position: index,
                            duration: const Duration(milliseconds: 1000),
                            columnCount: 20,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                  child: GestureDetector(
                                onTap: () {
                                  pushSlide(
                                    context,
                                    screen: CategoryItem(
                                        image: catemodel.data![index]
                                            .audioArticlesThumbnail!,
                                        id: catemodel.data![index].id!),
                                  );
                                },
                                child: Container(
                                  // padding: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: Image.network(
                                    catemodel
                                        .data![index].audioArticlesThumbnail!,
                                    // color: ColorManager.primary,
                                  ),
                                  decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      border: Border.all(
                                        color: ColorManager.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              )),
                            ),
                          );
                        }),
                  ),
                )
              : Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 3.1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: 6,
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, bottom: 40),
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                 
                        },
                        child: Container(
                      // padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Text('k'),
                      decoration: BoxDecoration(
                          color: ColorManager.white,
                          border: Border.all(
                            color: ColorManager.grey,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                        ),
                      );
                    }),
              );
        });
  }
}
