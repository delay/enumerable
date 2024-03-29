import 'package:enumerable/enumerable.dart';
import 'package:test/test.dart';

void main() {
  _testAggregate();
  _testAll();
  _testAny();
  _testAppend();
  _testAverage();
  _testCast();
  _testConcat();
  _testContains();
  _testCount();
  _testDefaultIfEmpty();
  _testDistinct();
  _testElementAt();
  _testElementAtOrDefault();
  _testExcept();
  _testFirst();
  _testFirstOrDefault();
  _testGroupBy();
  _testGroupJoin();
  _testIntersect();
  _testJoin();
  _testLast();
  _testLastOrDefault();
  _testMax();
  _testMin();
  _testOfType();
  _testOrderBy();
  _testPrepend();
  _testSelect();
  _testSelectMany();
  _testSequenceEqual();
  _testSingle();
  _testSingleOrDefault();
  _testSkip();
  _testSkipWhile();
  _testSum();
  _testTake();
  _testTakeWhile();
  _testThenBy();
  _testToDictionary();
  _testToLookup();
  _testUnion();
  _testWhere();
  _testZip();
}

final petOwners = _generatePetOwners();

final pets = _generatePets();

Iterable<PetOwner> _generatePetOwners() {
  return [
    PetOwner("a")..pets = [Pet("a1", 1)],
    PetOwner("b")..pets = [Pet("b1", 1), Pet("b2", 2)],
    PetOwner("c")..pets = [Pet("c1", 1), Pet("c2", 2), Pet("c3", 3)],
  ]..toList().forEach((petOwner) {
      for (final pet in petOwner.pets) {
        pet.owner = petOwner;
      }
    });
}

Iterable<Pet> _generatePets() {
  return petOwners.selectMany((e) => e.pets);
}

void _testAggregate() {
  test("Aggregate", () {
    {
      var data = [1, 0, 0, 0, 0];
      var expected = 16;
      var result = data.aggregate((r, e) => r + r);
      expect(result, expected);
    }
    //
    {
      var data = [1, 2, 3, 4];
      var expected = 10;
      var result = data.aggregate((r, e) => r + e);
      expect(result, expected);
    }
    //
    {
      var data = ["a", "b", "c", "d"];
      var expected = "a, b, c, d";
      var result = data.aggregate((r, e) => "$r, $e");
      expect(result, expected);
    }
    //
    {
      var data = [10, 20, 30, 40];
      var expected = 1200000;
      var result = data.aggregate$1(5, (r, e) => r * e);
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var expected = 41;
      var result = data.aggregate$1(41, (r, e) => r + e);
      expect(result, expected);
    }
    //
    {
      var data = [10.0, 20.0, 30.0, 40.0];
      var expected = 1200000;
      var result =
          data.aggregate$2<double, int>(5.0, (r, e) => r * e, (r) => r.round());
      expect(result, expected);
    }
  });
}

void _testAll() {
  test("All", () {
    {
      var data = <int>[];
      var expected = true;
      var result = data.all((e) => e == 0);
      expect(result, expected);
    }
    //
    {
      var data = [0];
      var expected = true;
      var result = data.all((e) => e == 0);
      expect(result, expected);
    }
    //
    {
      var data = [0, 1];
      var expected = false;
      var result = data.all((e) => e == 0);
      expect(result, expected);
    }
  });
}

void _testAny() {
  test("Any", () {
    {
      var data = <int>[];
      var expected = false;
      var result = data.any$();
      expect(result, expected);
    }
    //
    {
      var data = [0];
      var expected = true;
      var result = data.any$();
      expect(result, expected);
    }
    //
    {
      var data = [0];
      var expected = true;
      var result = data.any$((e) => e == 0);
      expect(result, expected);
    }
    //
    {
      var data = [0];
      var expected = false;
      var result = data.any$((e) => e != 0);
      expect(result, expected);
    }
    //
    {
      var data = [1, 0];
      var expected = true;
      var result = data.any$((e) => e == 0);
      expect(result, expected);
    }
    //
    {
      var data = [0, 0];
      var expected = false;
      var result = data.any$((e) => e != 0);
      expect(result, expected);
    }
  });
}

