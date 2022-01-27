import 'package:audiobook/presentation/audio_player/screens/player.dart';
import 'package:audiobook/presentation/widget/shareButton.dart';
import 'package:audiobook/presentation/widget/slide_page_transitions.dart';
import 'package:shimmer/shimmer.dart';

import '../../domain/cubit/ansat_cubit.dart';
import '../../domain/models/Get_category_items.dart';
import '../audio_player/audio_player.dart';
import '../resources/app_responsive.dart';
import '../resources/assets_manager.dart';
import '../widget/backGroundImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.id, required this.image})
      : super(key: key);
  final int id;
  final String image;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AnsatCubit()..getCategoryItems(id),
        child: BlocConsumer<AnsatCubit, AnsatState>(
            listener: (context, state) {},
            builder: (context, state) {
              GetCategoryItems? catemodel =
                  AnsatCubit.get(context).categoryItems;
              return BackgroundImage(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    SizedBox(
                      height: getheight(height: .17, context: context),
                    ),
                    Image.network(
                      image,
                      // fit: BoxFit.scaleDown,
                      // scale: 8,
                    ),
                    SizedBox(
                      height: getheight(height: .07, context: context),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 220,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: catemodel != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: catemodel.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    
                                    margin: const EdgeInsets.all(5),
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    child: Center(
                                      child: ListTile(
                                          onTap: () => pushSlide(context,
                                              screen: SoundCloudTab(
                                                  link: catemodel.data![index]
                                                      .audios!.audioData!.link!,
                                                  title: catemodel
                                                      .data![index].title!,
                                                  imageUrl: image)),
                                          leading: SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            child: Image.network(
                                              catemodel.data![index]
                                                  .audioArticlesThumbnail!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          title: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  ImageAssets.iconListen),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(catemodel
                                                  .data![index].title!),
                                            ],
                                          ),
                                          subtitle: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  ImageAssets.iconDate),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(catemodel
                                                  .data![index].createdAt!),
                                            ],
                                          ),
                                          trailing: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Row(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () => pushSlide(
                                                    context,
                                                    screen: Player(
                                                      items:catemodel ,
                                                      imageUrl: image,
                                                      title: catemodel
                                                          .data![index].title!,
                                                      audioImage: catemodel
                                                          .data![index]
                                                          .audioArticlesThumbnail!,
                                                      file: catemodel
                                                          .data![index]
                                                          .audios!
                                                          .audioData!
                                                          .file!,
                                                    ),
                                                  ),
                                                  child: Image.asset(
                                                    ImageAssets.playIcon,
                                                    scale: 2.5,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                ShareButton(
                                                  shareTitle:" ${catemodel
                                                      .data![index].title!},/n ${catemodel
                                                      .data![index].audios!.audioData!.file!}"
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  );
                                },
                              )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: 10,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      margin: const EdgeInsets.all(5),
                                      elevation: 10,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: ListTile(
                                          leading: SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: Text('')),
                                          title: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  ImageAssets.iconListen),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(''),
                                            ],
                                          ),
                                          subtitle: Row(
                                            children: [
                                              SvgPicture.asset(
                                                  ImageAssets.iconDate),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(''),
                                            ],
                                          ),
                                          trailing: Image.asset(
                                            ImageAssets.playIcon,
                                            scale: 2,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )),
                  ]));
            }));
  }
}
