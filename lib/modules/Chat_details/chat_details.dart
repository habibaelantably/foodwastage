
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';


class ChatDetails extends StatelessWidget
{
  UserModel? userModel;
  //MessageModel? model;
  TextEditingController messageController=TextEditingController();
  ChatDetails({this.userModel});

  @override
  Widget build(BuildContext context) {
    return Builder(
        builder: (context) {
          return BlocConsumer<FoodCubit,FoodStates>(
            builder: ( context, state) {
              return  Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage('${userModel!.image}'),
                      ),
                      SizedBox(width: 7.0,),
                      Text('${userModel!.name}')
                    ],
                  ),
                ),
                body: BuildCondition(
                    condition: FoodCubit.get(context).massages.length >0,
                    builder: (context)=>Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context,index){
                                  var message =FoodCubit.get(context).massages[index];
                                  if(FoodCubit.get(context).userModel!.uId == message.senderId ) {
                                    return buildMyMessage(message);
                                  }

                                  return buildMessage(message);
                                },
                                separatorBuilder: (context,state)=>const SizedBox(height: 10.0,),
                                itemCount: FoodCubit.get(context).massages.length),
                          ),
                          const SizedBox(height: 8.0,),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'type message here...'
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  color: Colors.deepOrangeAccent,
                                  child: MaterialButton(
                                    onPressed:(){
                                      FoodCubit.get(context).sendMessage(
                                          receiverId: userModel!.uId,
                                          dateTime: DateTime.now().toString(),
                                          text: messageController.text);
                                      messageController.text='';
                                    },
                                    child: const Icon(Icons.send,
                                      color: Colors.white,
                                    ),
                                    color:Colors.deepOrangeAccent,
                                    minWidth: 1.0,

                                  ),
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    ),
                    fallback: (context)=>  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(children: const [
                              Center(
                                child: Text('no messeges yet',style: TextStyle(color: Colors.grey),),)
                            ],),
                          ),
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 50.0,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: TextFormField(
                                      controller: messageController,
                                      decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'type message here...'
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
                                  color: Colors.deepOrange,
                                  child: MaterialButton(
                                    onPressed:(){
                                      FoodCubit.get(context).sendMessage(
                                          receiverId: userModel!.uId,
                                          dateTime: DateTime.now().toString(),
                                          text: messageController.text);
                                      messageController.text='';
                                    },
                                    child: const Icon(Icons.send,
                                      color: Colors.white,
                                    ),
                                    color:Colors.deepOrangeAccent,
                                    minWidth: 1.0,

                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ),

              );
            },
            listener: ( context,  state) {  },

          );
        }
    );
  }

  Widget buildMessage( model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        color: Colors.grey[400],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0 ,
        vertical: 10.0,
      ),
      child: Text(model.text),
    ),
  );
  Widget buildMyMessage( model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        color: Colors.deepOrangeAccent.withOpacity(0.2),
      ),
      padding:const EdgeInsets.symmetric(
        horizontal: 5.0 ,
        vertical: 10.0,
      ),
      child: Text(model.text),
    ),
  );
}