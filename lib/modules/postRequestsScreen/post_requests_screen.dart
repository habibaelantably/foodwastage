import 'package:flutter/material.dart';

class PostRequests extends StatelessWidget {
  const PostRequests({Key? key, required this.requests}) : super(key: key);
  final List requests;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.separated(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Text(requests[index]['name']),
                  Text(requests[index]['uId']),
                  Text(requests[index]['phone']),
                  Text(requests[index]['type']),
                  Text(requests[index]['email']),
                ],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 1.0,),
            itemCount: requests.length),
      ),
    );
  }
}
