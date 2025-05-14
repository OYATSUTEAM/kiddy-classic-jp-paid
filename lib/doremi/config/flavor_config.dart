import '../global.dart';

enum GameFlavor { jaToon, jaHeon, enToon, enHeon }

class FlavorConfig {
  static GameFlavor get flavor {
    final flavorName = globalData.globalToHe == 'jaToon'
        ? String.fromEnvironment('FLAVOR', defaultValue: 'jaToon')
        : String.fromEnvironment('FLAVOR', defaultValue: 'jaHeon');
    return GameFlavor.values.firstWhere(
      (f) => f.toString().split('.').last == flavorName,
      orElse: () => GameFlavor.jaToon,
    );
  }

  static String get assetPath {
    switch (flavor) {
      case GameFlavor.jaToon:
        return 'assets/ja_toon';
      case GameFlavor.jaHeon:
        return 'assets/ja_heon';
      case GameFlavor.enToon:
        return 'assets/en_toon';
      case GameFlavor.enHeon:
        return 'assets/en_heon';
    }
  }
}

/*enum GameFlavor { jaToon, jaHeon, enToon, enHeon }

class FlavorConfig {
  static GameFlavor getFlavor(String flavorName) {
    return GameFlavor.values.firstWhere(
      (f) => f.toString().split('.').last == flavorName,
      orElse: () => GameFlavor.enToon,
    );
  }

  static String getAssetPath(String flavorName) {
    final flavor = getFlavor(flavorName);
    switch (flavor) {
      case GameFlavor.jaToon:
        return 'assets/ja_toon';
      case GameFlavor.jaHeon:
        return 'assets/ja_heon';
      case GameFlavor.enToon:
        return 'assets/en_toon';
      case GameFlavor.enHeon:
        return 'assets/en_heon';
    }
  }
}*/
