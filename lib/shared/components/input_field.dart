import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  TextEditingController controller ;
  final String title;
  final String hint;
  final Widget? widget;
  final double? width;
  var validate;
  InputField({Key? key,
    required this.controller,
    required Function validate,
    required this.hint,
    this.width,
    required this.title,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.only(
                left: 15
            ),
            height: 60,
            width: width,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    cursorColor: Colors.indigo,
                    onChanged: (value){
                      controller = value as TextEditingController;
                    },
                    validator: (value) =>
                    value!.isEmpty ? 'empty' : null,
                    controller: controller,
                    autofocus: false,
                    readOnly: widget==null?false : true,
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: TextStyle(
                            color: Colors.grey[400]
                        ),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            )
                        ),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Colors.transparent
                            )
                        )
                    ),
                  ),
                ),
                Widget==null?Container():Container(child: widget,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
