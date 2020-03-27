
class Statistic {
  String country;
  int newConfirmed;
  int totalConfirmed;
  int newDeaths;
  int totalDeaths;
  int newRecovered;
  int totalRecovered;

  Statistic(
      this.country,
      this.newConfirmed,
      this.totalConfirmed,
      this.newDeaths,
      this.totalDeaths,
      this.newRecovered,
      this.totalRecovered
  );
  Statistic.fromJson(Map<String, dynamic> jsonData) {
    this.country = jsonData['Country'];
    this.newConfirmed = jsonData['NewConfirmed'];
    this.totalConfirmed = jsonData['TotalConfirmed'];
    this.newDeaths = jsonData['NewDeaths'];
    this.totalDeaths = jsonData['TotalDeaths'];
    this.newRecovered = jsonData['NewRecovered'];
    this.totalRecovered = jsonData['TotalRecovered'];
  }
}