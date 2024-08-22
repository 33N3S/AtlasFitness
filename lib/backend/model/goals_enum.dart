enum FitGoals {
  loseWeight,
  gainMuscle,
}

extension FitGoalsExtension on FitGoals {
  String get goal {
    switch (this) {
      case FitGoals.loseWeight:
        return 'Lose Weight';
      case FitGoals.gainMuscle:
        return 'Gain Muscle';
      default:
        return '';
    }
  }
}
