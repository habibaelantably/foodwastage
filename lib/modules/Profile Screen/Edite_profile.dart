import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foodwastage/shared/components/reusable_components.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_cubit.dart';
import 'package:foodwastage/shared/cubit/Food_Cubit/food_states.dart';


class EditProfile extends StatelessWidget
{
var nameController =TextEditingController();
var phoneController =TextEditingController();
var emailController =TextEditingController();
var countryController =TextEditingController();
double rating=0;


@override
Widget build(BuildContext context)
{
  return BlocConsumer<FoodCubit,FoodStates>
    (
    listener: (context, state) {},
    builder: (context, state)
    {

      var profileImage =FoodCubit.get(context).profileImage;
      var userModel = FoodCubit.get(context).userModel;

      nameController.text = userModel!.name!;
      phoneController.text = userModel.phone!;
      emailController.text = userModel.email!;
      countryController.text = userModel.country!;

      return Scaffold(
        appBar:AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,

            ),
            onPressed: (){},
          ),
        ),

        body: Container(
          padding: EdgeInsets.only(left :16,
              right: 16,
              top: 25),
          child:
          ListView(
            children: [
             //// if(state is FoodUserUpdateLoadingState)
                LinearProgressIndicator(),
              //if(state is FoodUserUpdateLoadingState)

                const SizedBox(height: 15,),

              const SizedBox(height: 15,),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height:130 ,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color:Theme.of(context).scaffoldBackgroundColor, ),
                        boxShadow: [
                          BoxShadow(spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0,10)

                          ),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: profileImage == null ? NetworkImage("${userModel.image}") : FileImage(profileImage) as ImageProvider,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,

                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width:4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.orange,
                        ),
                        child:IconButton(
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.grey,

                          ),
                          onPressed: (){
                            FoodCubit.get(context).getprofileImage();
                          },
                        ),
                      ),
                    ),

                  ],),

              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children:const [
                    Text("USER A.USER",
                    style: TextStyle(fontSize: 18,
                        fontWeight: FontWeight.w500),),],
                ),
              ),

              const SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      minRating:1 ,
                      itemCount: 5,
                      itemSize: 40,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4,),
                      itemBuilder: (context,_) => const Icon(Icons.stars,color: Colors.amber,),
                      updateOnDrag: true,
                      onRatingUpdate: (rating){
                        print (rating);
                      },),
                  ],
                ),
              ),

              const SizedBox(height: 15,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.center,
                  children: const [
                    Text("Edit Profile",
                    style: TextStyle(
                        color:Colors.orange,
                        fontSize: 20,

                        fontWeight: FontWeight.w500),
                  ),
                  ],
                ),
              ),
              defaultFormField(
                  controller: nameController,
                  type: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'enter your name';
                    }
                    return null;
                  },
                  prefix: Icons.person,
                  label: 'name'
              ),
              SizedBox(height: 5,),
              defaultFormField(
                  controller: phoneController,
                  type: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'enter your phone';
                    }
                    return null;
                  },
                  prefix: Icons.phone,
                  label: 'phone'
              ),
              const SizedBox(height: 5,),

              defaultFormField(
                  controller: emailController,
                  type: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'enter your Email';
                    }
                    return null;
                  },
                  prefix: Icons.email,
                  label: 'email'
              ),
              const SizedBox(height: 5,),

              defaultFormField(
                  controller: countryController,
                  type: TextInputType.text,
                  validator: (value)
                  {
                    if(value!.isEmpty){
                      return 'enter your country';
                    }
                    return null;
                  },
                  prefix: Icons.vpn_lock,
                  label: 'country',
              onTap: () {
                 showCountryPicker(
                 context: context,
                 showPhoneCode: false,
                 showWorldWide: false,
                 onSelect: (Country country) {
                 countryController.text =
                 country.displayNameNoCountryCode.toString();
              },
                 );}



              ),

              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 20),
                child: MaterialButton(
                  color: Colors.orange,


                  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)) ,
                  onPressed: () {
                    FoodCubit.get(context).UpdateUsers(
                      name: nameController.text,
                      phone:phoneController.text,
                      email:emailController.text,
                      country:countryController.text,
                      context: context

                    );
                  },
                  child: const Text("Save",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),
                  elevation: 5,

                ),
              ),
            ],
          ),
        ),

      );
    },
  );
}

}