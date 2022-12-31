import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:fridge_cook/src/data/repositories/data_achievements_repository.dart';
import 'package:fridge_cook/src/domain/entities/achievement.dart';
import 'package:fridge_cook/src/domain/repositories/achievements_repository.dart';

enum AchievementsRequestType { doFetch, doStep, doClaim, doReset }

class AchievementsUseCaseParams {
  final AchievementsRequestType type;
  final String id;

  AchievementsUseCaseParams(this.type, this.id);
}

class AchievementsUseCaseResponse {
  final List<Achievement> achievements;

  AchievementsUseCaseResponse(this.achievements);
}

class AchievementsUseCase
    extends UseCase<AchievementsUseCaseResponse, AchievementsUseCaseParams> {
  AchievementsRepository achievementsWorker = DataAchievementsRepository.shared;
  List<Achievement> fetchedAchievements;

  @override
  Future<Stream<AchievementsUseCaseResponse>> buildUseCaseStream(
      AchievementsUseCaseParams params) async {
    final StreamController<AchievementsUseCaseResponse> controller =
        StreamController();
        
    try {
      switch (params.type) {
        case AchievementsRequestType.doFetch:
          break;
        case AchievementsRequestType.doStep:
          var oldValue = fetchedAchievements
                  .firstWhere((element) => element.uid == params.id)
                  .currentStep;
          var newValue = oldValue + 1;
          DataAchievementsRepository.shared.update(params.id, newValue);
          break;
        case AchievementsRequestType.doClaim:
          DataAchievementsRepository.shared.claim(params.id);
          break;
        case AchievementsRequestType.doReset:
          await DataAchievementsRepository.shared.reset();
          break;
        default:
      }

      // the achievements stream is always rebuilt
      List<Achievement> achievements =
          await DataAchievementsRepository.shared.fetch();

      this.fetchedAchievements = achievements;
      controller.add(AchievementsUseCaseResponse(achievements));
      logger.finest('GetAchievementsUseCase successful.');
      controller.close();
    } catch (e) {
      logger.severe('GetAchievementsUseCase unsuccessful.');
      controller.addError(e);
    }
    return controller.stream;
  }
}
