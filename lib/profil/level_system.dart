class LevelSystem {
  int currentExp = 0;
  int expNeededForNextLevel = 1000;
  int currentLevel = 1;
  void addExp(int exp) {
    currentExp += exp;
    if (currentExp >= expNeededForNextLevel) {
      currentExp -= expNeededForNextLevel;
      currentLevel++;
    }
  }

  void updateLevel(double completedTasks) {
    addExp(completedTasks.toInt());
  }
}
