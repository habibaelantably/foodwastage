import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodwastage/models/Comments_model.dart';
import 'package:foodwastage/models/User_model.dart';
import 'package:foodwastage/models/post_model.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';
import 'package:foodwastage/styles/colors.dart';

// ignore: must_be_immutable
class CommentsScreen extends StatefulWidget {
  String? postId;
  UserModel? model;
  PostModel? postModel;

  CommentsScreen(this.postId, this.model, this.postModel, {Key? key})
      : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  TextEditingController commentController = TextEditingController();
  bool enableButton = false;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocConsumer<FoodCubit, FoodStates>(
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: BuildCondition(
              condition: FoodCubit.get(context).comments.isNotEmpty,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => commentBuilder(
                              context,
                              FoodCubit.get(context).comments[index],
                              index),
                          separatorBuilder: (context, state) => myDivider(),
                          itemCount: FoodCubit.get(context).comments.length),
                    ),
                    const SizedBox(
                      height: 5.0,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of(context)!.commentsTextFieldHint),
                                onChanged: (String value) {
                                  enableButton = value.isNotEmpty;
                                  FoodCubit.get(context)
                                      .emit(CommentsButtonActivationState());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                            child: MaterialButton(
                              onPressed: enableButton
                                  ? () {
                                      FoodCubit.get(context).addComment(context,
                                          postId: widget.postId,
                                          text: commentController.text,
                                          postModel: widget.postModel);
                                      commentController.clear();
                                    }
                                  : null,
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              color: enableButton
                                  ? Colors.deepOrange
                                  : Colors.grey,
                              minWidth: 1.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              fallback: (context) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state is GetCommentsLoadingState
                        ? const CircularProgressIndicator()
                        : state is GetCommentsSuccessState
                            ? Expanded(
                              child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.commentsScreenFallback,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                        color: defaultColor),
                                  ),
                                ),
                            )
                            : const SizedBox(),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                controller: commentController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of(context)!.commentsTextFieldHint),
                                onChanged: (String value) {
                                  enableButton = value.isNotEmpty;
                                  FoodCubit.get(context)
                                      .emit(CommentsButtonActivationState());
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                            child: MaterialButton(
                              onPressed: enableButton
                                  ? () {
                                      FoodCubit.get(context).addComment(context,
                                          postId: widget.postId,
                                          text: commentController.text,
                                          postModel: widget.postModel);
                                    }
                                  : null,
                              child: const Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                              color: enableButton
                                  ? Colors.deepOrange
                                  : Colors.grey,
                              minWidth: 1.0,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {},
      );
    });
  }

  Widget commentBuilder(context, CommentsModel _commentModel, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage('${_commentModel.image}'),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text('${_commentModel.name}'),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text('${_commentModel.text}',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    // height: 1.2
                    )),
          ],
        ),
      );
}
