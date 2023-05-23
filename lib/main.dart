import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeScreen(),
    );
  }
}

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<List<String?>> board = [];
  bool isPlayer1Turn = true;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    resetBoard();
  }

  void resetBoard() {
    board =
    List<List<String?>>.generate(3, (_) => List<String?>.filled(3, null));
    isPlayer1Turn = true;
    gameOver = false;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == null && !gameOver) {
      setState(() {
        board[row][col] = isPlayer1Turn ? 'X' : 'O';
        isPlayer1Turn = !isPlayer1Turn;
        checkGameOver();
      });
    }
  }

  void checkGameOver() {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] != null &&
          board[i][0] == board[i][1] &&
          board[i][1] == board[i][2]) {
        gameOver = true;
        break;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] != null &&
          board[0][i] == board[1][i] &&
          board[1][i] == board[2][i]) {
        gameOver = true;
        break;
      }
    }

    // Check diagonals
    if (board[0][0] != null &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      gameOver = true;
    }

    if (board[0][2] != null &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      gameOver = true;
    }

    // Check for a draw
    if (!gameOver) {
      int count = 0;
      for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
          if (board[i][j] != null) {
            count++;
          }
        }
      }
      if (count == 9) {
        gameOver = true;
      }
    }
  }

  Widget buildTile(int row, int col) {
    return GestureDetector(
      onTap: () {
        makeMove(row, col);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Center(
          child: Text(
            board[row][col] ?? '',
            style: TextStyle(fontSize: 48.0),
          ),
        ),
      ),
    );
  }

  Widget buildBoard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          gameOver ? (isPlayer1Turn ? 'Player 2 Wins!' : 'Player 1 Wins!') : '',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20.0),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            final row = index ~/ 3;
            final col = index % 3;
            return buildTile(row, col);
          },
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: gameOver ? resetBoard : null,
          child: Text('Reset'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(child: buildBoard()),
        ),
      ),
    );
  }
}
