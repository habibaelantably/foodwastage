
import 'dart:ui';

import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_States/foodStates.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodCubit, FoodStates>(
      builder: (BuildContext context, state) {
        return BuildCondition(
          condition: FoodCubit.get(context).postsList.isNotEmpty && FoodCubit.get(context).userModel != null,
          builder:(context) =>SingleChildScrollView(
            child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index)=>PostBuilder(
                    context,
                    FoodCubit.get(context).postsList[index],
                ),
                separatorBuilder: (context,index)=>const SizedBox(height: 10.0,),
                itemCount:FoodCubit.get(context).postsList.length),
          ),
          fallback:(context)=>const Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
 Widget PostBuilder(context,PostModel postModel)=>Column(
   children: [
     Card(
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(15.0),
       ),
       elevation: 5.0,
       color: Colors.grey[100],
       margin:  const EdgeInsets.symmetric(
           horizontal: 15.0
       ),
       child: Row(
         children:[
           Container(
             height: 155,
             width: 155,
             decoration: BoxDecoration(
                 borderRadius: const BorderRadius.only(topLeft:Radius.circular(10.0),
                     bottomLeft: Radius.circular(10.0)
                 ),
                 image: DecorationImage(
                     image: NetworkImage('${postModel.imageUrl1}'),
                     fit: BoxFit.cover
                 )
             ),

           ),
           const SizedBox(width: 10.0,),
           Expanded(
             child: Container
               (
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children:[
                   Text('${postModel.itemName}',
                     style:  Theme.of(context).textTheme.bodyText1,
                     overflow: TextOverflow.ellipsis,
                     maxLines: 1,
                   ),
                   const SizedBox(height: 7.0,),
                   Row(
                     children: [
                       CircleAvatar(
                         backgroundImage: NetworkImage('${postModel.userImage}'),
                       ),
                       const SizedBox(width: 5.0,),
                       Column(
                         children: [
                           Text('${postModel.userName}',
                               style:  Theme.of(context).textTheme.bodyText1!.copyWith(
                                   fontSize: 15,
                                   fontWeight: FontWeight.w800
                               )
                           ),
                           Text('${postModel.foodDonor}',
                               style:  Theme.of(context).textTheme.bodyText1!.copyWith(
                                   color: Colors.grey,
                                   fontSize: 10
                               )
                           )
                         ],
                       )
                     ],
                   ),


                 ],
               ),
             ),
           ),
           Container(
             height: 155,
             child: Column(
               crossAxisAlignment:CrossAxisAlignment.end,
               //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: [
                 const Padding(
                   padding: EdgeInsets.only(top: 5.0,right: 5.0),
                   child: Icon(Icons.favorite),
                 ),
                 const Spacer(),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   textBaseline: TextBaseline.alphabetic,
                   children:const [
                     Text('13',
                       style: TextStyle(
                           color: Colors.orange
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(bottom: 5.0,right: 5.0),
                       child: Icon(Icons.comment_outlined),
                     ),
                   ],
                 ),
               ],
             ),
           )

         ],
       ),

     ),
   ],
 );

