class LevelSystem {
  int totalExp = 0;
  int currentExp = 0;
  int expNeededForNextLevel = 1000;
  int currentLevel = 1;

  void addExp(int exp) {
    totalExp += exp;
    if (totalExp >= expNeededForNextLevel) {
      currentLevel = totalExp ~/ expNeededForNextLevel;
      currentExp = totalExp - (currentLevel * expNeededForNextLevel);
    }
  }

  void updateLevel(double completedTasks) {
    addExp(completedTasks.toInt());
  }
}
