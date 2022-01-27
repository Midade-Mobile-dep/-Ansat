// import 'package:audiobook/domain/cubit/ansat_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class RootApp extends StatelessWidget {
//   const RootApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return
//      BlocConsumer<AnsatCubit, AnsatState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = AnsatCubit.get(context);

//         return Scaffold(
//           body: cubit.bottomScreens[cubit.currentIndex],
//           bottomNavigationBar: BottomNavigationBar(
//             onTap: (index) {
//               cubit.changeBottom(index);
//             },
//             backgroundColor: Colors.black,
//             currentIndex: cubit.currentIndex,
//             selectedItemColor: Colors.white,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.home,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.favorite,
//                   size: 30,
//                   color: Colors.white,
//                 ),
//                 label: 'Favorite',
//               ),
//             ],
//           ),
//         );
//       },
//     );
  
  
  
//   }
// }
