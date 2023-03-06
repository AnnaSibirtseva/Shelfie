// import 'package:flutter/material.dart';
//
// class Tweet extends StatelessWidget {
//   final FeedModel model;
//   final Widget? trailing;
//   final bool isDisplayOnProfile;
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   const Tweet({
//     Key? key,
//     required this.model,
//     this.trailing,
//     this.isDisplayOnProfile = false,
//     required this.scaffoldKey,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.topLeft,
//       children: <Widget>[
//         /// Left vertical bar of a tweet
//         Positioned.fill(
//           child: Container(
//             margin: const EdgeInsets.only(
//               left: 38,
//               top: 75,
//             ),
//             decoration: BoxDecoration(
//               border: Border(
//                 left: BorderSide(width: 2.0, color: Colors.grey.shade400),
//               ),
//             ),
//           ),
//         ),
//         InkWell(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.only(
//                   top:  12,
//                 ),
//                 child: _TweetBody(
//                   isDisplayOnProfile: isDisplayOnProfile,
//                   model: model,
//                   trailing: trailing,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right: 16),
//                 child: TweetImage(
//                   model: model,
//                   type: type,
//                 ),
//               ),
//               Padding(
//                 padding:
//                 EdgeInsets.only(left: type == TweetType.Detail ? 10 : 60),
//                 child: TweetIconsRow(
//                   type: type,
//                   model: model,
//                   isTweetDetail: type == TweetType.Detail,
//                   iconColor: Theme.of(context).textTheme.caption!.color!,
//                   iconEnableColor: TwitterColor.ceriseRed,
//                   size: 20,
//                   scaffoldKey: GlobalKey<ScaffoldState>(),
//                 ),
//               ),
//               const SizedBox.shrink()
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class _TweetBody extends StatelessWidget {
//   final FeedModel model;
//   final Widget? trailing;
//   final bool isDisplayOnProfile;
//   const _TweetBody(
//       {Key? key,
//         required this.model,
//         this.trailing,
//         required this.isDisplayOnProfile})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double descriptionFontSize = type == TweetType.Tweet
//         ? 15
//         : type == TweetType.Detail || type == TweetType.ParentTweet
//         ? 18
//         : 14;
//     FontWeight descriptionFontWeight =
//     type == TweetType.Tweet || type == TweetType.Tweet
//         ? FontWeight.w400
//         : FontWeight.w400;
//     TextStyle textStyle = TextStyle(
//         color: Colors.black,
//         fontSize: descriptionFontSize,
//         fontWeight: descriptionFontWeight);
//     TextStyle urlStyle = TextStyle(
//         color: Colors.blue,
//         fontSize: descriptionFontSize,
//         fontWeight: descriptionFontWeight);
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         const SizedBox(width: 10),
//         SizedBox(
//           width: 40,
//           height: 40,
//           child: GestureDetector(
//             onTap: () {
//               // If tweet is displaying on someone's profile then no need to navigate to same user's profile again.
//               if (isDisplayOnProfile) {
//                 return;
//               }
//               Navigator.push(
//                   context, ProfilePage.getRoute(profileId: model.userId));
//             },
//             child: CircularImage(path: model.user!.profilePic),
//           ),
//         ),
//         const SizedBox(width: 20),
//         SizedBox(
//           width: context.width - 80,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Expanded(
//                     child: Row(
//                       children: <Widget>[
//                         ConstrainedBox(
//                           constraints: BoxConstraints(
//                               minWidth: 0, maxWidth: context.width * .5),
//                           child: TitleText(model.user!.displayName!,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w800,
//                               overflow: TextOverflow.ellipsis),
//                         ),
//                         const SizedBox(width: 3),
//                         model.user!.isVerified!
//                             ? customIcon(
//                           context,
//                           icon: AppIcon.blueTick,
//                           isTwitterIcon: true,
//                           iconColor: AppColor.primary,
//                           size: 13,
//                           paddingIcon: 3,
//                         )
//                             : const SizedBox(width: 0),
//                         SizedBox(
//                           width: model.user!.isVerified! ? 5 : 0,
//                         ),
//                         Flexible(
//                           child: customText(
//                             '${model.user!.userName}',
//                             style: TextStyles.userNameStyle,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         customText(
//                           '· ${Utility.getChatTime(model.createdAt)}',
//                           style:
//                           TextStyles.userNameStyle.copyWith(fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(child: trailing ?? const SizedBox()),
//                 ],
//               ),
//               model.description == null
//                   ? const SizedBox()
//                   : Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   UrlText(
//                     text: model.description!.removeSpaces,
//                     onHashTagPressed: (tag) {
//                       cprint(tag);
//                     },
//                     style: textStyle,
//                     urlStyle: urlStyle,
//                   ),
//                   // TweetTranslation(
//                   //   languageCode: model.lanCode,
//                   //   tweetKey: model.key!,
//                   //   description: model.description!,
//                   //   textStyle: textStyle,
//                   //   urlStyle: urlStyle,
//                   // ),
//                 ],
//               ),
//               if (model.imagePath == null && model.description != null)
//                 CustomLinkMediaInfo(text: model.description!),
//             ],
//           ),
//         ),
//         const SizedBox(width: 10),
//       ],
//     );
//   }
// }
//
// class _TweetDetailBody extends StatelessWidget {
//   final FeedModel model;
//   final Widget? trailing;
//   final TweetType type;
//   // final bool isDisplayOnProfile;
//   const _TweetDetailBody({
//     Key? key,
//     required this.model,
//     this.trailing,
//     required this.type,
//     /*this.isDisplayOnProfile*/
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double descriptionFontSize = type == TweetType.Tweet
//         ? context.getDimension(context, 15)
//         : type == TweetType.Detail
//         ? context.getDimension(context, 18)
//         : type == TweetType.ParentTweet
//         ? context.getDimension(context, 14)
//         : 10;
//
//     FontWeight descriptionFontWeight =
//     type == TweetType.Tweet || type == TweetType.Tweet
//         ? FontWeight.w300
//         : FontWeight.w400;
//     TextStyle textStyle = TextStyle(
//         color: Colors.black,
//         fontSize: descriptionFontSize,
//         fontWeight: descriptionFontWeight);
//     TextStyle urlStyle = TextStyle(
//         color: Colors.blue,
//         fontSize: descriptionFontSize,
//         fontWeight: descriptionFontWeight);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         model.parentkey != null &&
//             model.childRetwetkey == null &&
//             type != TweetType.ParentTweet
//             ? ParentTweetWidget(
//           childRetwetkey: model.parentkey!,
//           // isImageAvailable: false,
//           trailing: trailing,
//           type: type,
//         )
//             : const SizedBox.shrink(),
//         SizedBox(
//           width: context.width,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               ListTile(
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                 leading: GestureDetector(
//                   onTap: () {
//                     Navigator.push(
//                         context, ProfilePage.getRoute(profileId: model.userId));
//                   },
//                   child: CircularImage(path: model.user!.profilePic),
//                 ),
//                 title: Row(
//                   children: <Widget>[
//                     ConstrainedBox(
//                       constraints: BoxConstraints(
//                           minWidth: 0, maxWidth: context.width * .5),
//                       child: TitleText(model.user!.displayName!,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w800,
//                           overflow: TextOverflow.ellipsis),
//                     ),
//                     const SizedBox(width: 3),
//                     model.user!.isVerified!
//                         ? customIcon(
//                       context,
//                       icon: AppIcon.blueTick,
//                       isTwitterIcon: true,
//                       iconColor: AppColor.primary,
//                       size: 13,
//                       paddingIcon: 3,
//                     )
//                         : const SizedBox(width: 0),
//                     SizedBox(
//                       width: model.user!.isVerified! ? 5 : 0,
//                     ),
//                   ],
//                 ),
//                 subtitle: customText('${model.user!.userName}',
//                     style: TextStyles.userNameStyle),
//                 trailing: trailing,
//               ),
//               model.description == null
//                   ? const SizedBox()
//                   : Padding(
//                 padding: type == TweetType.ParentTweet
//                     ? const EdgeInsets.only(left: 80, right: 16)
//                     : const EdgeInsets.symmetric(horizontal: 16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     UrlText(
//                         text: model.description!.removeSpaces,
//                         onHashTagPressed: (tag) {
//                           cprint(tag);
//                         },
//                         style: textStyle,
//                         urlStyle: urlStyle),
//                   ],
//                 ),
//               ),
//               if (model.imagePath == null && model.description != null)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: CustomLinkMediaInfo(text: model.description!),
//                 )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }