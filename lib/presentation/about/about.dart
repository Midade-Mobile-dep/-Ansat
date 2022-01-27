import '../resources/assets_manager.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';
import '../widget/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Aboutscreen extends StatefulWidget {
  const Aboutscreen({Key? key}) : super(key: key);

  @override
  _AboutscreenState createState() => _AboutscreenState();
}

class _AboutscreenState extends State<Aboutscreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: ColorManager.primary,
          appBar: AppBar(
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            leading: const BackArrow(),
            title: const Text(
              'عن التطبيق',
              // style: TextStyles.textstyleBold
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 130,
                ),
                Center(
                    child: Image.asset(
                  ImageAssets.logo,
                  scale: 8.3,
                )),
                const SizedBox(
                  height: 50,
                ),
                Expanded(
                    child: Text(
                  'أعطى الإسلام الصلاة منزلة كبيرة فهي أول ما أوجبه الله من العبادات، كما أنها أول عبادة يحاسب عليها المسلم يوم القيامة وقد فرضت ليلة المعراج. قال أنس بن مالك: فرضت الصلاة على النبي ليلة أسرى به خمسين صلاة، ثم نقصت حتى جعلت خمساً، ثم نودى يا محمد إنه لا يبدل القول لدي، وإن لك بهذه الخمس خمسين. وقال عبد الله بن قرط منقولاً قال رسول الله صلى الله عليه وسلم: «أول ما يحاسب به العبد يوم القيامة الصلاة، فإن صلحت صلح سائر عمله، وإن فسدت فسد سائر عمله.»',
                  style: getBoldStyle(color: ColorManager.white),
                  textScaleFactor: 1.25,
                  
                )),
              ],
            ),
          ),
        ));
  }
}
