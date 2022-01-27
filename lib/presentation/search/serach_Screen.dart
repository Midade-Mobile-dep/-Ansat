import 'package:audiobook/presentation/widget/slide_page_transitions.dart';

import '../../domain/cubit/ansat_cubit.dart';
import '../../domain/models/Serach_model.dart';
import '../audio_player/audio_player.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../widget/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);


  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  var form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AnsatCubit(),
        child: BlocConsumer<AnsatCubit, AnsatState>(
            listener: (context, state) {},
            builder: (context, state) {
              SearchModel? searchModel = AnsatCubit.get(context).search;
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Form(
                  key: form,
                  child: Scaffold(
                    
                      appBar: AppBar(
                        toolbarHeight: 80,
                        automaticallyImplyLeading: false,
    
            leading:const BackArrow(),
                        title: 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             const SizedBox(height: 10,),
                            TextFormField(
                              // keyboardType: keyboardType,
                              controller: searchController,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return "يحب ادخل النص";
                                }
                              },
                              onFieldSubmitted: (String text) {
                                AnsatCubit.get(context).getSearch(text);
                              },
              
                              decoration: InputDecoration(
                                contentPadding:const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
              
                                enabled: true,
                                hintText: 'بحث',
                                // hintStyle: TextStyles.textstyleMedium,
                                suffixIcon: InkWell(
                                  onTap: () {
                                    searchController.clear();
                                  },
                                  child:const Icon(Icons.close),
                                ),
              
                                prefixIcon: InkWell(
                                  onTap: () {
                                    AnsatCubit.get(context)
                                        .getSearch(searchController.text);
                                  },
                                  child:const Icon(Icons.search),
                                ),
              
                                filled: true,
                                fillColor:const Color(0xffEEEEEE),
                                focusColor: Colors.black,
                                // hoverColor: Colors.blue.shade100,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:const BorderSide(
                                    color: Color(0xffF9F9F9),
                                    width: 2.0,
                                  ),
                                ),
              
                                hoverColor:const Color(0xffF9F9F9),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:const BorderSide(
                                    color: Color(0xff98D453),
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                             const SizedBox(height: 5,),
                            if (state is AnsatLoadingSerachState)
                            
                              LinearProgressIndicator(color: ColorManager.primary,),
                          ],
                        ),
                      ),
                      body: searchModel != null
                          ? ListView.builder(
                              padding:const EdgeInsets.only(top: 20),
                              itemCount: searchModel.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin:const EdgeInsets.all(5),
                                  elevation: 20,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ListTile(
                                    
                                        onTap: () => pushSlide( context, 
                                                  screen:  SoundCloudTab(
                                                        link:
                                                            searchModel
                                                                .data![index]
                                                                .audios!.data!.link!,
                                                                
                                                              
                                                        title: searchModel
                                                            .data![index]
                                                            .title!,
                                                        imageUrl: 
                                                        searchModel
                                                            .data![index]
                                                            .smallThumbnail!)),
                                    title: Text(searchModel.data![index].title!),
                                    leading: SvgPicture.asset(
                                      ImageAssets.iconListen,
                                      // color: Colors.grey,
                                      // scale: 1.5,
                                    ),
                                    trailing:const Icon(Icons.arrow_back_ios_new),
                                  ),
                                );
                              })
                          : Container()),
                ),
              );
            }));
  }
}
