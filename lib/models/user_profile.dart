class UserProfile {
  final String sex;
  final int age;
  final int heightFeet;
  final int heightInches;
  final int weightLbs;
  final double activityFactor;
  final String goal;
  final double proteinPct;
  final double carbPct;
  final double fatPct;

  final int calories;
  final int proteinGrams;
  final int carbGrams;
  final int fatGrams;

  UserProfile({
    required this.sex,
    required this.age,
    required this.heightFeet,
    required this.heightInches,
    required this.weightLbs,
    required this.activityFactor,
    required this.goal,
    required this.proteinPct,
    required this.carbPct,
    required this.fatPct,
    required this.calories,
    required this.proteinGrams,
    required this.carbGrams,
    required this.fatGrams,
  });

  Map<String, dynamic> toJson() => {
        'sex': sex,
        'age': age,
        'heightFeet': heightFeet,
        'heightInches': heightInches,
        'weightLbs': weightLbs,
        'activityFactor': activityFactor,
        'goal': goal,
        'proteinPct': proteinPct,
        'carbPct': carbPct,
        'fatPct': fatPct,
        'calories': calories,
        'proteinGrams': proteinGrams,
        'carbGrams': carbGrams,
        'fatGrams': fatGrams,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        sex: json['sex'],
        age: json['age'],
        heightFeet: json['heightFeet'],
        heightInches: json['heightInches'],
        weightLbs: json['weightLbs'],
        activityFactor: json['activityFactor'],
        goal: json['goal'],
        proteinPct: json['proteinPct'],
        carbPct: json['carbPct'],
        fatPct: json['fatPct'],
        calories: json['calories'],
        proteinGrams: json['proteinGrams'],
        carbGrams: json['carbGrams'],
        fatGrams: json['fatGrams'],
      );
}
