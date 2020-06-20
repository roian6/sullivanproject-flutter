class SoundData {
  final int averageDecibel;
  final int maxDecibel;
  DateTime date = DateTime.now();

  SoundData({
    this.averageDecibel, this.maxDecibel, this.date
  });
}