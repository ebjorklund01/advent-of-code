import 'dart:io';

final aCodeUnit = 'A'.codeUnits[0];
final bCodeUnit = 'B'.codeUnits[0];
final cCodeUnit = 'C'.codeUnits[0];
final xCodeUnit = 'X'.codeUnits[0];
final yCodeUnit = 'Y'.codeUnits[0];
final zCodeUnit = 'Z'.codeUnits[0];

enum Move {
  rock(1),
  paper(2),
  scissors(3),
  ;

  final int score;

  const Move(this.score);

  static Move fromChar(String char) {
    final codeUnit = char.codeUnits[0];
    if (codeUnit == aCodeUnit || codeUnit == xCodeUnit) {
      return Move.rock;
    } else if (codeUnit == bCodeUnit || codeUnit == yCodeUnit) {
      return Move.paper;
    } else if (codeUnit == cCodeUnit || codeUnit == zCodeUnit) {
      return Move.scissors;
    } else {
      print('error');
      throw Exception();
    }
  }

  bool beats(Move other) {
    switch (this) {
      case Move.rock:
        if (other == Move.scissors) {
          return true;
        } else {
          return false;
        }
      case Move.paper:
        if (other == Move.rock) {
          return true;
        } else {
          return false;
        }
      case Move.scissors:
        if (other == Move.paper) {
          return true;
        } else {
          return false;
        }
      default:
        print('error');
        throw Exception();
    }
  }
}

int roundScore(Move player1Move, Move player2Move) {
  if (player1Move == player2Move) {
    return 3 + player1Move.score;
  }

  return player1Move.score + (player1Move.beats(player2Move) ? 6 : 0);
}

void main() async {
  final input = await File('./02input.txt').readAsLines();

  final player1Moves = List<Move>.generate(
      input.length, (index) => Move.fromChar(input[index][0]));
  final player2Moves = List<Move>.generate(
      input.length, (index) => Move.fromChar(input[index][2]));

  var score = 0;

  for (var i = 0; i < player1Moves.length; i++) {
    score += roundScore(player2Moves[i], player1Moves[i]);
  }

  print(score);
}
