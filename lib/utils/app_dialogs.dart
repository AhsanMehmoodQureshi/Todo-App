import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'app_image.dart';


class AppsDialogs {


  static Future statusDialog(BuildContext context,
      String dialogType, String message,{Function? onCompletion}) {
   return

    showDialog(
      context:  context,
      builder: (context) {
        return Container(
          width: double.infinity, // Full width
          alignment: Alignment.bottomCenter, // Align at the bottom
          child: AlertDialog(

            alignment: Alignment.bottomCenter,
            insetPadding: const EdgeInsets.all(20),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            contentPadding: const EdgeInsets.only(top: 15.0,),
            backgroundColor: Colors.white,
            elevation: 5.0,
            title: Center(
              child: Lottie.asset(
                dialogType == 'alert_dialog'
                    ? AppImage.alertJson
                    : dialogType == 'error_dialog'
                    ? AppImage.errorJson
                    : dialogType == 'success_dialog'
                    ? AppImage.successJson
                    : AppImage.alertJson,
                height: 70,
              ),
            ),
            titleTextStyle: Theme.of(context).textTheme.headlineMedium,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 16
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              const SizedBox(
                height: 12,
              ),
              Center(
                  child:
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        if (onCompletion != null) {
                          Navigator.of(context).pop(false);
                          onCompletion();
                        } else {
                          Navigator.of(context).pop(false);
                        }
                      },
                      child: const Text(
                        'OK',
                      ),
                    ),
                  )
              ),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        );
      },
    );


  }


  // static tokeExpireMessage() {
  //   Fluttertoast.showToast(
  //       msg: 'Token Expire!!',
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }



}
