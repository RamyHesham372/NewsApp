// ignore_for_file: prefer_const_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../../layout/news_app/news/cubit/cubit.dart';
import '../../modules/news_app/webview/webview_screen.dart';

Widget defaultFormField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  String? Function(String)? onSubmit,
  String? Function(String)? onChanged,
  Function()? onTap,
  String? Function(String?)? validate,
  required String labelText,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isPassword = false,
}) =>
    TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate,
      obscureText: isPassword,
      onTap: onTap,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              ) : null,
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget buildNewsItem(article, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewScreen(url: '${article['url']}'));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: article['urlToImage'] != null
                      ? DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('${article['urlToImage']}')) : DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('images/empty.jpg')),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: NewsCubit.get(context).themeModeLight ? TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black) : TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                        // style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget newsBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildNewsItem(list[index], context),
        itemCount: list.length,
        separatorBuilder: (context, index) => myDivider(),
      ),
      fallback: (context) => isSearch
          ? Container()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );