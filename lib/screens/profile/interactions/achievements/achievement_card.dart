import 'package:flutter/material.dart';
import 'package:shelfie_diploma_app/components/constants.dart';
import 'package:shelfie_diploma_app/components/image_constants.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../models/achivment.dart';
import '../../../../models/parser.dart';

class AchievementCard extends StatelessWidget {
  final Achievement achievement;

  const AchievementCard({
    Key? key,
    required this.achievement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10, right: 5),
          padding: const EdgeInsets.all(5),
          height: size.height * 0.25,
          width: size.width * 0.9,
          child: Row(
            children: [
              Container(
                width: size.width * 0.35,
                height: achievement.getLevelInfo().getNumber() == 3
                    ? size.height
                    : size.height * 0.21,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  image: DecorationImage(
                    opacity:
                        achievement.getLevelInfo().getNumber() == 0 ? 0.4 : 1,
                    image: NetworkImage(achievement.getLevelInfo().getImage()),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(achievement.getName(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 18.0)),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(achievement.getDesc(),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: darkGrayColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0)),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  achievement.getLevelInfo().getReachedDate() ==
                                          null
                                      ? "Не получено"
                                      : parseDateTimeToDMY(achievement
                                          .getLevelInfo()
                                          .getReachedDate()!),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800)),
                              const Spacer(),
                              Container(
                                child: CircularPercentIndicator(
                                  radius: 30,
                                  lineWidth: 8,
                                  backgroundColor: secondaryColor,
                                  progressColor: primaryColor,
                                  percent: achievement.getCurValue() /
                                      achievement.getLevelInfo().getGoal(),
                                  center: Text(
                                    achievement.getLevelInfo().getNumber() == 3
                                        ? achievement
                                            .getLevelInfo()
                                            .getGoal()
                                            .toString()
                                        : "${achievement.getCurValue()}/${achievement.getLevelInfo().getGoal()}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize:
                                            "${achievement.getCurValue()}/${achievement.getLevelInfo().getGoal()}"
                                                        .length >
                                                    5
                                                ? 10
                                                : 12),
                                  ),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  animation: true,
                                  animationDuration: 1000,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