void _testAppend() {
  test("Append", () {
    {
      var data = [1, 2];
      var expected = [1, 2, 3];
      var query = data.append(3);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testAverage() {
  test("Average", () {
    {
      var data = [0, 1, 2, 3, 4];
      var expected = 2.0;
      var result = data.average();
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4];
      var result = data.average((e) => e * 10);
      var expected = 20.0;
      expect(result, expected);
    }
  });
}

void _testCast() {
  test("Cast", () {
    {
      var data = <Object>["mango", "apple", "lemon"];
      var expected = ["mango", "apple", "lemon"];
      var query = data.cast$<String>();
      var result = query;
      expect(result, expected);
    }
  });
}

void _testConcat() {
  test("Concat", () {
    {
      var data1 = [0, 1, 2, 3, 4];
      var data2 = [5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var query = data1.concat(data2);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data1 = <int>[];
      var data2 = <int>[];
      var expected = <int>[];
      var query = data1.concat(data2);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testContains() {
  test("Contains", () {
    {
      var data = [0, 1, 2, 3, 4];
      var expected = true;
      var result = data.contains$(2);
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4];
      var result = data.contains$(5);
      var expected = false;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var result = data.contains$(null);
      var expected = false;
      expect(result, expected);
    }
  });
}

void _testCount() {
  test("Count", () {
    {
      var data = [0, 1, 2, 3, 4];
      var expected = 5;
      var result = data.count();
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4];
      var result = data.count((e) => e > 0);
      var expected = 4;
      expect(result, expected);
    }
  });
}

void _testDefaultIfEmpty() {
  test("DefaultIfEmpty", () {
    {
      var data = <int>[];
      var expected = [41];
      var query = data.defaultIfEmpty(41);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var query = data.defaultIfEmpty(41);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testDistinct() {
  test("Distinct", () {
    {
      var data = [0, 1, 2, 3, 4, 3, 2, 1, 0];
      var expected = [0, 1, 2, 3, 4];
      var query = data.distinct();
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var expected = <int>[];
      var query = data.distinct();
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [
        {'id': 'a'},
        {'id': 'b'},
        {'id': 'a'},
      ];
      var expected = [
        {'id': 'a'},
        {'id': 'b'},
      ];
      var query = data.distinct(CustomEqualityComparer(
          (a, b) => a['id'] == b['id'], (a) => a.length));
      var result = query;
      expect(result, expected);
    }
  });
}

void _testElementAt() {
  test("ElementAt", () {
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = 5;
      var result = data.elementAt$(5);
      expect(result, expected);
    }
  });
}

void _testElementAtOrDefault() {
  test("ElementAtOrDefault", () {
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = 5;
      var result = data.elementAtOrDefault(5);
      expect(result, expected);
    }
    //
    {
      var data = [];
      var expected;
      var result = data.elementAtOrDefault(5);
      expect(result, expected);
    }
  });
}

void _testExcept() {
  test("Except", () {
    {
      var data1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var data2 = [3, 4, 5, 6];
      var expected = [0, 1, 2, 7, 8, 9];
      var query = data1.except(data2);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data1 = [];
      var data2 = [];
      var expected = [];
      var query = data1.except(data2);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testFirst() {
  test("First", () {
    {
      var data = [0, 1];
      var expected = 0;
      var result = data.first$();
      expect(result, expected);
    }
    //
    {
      var data = [0, 1];
      var expected = 1;
      var result = data.first$((e) => e > 0);
      expect(result, expected);
    }
  });
}

void _testFirstOrDefault() {
  test("FirstOrDefault", () {
    {
      var data = [0, 1];
      var expected = 0;
      var result = data.firstOrDefault();
      expect(result, expected);
    }
    //
    {
      var data = [0, 1];
      var expected = 1;
      var result = data.firstOrDefault((e) => e > 0);
      expect(result, expected);
    }
    //
    {
      var data = [];
      var expected;
      var result = data.firstOrDefault();
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var expected;
      var result = data.firstOrDefault((e) => e > 0);
      expect(result, expected);
    }
    //
    {
      var data = [0, 1];
      var expected;
      var result = data.firstOrDefault((e) => e > 1);
      expect(result, expected);
    }
  });
}

void _testGroupBy() {
  test("GroupBy", () {
    {
      var query = pets.groupBy((pet) => pet.age);
      var expected = {
        1: pets.where$((pet) => pet.age == 1).toList(),
        2: pets.where$((pet) => pet.age == 2).toList(),
        3: pets.where$((pet) => pet.age == 3).toList()
      };

      var result = <int, List<Pet>>{};
      for (var group in query) {
        result[group.key] = <Pet>[];
        for (var child in group) {
          result[group.key].add(child);
        }
      }

      expect(result, expected);
    }
    //
    {
      var query = pets.groupBy$1((e) => e.age, (e) => e.name);
      var expected = {
        1: pets
            .where$((pet) => pet.age == 1)
            .select((pet) => pet.name)
            .toList(),
        2: pets
            .where$((pet) => pet.age == 2)
            .select((pet) => pet.name)
            .toList(),
        3: pets.where$((pet) => pet.age == 3).select((pet) => pet.name).toList()
      };

      var result = <int, List<String>>{};
      for (var group in query) {
        result[group.key] = <String>[];
        for (var child in group) {
          result[group.key].add(child);
        }
      }

      expect(result, expected);
    }
    //
    {
      var query = pets.groupBy$2(
          (pet) => pet.age, (age, pet) => pet.toList().join(", "));
      var expected = [
        "a1, b1, c1",
        "b2, c2",
        "c3",
      ];

      var result = query.toList();
      expect(result, expected);
    }
    //
    {
      var query = pets.groupBy$3((pet) => pet.age, (pet) => "@" + pet.name,
          (age, pet) => pet.toList().join(", "));
      var expected = [
        "@a1, @b1, @c1",
        "@b2, @c2",
        "@c3",
      ];

      var result = query.toList();
      expect(result, expected);
    }
  });
}

void _testGroupJoin() {
  test("GroupJoin", () {
    {
      var query = petOwners.groupJoin(
          pets,
          (petOwner) => petOwner,
          (pet) => pet.owner,
          (petOwner, pets) =>
              [petOwner, pets.select((pet) => pet.name).toList()]);
      var expected = [
        [
          petOwners.where$((petOwner) => petOwner.name == "a").single$(),
          pets
              .where$((pet) => pet.owner.name == "a")
              .select((pet) => pet.name)
              .toList()
        ],
        [
          petOwners.where$((petOwner) => petOwner.name == "b").single$(),
          pets
              .where$((pet) => pet.owner.name == "b")
              .select((pet) => pet.name)
              .toList()
        ],
        [
          petOwners.where$((petOwner) => petOwner.name == "c").single$(),
          pets
              .where$((pet) => pet.owner.name == "c")
              .select((pet) => pet.name)
              .toList()
        ],
      ];

      var result = query.toList();
      expect(result, expected);
    }
  });
}

void _testIntersect() {
  test("Intersect", () {
    {
      var data1 = [0, 1, 2, 3, 4, 3, 2, 1, 0];
      var data2 = [5, 4, 2];
      var expected = [2, 4];
      var query = data1.intersect(data2);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data1 = [];
      var data2 = [];
      var expected = [];
      var query = data1.intersect(data2);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testJoin() {
  test("Join", () {
    {
      var query = petOwners.join$(
          pets,
          (petOwner) => petOwner,
          (pet) => pet.owner,
          (petOwner, pet) => "${petOwner.name} - ${pet.name}");
      var expected = [
        "a - a1",
        "b - b1",
        "b - b2",
        "c - c1",
        "c - c2",
        "c - c3",
      ];
      var result = query;
      expect(result, expected);
    }
  });
}

void _testLast() {
  test("Last", () {
    {
      var data = [0, 1];
      var expected = 1;
      var result = data.last$();
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3];
      var expected = 3;
      var result = data.last$((e) => e > 0);
      expect(result, expected);
    }
  });
}

void _testLastOrDefault() {
  test("LastOrDefault", () {
    {
      var data = [0, 1];
      var expected = 1;
      var result = data.lastOrDefault();
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3];
      var expected = 3;
      var result = data.lastOrDefault((e) => e > 0);
      expect(result, expected);
    }
    //
    {
      var data = [];
      var expected;
      var result = data.lastOrDefault();
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var expected;
      var result = data.lastOrDefault((e) => e > 0);
      expect(result, expected);
    }
    //
    {
      var data = [0, 1];
      var expected;
      var result = data.lastOrDefault((e) => e > 1);
      expect(result, expected);
    }
  });
}

void _testMax() {
  test("Max", () {
    {
      var data = [4, 3, 2, 1, 0];
      var expected = 4;
      var result = data.max();
      expect(result, expected);
    }
    //
    {
      var data = [4, 3, 2, 1, 0];
      var expected = 40;
      var result = data.max$1<int>((e) => e * 10);
      expect(result, expected);
    }
    //
    {
      var data = [1, null, -5];
      var result = data.max();
      var expected = 1;
      expect(result, expected);
    }
    //
    {
      var data = [1, null, -5];
      var result = data.max$1((e) => e * 2);
      var expected = 2;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var result = data.max();
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var result = data.max$1((e) => e);
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[null];
      var result = data.max();
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[null];
      var result = data.max$1((e) => e);
      var expected;
      expect(result, expected);
    }
  });
}

void _testMin() {
  test("Min", () {
    {
      var data = [4, 3, 2, 1, 0];
      var expected = 0;
      var result = data.min();
      expect(result, expected);
    }
    //
    {
      var data = [4, 3, 2, 1, 0];
      var expected = 0;
      var result = data.min$1((e) => e * 10);
      expect(result, expected);
    }
    //
    {
      var data = [1, null, -5];
      var result = data.min();
      var expected = -5;
      expect(result, expected);
    }
    //
    {
      var data = [1, null, -5];
      var result = data.min$1((e) => e * 2);
      var expected = -10;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var result = data.min();
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var result = data.min$1((e) => e);
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[null];
      var result = data.min();
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[null];
      var result = data.min$1((e) => e);
      var expected;
      expect(result, expected);
    }
  });
}

void _testOfType() {
  test("OfType", () {
    {
      var data = [0, "0", 1, "1", 2, "3"];
      var expected = [0, 1, 2];
      var query = data.ofType<int>();
      var result = query;
      expect(result, expected);
    }
  });
}

void _testOrderBy() {
  test("OrderBy", () {
    {
      var data = [4, 3, 2, 1, 0];
      var expected = [0, 1, 2, 3, 4];
      var query = data.orderBy((e) => e);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4];
      var expected = [4, 3, 2, 1, 0];
      var query = data.orderByDescending((e) => e);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [false, true, false, true];
      var expected = [false, false, true, true];
      var query = data.orderBy((e) => e);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testPrepend() {
  test("Prepend", () {
    {
      var data = [1, 2];
      var expected = [0, 1, 2];
      var query = data.prepend(0);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testSelect() {
  test("Select", () {
    {
      var data = [0, 1, 2, 3, 4, 3, 2, 1, 0];
      var expected = [0, 10, 20, 30, 40, 30, 20, 10, 0];
      var query = data.select((e) => e * 10);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var expected = [];
      var query = data.select((e) => e);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2];
      var expected = ["00", "11", "22"];
      var query = data.select$1((e, i) => "$e$i");
      var result = query;
      expect(result, expected);
    }
  });
}

void _testSelectMany() {
  test("SelectMany", () {
    {
      var data = [
        [0],
        [1, 2],
        [3, 4, 5]
      ];
      var expected = [0, 1, 2, 3, 4, 5];
      var query = data.selectMany((e) => e);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var expected = pets;
      var query = petOwners.selectMany((petOwner) => petOwner.pets);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var expected = ["0a1", "1b1", "1b2", "2c1", "2c2", "2c3"];
      var query = petOwners.selectMany$1(
          (petOwner, index) => petOwner.pets.select((pet) => "${index}${pet}"));
      var result = query;
      expect(result, expected);
    }
    //
    {
      var expected = ["a a1", "b b1", "b b2", "c c1", "c c2", "c c3"];
      var query = petOwners.selectMany$2((petOwner) => petOwner.pets,
          (petOwner, pet) => "${petOwner.name} ${pet.name}");
      var result = query;
      expect(result, expected);
    }
  });
}

void _testSequenceEqual() {
  test("SequenceEqual", () {
    {
      var data1 = [0, 1, 2];
      var data2 = [0, 1, 2];
      var expected = true;
      var result = data1.sequenceEqual(data2);
      expect(result, expected);
    }
    //
    {
      var data1 = [0, 1, 2];
      var data2 = [0, 1, 3];
      var expected = false;
      var result = data1.sequenceEqual(data2);
      expect(result, expected);
    }
    //
    {
      var data1 = [0, 1, 2];
      var data2 = [0, 1];
      var expected = false;
      var result = data1.sequenceEqual(data2);
      expect(result, expected);
    }
  });
}

void _testSingle() {
  test("Single", () {
    {
      var data = [0];
      var expected = 0;
      var result = data.single$();
      expect(result, expected);
    }
    //
    {
      var data = [0, 10, 20, 30];
      var expected = 20;
      var result = data.single$((e) => e > 10 && e < 30);
      expect(result, expected);
    }
    //
    {
      var data = [];
      var exception;
      try {
        data.single();
      } catch (e) {
        exception = e;
      }

      expect(exception != null, true);
    }
    //
    {
      var data = [];
      var exception;
      try {
        data.single((e) => e == 1);
      } catch (e) {
        exception = e;
      }

      expect(exception != null, true);
    }
  });
}

void _testSingleOrDefault() {
  test("SingleOrDefault", () {
    {
      var data = [0];
      var expected = 0;
      var result = data.singleOrDefault();
      expect(result, expected);
    }
    //
    {
      var data = [0, 10, 20, 30];
      var expected = 20;
      var result = data.singleOrDefault((e) => e > 10 && e < 30);
      expect(result, expected);
    }
    //
    {
      var data = [0, 10, 20, 30];
      var expected;
      var result = data.singleOrDefault((e) => e > 100);
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var expected;
      var result = data.singleOrDefault((e) => e > 10 && e < 30);
      expect(result, expected);
    }
  });
}

void _testSkip() {
  test("Skip", () {
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [5, 6, 7, 8, 9];
      var query = data.skip(5);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var query = data.skip(0);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testSkipWhile() {
  test("SkipWhile", () {
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [5, 6, 7, 8, 9];
      var query = data.skipWhile((e) => e != 5);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var query = data.skipWhile((e) => false);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = ["a", "b", "c"];
      var expected = ["b", "c"];
      var query = data.skipWhile$1((str, i) => str.length > i);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testSum() {
  test("Sum", () {
    {
      var data = [4, 3, 2, 1, 0];
      var expected = 10;
      var result = data.sum();
      expect(result, expected);
    }
    //
    {
      var data = [4, 3, 2, 1, 0];
      var expected = 100;
      var result = data.sum$1((e) => e * 10);
      expect(result, expected);
    }
    //
    {
      var data = [1, null, -5];
      var result = data.sum();
      var expected = -4;
      expect(result, expected);
    }
    //
    {
      var data = [1, null, -5];
      var result = data.sum$1((e) => e * 2);
      var expected = -8;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var result = data.sum();
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[];
      var result = data.sum$1((e) => e);
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[null];
      var result = data.sum();
      var expected;
      expect(result, expected);
    }
    //
    {
      var data = <int>[null];
      var result = data.sum$1<int>((e) => e);
      var expected;
      expect(result, expected);
    }
  });
}

void _testTake() {
  test("Take", () {
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4];
      var query = data.take(5);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [];
      var query = data.take(0);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testTakeWhile() {
  test("TakeWhile", () {
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4];
      var query = data.takeWhile((e) => e < 5);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var query = data.takeWhile((e) => true);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var query = data.takeWhile$1((e, i) => e == i);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testThenBy() {
  test("ThenBy", () {
    {
      var data = [
        "grape",
        "passionfruit",
        "banana",
        "mango",
        "orange",
        "raspberry",
        "apple",
        "blueberry"
      ];
      var expected = [
        "apple",
        "grape",
        "mango",
        "banana",
        "orange",
        "blueberry",
        "raspberry",
        "passionfruit"
      ];

      var query = data.orderBy((str) => str.length).thenBy((str) => str);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [
        "grape",
        "passionfruit",
        "banana",
        "mango",
        "orange",
        "raspberry",
        "apple",
        "blueberry"
      ];
      var expected = [
        "passionfruit",
        "raspberry",
        "blueberry",
        "orange",
        "banana",
        "mango",
        "grape",
        "apple"
      ];
      var query = data
          .orderByDescending((str) => str.length)
          .thenByDescending((str) => str);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var johnSmith10 = Person()
        ..age = 10
        ..firstName = "John"
        ..lastName = "Smith";
      var tomSawyer = Person()
        ..age = 12
        ..firstName = "Tom"
        ..lastName = "Sawyer";
      var johnSmith60 = Person()
        ..age = 60
        ..firstName = "John"
        ..lastName = "Smith";
      var jackSparrow = Person()
        ..age = 40
        ..firstName = "Jack"
        ..lastName = "Sparrow";
      var johnWick = Person()
        ..age = 50
        ..firstName = "John"
        ..lastName = "Wick";
      var data = [
        johnSmith60,
        tomSawyer,
        johnSmith10,
        jackSparrow,
        johnWick,
      ];
      var expected = [
        jackSparrow,
        johnSmith60,
        johnSmith10,
        johnWick,
        tomSawyer,
      ];
      var query = data
          .orderBy((p) => p.firstName)
          .thenBy((p) => p.lastName)
          .thenByDescending((p) => p.age);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0];
      var expected = [0];
      var query = data.orderByDescending((e) => e).thenByDescending((e) => e);
      var result = query;
      expect(result, expected);
    }
    {
      var data = <int>[];
      var expected = <int>[];
      var query = data.orderByDescending((e) => e).thenByDescending((e) => e);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testToDictionary() {
  test("ToDictionary", () {
    {
      var data = [0, 1];
      var result = data.toMap((kv) => "$kv");
      var expected = {"0": 0, "1": 1};
      expect(result, expected);
    }
  });
}

void _testToLookup() {
  test("ToLookup", () {
    {
      var query = pets.toLookup((pet) => pet.owner);
      var expected = {
        petOwners.where$((petOwner) => petOwner.name == "a").single$():
            pets.where$((pet) => pet.owner.name == "a").toList(),
        petOwners.where$((petOwner) => petOwner.name == "b").single$():
            pets.where$((pet) => pet.owner.name == "b").toList(),
        petOwners.where$((petOwner) => petOwner.name == "c").single$():
            pets.where$((pet) => pet.owner.name == "c").toList()
      };
      var result = <PetOwner, List<Pet>>{};
      for (var group in query) {
        result[group.key] = <Pet>[];
        for (var pet in group) {
          result[group.key].add(pet);
        }
      }

      expect(result, expected);
    }
    //
    {
      var query = pets.toLookup$1((pet) => pet.owner, (pet) => pet.name);
      var expected = {
        petOwners.where$((petOwner) => petOwner.name == "a").single$(): pets
            .where$((pet) => pet.owner.name == "a")
            .select((pet) => pet.name)
            .toList(),
        petOwners.where$((petOwner) => petOwner.name == "b").single$(): pets
            .where$((pet) => pet.owner.name == "b")
            .select((pet) => pet.name)
            .toList(),
        petOwners.where$((petOwner) => petOwner.name == "c").single$(): pets
            .where$((pet) => pet.owner.name == "c")
            .select((pet) => pet.name)
            .toList()
      };
      var result = <PetOwner, List<String>>{};
      for (var group in query) {
        result[group.key] = <String>[];
        for (var name in group) {
          result[group.key].add(name);
        }
      }

      expect(result, expected);
    }
  });
}

void _testUnion() {
  test("Union", () {
    {
      var data1 = [0, 1, 2, 3, 4, 0, 1, 2, 3, 4];
      var data2 = [5, 6, 7, 8, 9, 5, 6, 7, 8, 9];
      var expected = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
      var query = data1.union(data2);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data1 = [0, 1, 2, 3, 4, 0, 1, 2, 3, 4];
      var data2 = <int>[];
      var expected = [0, 1, 2, 3, 4];
      var query = data1.union(data2);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testWhere() {
  test("Where", () {
    {
      var data = [0, 1, 2, 3, 4, 3, 2, 1, 0];
      var expected = [0, 1, 2, 2, 1, 0];
      var query = data.where$((e) => e < 3);
      var result = query;
      expect(result, expected);
    }
    //
    {
      var data = [0, 1, 2, 3, 4, 3, 2, 1, 0];
      var expected = [0, 1, 2, 3, 4];
      var query = data.whereEx$1((e, i) => e == i);
      var result = query;
      expect(result, expected);
    }
  });
}

void _testZip() {
  test("Zip", () {
    {
      var data1 = [0, 1, 2, 3];
      var data2 = ["0", "1", "2"];
      var expected = [
        [0, "0"],
        [1, "1"],
        [2, "2"]
      ];
      var query = data1.zip(data2, (e1, e2) => [e1, e2]);
      var result = query;
      expect(result, expected);
    }
  });
}

class Person {
  int age;
  String firstName;
  String lastName;
}

class Pet {
  int age;
  String name;
  PetOwner owner;
  Pet(this.name, this.age);
  String toString() => name;
}

class PetOwner {
  String name;
  Iterable<Pet> pets;
  PetOwner(this.name);
  String toString() => name;
}
