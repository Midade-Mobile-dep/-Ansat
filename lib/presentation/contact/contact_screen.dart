
import '../../domain/cubit/ansat_cubit.dart';
import '../resources/app_responsive.dart';
import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../widget/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:url_launcher/url_launcher.dart' as Launcher;

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    Future _openUrl({String? url}) async {
      if (await Launcher.canLaunch(url!)) await Launcher.launch(url);
    }

    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var descriptionController = TextEditingController();
    var form = GlobalKey<FormState>();
    List<Map<String, dynamic>> _socialMedia = [
      {
        "img": "fa",
        "url": '',
      },
      {
        "img": "tw",
        "url": '',
      },
      {
        "img": "yo",
        "url": 'https://www.youtube.com/channel/UCWogzhQ57dQ_v8ag0MFCU8w',
      },
      {
        "img": "sc",
        "url": 'https://soundcloud.com/user-66672465',
      },
    ];

    // show the dialog
Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // title: const Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
             
              Text('تم ارسال الرساله بنجاح', style: TextStyle(), textAlign: TextAlign.end,),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('تم'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AnsatCubit, AnsatState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                // toolbarHeight: 80,

                title: const Text('اتصل بنا'),
                centerTitle: true,

                automaticallyImplyLeading: false,

                leading: const BackArrow(),
              ),
              body: Form(
                key: form,
                child: Container(
                  // width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(color: Colors.white10
                      // image:  DecorationImage(
                      //   image: AssetImage(ImageAssets.splashLogo),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  child: Padding(
                    padding: const  EdgeInsets.all(15.0),
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SizedBox(
                          height: getheight(context: context, height: 0.15),
                        ),
                        Center(
                            child: Image.asset(
                          ImageAssets.logo,
                          scale: 8.8,
                        )),
                        SizedBox(
                          height: getheight(context: context, height: 0.085),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            textformfield(
                                name: 'الاسم',
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                textEditingController: nameController,
                                validator: "ادخل النص"),
                            SizedBox(
                              height: getheight(context: context, height: 0.04),
                            ),
                            textformfield(
                                name: "البريد الالكترونى",
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                textEditingController: emailController,
                                validator: "ادخل النص"),
                            SizedBox(
                              height: getheight(context: context, height: 0.04),
                            ),
                            textformfield(
                                name: "نص الرساله",
                                line: 8,
                                keyboardType: TextInputType.multiline,
                                textInputAction: TextInputAction.done,
                                textEditingController: descriptionController,
                                validator: "ادخل النص"),
                          ],
                        ),
                        SizedBox(
                          height: getheight(context: context, height: 0.1),
                        ),
                        InkWell(
                          onTap: () async {
                            if (form.currentState!.validate()) {
                              await _openUrl(
                                      url:
                                          'mailto:contact@midade.com?subject=${descriptionController.text}&body=${nameController.text}\n${nameController.text}\n${descriptionController.text}')
                                  .then((value) =>
                                   _showMyDialog())
                                  .catchError(
                                      (Error) => print('{Error.toString()}'));
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 50, left: 50),
                            //  margin: const EdgeInsets.only(top: 15 , ),
                            alignment: Alignment.center,
                            width: getwidth(context: context, width: 0.7),
                            height: getheight(context: context, height: 0.14),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color:const Color(0xff03a9f4),
                              ),

                              color:const Color(0xff03a9f4),
                              //  Color(0xFF0E3311).withOpacity(0.5),
                              borderRadius:
                                 const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: const Text(
                              " ارسال الرساله",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xffFFFFFF),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            ;
          }),
    );
  }

  TextFormField textformfield({
    required String name,
    required keyboardType,
    required textInputAction,
    required TextEditingController ? textEditingController,
    required String validator,
    int line = 1,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: textEditingController,
      validator: (String? value) {
        if (value!.isEmpty) {
          return validator;
        }
      },
      // scrollPadding: const EdgeInsets.only(right: 20),
      textInputAction: textInputAction,
      decoration: InputDecoration(
        // contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),

        enabled: true,
        hintText: name,
        hintStyle: getLightStyle(color: ColorManager.darkPrimary),

        // prefixIcon: Image.asset(
        //   'assets/Images/Home/$imageName.png',
        //   scale: 1.2,
        // ),

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

        hoverColor: Color(0xffF9F9F9),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: ColorManager.darkGrey,
            width: 1.0,
          ),
        ),
      ),
      maxLines: line,
    );
  }
}
