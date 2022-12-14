import 'dart:io';

class WorkPair {
  final String rawString;
  late final int worker1Start;
  late final int worker1End;
  late final int worker2Start;
  late final int worker2End;

  WorkPair(this.rawString) {
    final splitStrings = rawString.split(',');
    worker1Start = int.parse(splitStrings[0].split('-')[0]);
    worker1End = int.parse(splitStrings[0].split('-')[1]);
    worker2Start = int.parse(splitStrings[1].split('-')[0]);
    worker2End = int.parse(splitStrings[1].split('-')[1]);
  }

  /// Returns 1 for partial, 2 for complete, 0 for no overlap
  int get overlapCalc {
    late final bool oneIsFirst;

    if (worker1Start < worker2Start) {
      oneIsFirst = true;
    } else if (worker2Start < worker1Start) {
      oneIsFirst = false;
    } else {
      return 2;
    }

    if (oneIsFirst) {
      if (worker2Start <= worker1End) {
        // there is an overlap
        if (worker2End <= worker1End) {
          return 2;
        } else {
          return 1;
        }
      } else {
        return 0;
      }
    } else {
      if (worker1Start <= worker2End) {
        // there is an overlap
        if (worker1End <= worker2End) {
          return 2;
        } else {
          return 1;
        }
      } else {
        return 0;
      }
    }
  }
}

List<int> calculateOverLaps(List<String> pairs) {
  var completeOverlaps = 0;
  var partialOverlaps = 0;

  for (final pairString in pairs) {
    final thisWorkPair = WorkPair(pairString);
    final overlapResult = thisWorkPair.overlapCalc;
    if (overlapResult > 0) {
      if (overlapResult == 2) {
        completeOverlaps++;
      }
      partialOverlaps++;
    }
  }

  return [completeOverlaps, partialOverlaps];
}

void main() async {
  final input = await File('./input04.txt').readAsLines();

  final result = calculateOverLaps(input);

  print(result);
}
