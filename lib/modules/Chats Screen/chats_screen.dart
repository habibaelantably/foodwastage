
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/modules/Chat_details/chat_details.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';


class ChatsScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<FoodCubit,FoodStates>(
      listener: (context,state)
      {

      },
      builder: (context,state){
        return BuildCondition(
          condition: FoodCubit.get(context).chatUsers.length >0,
          builder: (context)=>ListView.separated(
              itemBuilder: (context,index)=>buildChatItem(FoodCubit.get(context).chatUsers[index],context),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: FoodCubit.get(context).chatUsers.length),
          fallback:(context)=>Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  Widget buildChatItem(UserModel model,context)=>InkWell(
    onTap:(){
      FoodCubit.get(context).massages=[];
      navigateTo(context, ChatDetails(userModel: model,));} ,
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          SizedBox(width: 5.0,),
          Text('${model.name}',
            //style: Theme.of(context).textTheme.bodyText1
          ),
        ],
      ),
    ),
  );

}