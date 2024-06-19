/* 打印信息到控制台*/
void main() {
  print('Hello, World!');
}



/* 变量与流程控制语句*/
void main() {
    var name = 'Voyager I';
    var year = 1977;
    var antennaDiameter = 3.7;
    var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
    var image = {
        'tags': ['saturn'],
        'url': '//path/to/saturn.jpg'
    };

  if (year >= 2001) {
        print('21st century');
    } 
    else if (year >= 1901) {
        print('20th century');
    }

    for (final object in flybyObjects) {
        print(object);
    }

    for (int month = 1; month <= 12; month++) {
        print(month);
    }

    while (year < 2016) {   
        year += 1;
    }
}


/* 函数使用*/ 

int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}



void main() {
    var result = fibonacci(20);
    print(result);
}


/* 注释*/

// test 
/**test
test */


/* 导入*/
import 'dart:math'


/* 类*/
class Spacecraft {
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}


void main() {
    var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
    voyager.describe();

    var voyager3 = Spacecraft.unlaunched('Voyager III');
    voyager3.describe();
}


/* 枚举类型*/
enum PlanetType { terrestrial, gas, ice }

/// Enum that enumerates the different planets in our solar system
/// and some of their properties.
enum Planet {
    mercury(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
    venus(planetType: PlanetType.terrestrial, moons: 0, hasRings: false),
    earth(planetType: PlanetType.terrestrial, moons: 0, hasRings: false)
    uranus(planetType: PlanetType.ice, moons: 27, hasRings: true),
    neptune(planetType: PlanetType.ice, moons: 14, hasRings: true);

    /// A constant generating constructor
    const Planet(
      {required this.planetType, required this.moons, required this.hasRings});

    /// All instance variables are final
    final PlanetType planetType;
    final int moons;
    final bool hasRings;

    /// Enhanced enums support getters and other methods
    bool get isGiant =>
        planetType == PlanetType.gas || planetType == PlanetType.ice;
}

void main(){
    final yourPlanet = Planet.earth;

    if (!yourPlanet.isGiant) {
        print('Your planet is not a "giant planet".');
    }
}


/* 类的继承*/

class Spacecraft {
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}


class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}


/*Mixin 语法*/
class Spacecraft {
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years = DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}


mixin Piloted {
    int astronauts = 1;

    void describeCrew() {
        print('Number of astronauts: $astronauts');
    }
}

class PilotedCraft extends Spacecraft with Piloted {
    double altitude;

    PilotedCraft(super.name, DateTime super.launchDate, this.altitude);
}

void main(){
    PilotedCraft myAircraft = PilotedCraft('FlyingDutchman','1919.8.10','3000');
    myAircraft.describeCrew();
}


/*将类视为接口并实现*/
class Spacecraft {
    void test();
}

class MockSpaceship implements Spacecraft {
    void test(){
        print('test');
    }
}

void main(){
    MockSpaceship temp = MockSpaceship();
    temp.test();
}


/*定义抽象类并实现*/
abstract class Describable {
  void describe();

  void describeWithEmphasis() {
    print('=========');
    describe();
    print('=========');
  }
}

class Describer implements Describable {
    void describe(){
        print('this is a test')
    }
}

void main(){
    Describer des = Describer();
    des.describeWithEmphasis();
}


/*dart中的异常Plus异步*/

Future<void> describeFlybyObjects(List<String> flybyObjects) async {
  try {
    for (final object in flybyObjects) {
      var description = await File('$object.txt').readAsString();
      print(description);
    }
  } on IOException catch (e) {
    print('Could not describe object: $e');
  } finally {
    flybyObjects.clear();
  }
}

void main() {

  List<String> flybyObjects = ['object1', 'object2', 'nonExistentObject'];


  describeFlybyObjects(flybyObjects).then((_) {
    print('nothing wrong');
  }).catchError((error) {

    print('Error: $error');
  });
}

