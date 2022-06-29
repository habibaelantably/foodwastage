import 'package:flutter/material.dart';
import 'package:foodwastage/styles/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (){
                    makePhoneCall("+201129592697",context);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.phone,size: 32,color: defaultColor),
                      SizedBox(width: 10.0,),
                      Text("+201129592697",style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: (){
                    sendSms("+201129592697",context);
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.sms,size: 32,color: defaultColor),
                      SizedBox(width: 10.0,),
                      Text("+201129592697",style: TextStyle(fontSize: 16.0))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0,),
            InkWell(
              onTap: (){
                sendEmail('mahmoudnabil141981@gmail.com',context);
              },
              child: Row(
                children: const [
                  Icon(Icons.email,size: 32,color: defaultColor),
                  SizedBox(width: 10.0,),
                  Text("mahmoudnabil141981@gmail.com",style: TextStyle(fontSize: 16.0),)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> sendEmail(String email, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse("mailto:$email"))) {
      await launchUrl(Uri.parse("mailto:$email"));
    } else {
      throw 'Couldn\'nt send email to: $email';
    }
  }

  Future<void> makePhoneCall(String phone, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse("tel:$phone"))) {
      await launchUrl(Uri.parse("tel:$phone"));
    } else {
      throw 'Couldn\'t call: $phone';
    }
  }

  Future<void> sendSms(String phone, BuildContext context) async {
    if (await canLaunchUrl(Uri.parse("sms:$phone"))) {
      await launchUrl(Uri.parse("sms:$phone"));
    } else {
      throw 'Couldn\'t send sms to: $phone';
    }
  }


}
