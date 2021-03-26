import 'dart:io';

//done
int getInput(String text) {
  stdout.write(text);
  return int.parse(stdin.readLineSync());
}

abstract class RandomNumGenerator {
  double xPre;
  int m;
  double generateRandomNum();
  void displayText();
  void standerdText() {
    xPre = getInput('Seed =').toDouble();
    m = getInput('m = ');

    print('firstNum=${xPre}');
    displayText();
  }

  void whatTestToDo() {
    // ignore: omit_local_variable_types
    int choseOp = getInput(
        'there is to oprations for each Gen \n 1 for generating a spisifc num \n 2 for calc seq length \n');

    if (choseOp == 1) {
      test();
    } else if (choseOp == 2) {
      calcSeq();
    } else {
      print('err plz chose 1 or 2  only');
    }
  }

  void test() {
    int howManyNumToGenerate = getInput('how Many Num To Generate');
    standerdText();
    // ignore: omit_local_variable_types
    for (int i = 0; i < howManyNumToGenerate; i++) {
      print(generateRandomNum());
    }
  }

  void calcSeq() {
    // ignore: omit_local_variable_types
    standerdText();
    int printTheSeq =
        getInput('do you want to print the array while working ? 1 for true ');
    List<double> x = [xPre];

    if (printTheSeq == 1) {
      print('[${x.length}]>> ${xPre}');
      while (x.contains(generateRandomNum()) == false) {
        x.add(xPre);
        print('[${x.length}]>> ${xPre}');
      }
      print('next element is  ${xPre}');
    } else {
      while (x.contains(generateRandomNum()) == false) {
        x.add(xPre);
      }
    }
    print('seq len = ${x.length}');
  }
}

//done
class LCG extends RandomNumGenerator {
  int c;
  int a;
  @override
  void displayText() {
    c = getInput('c =');
    a = getInput('a =');
  }

  @override
  double generateRandomNum() {
    var x = (a * xPre + c) % m;
    xPre = x;
    return x.toDouble();
  }
}

//done
class MCG extends RandomNumGenerator {
  int a;
  @override
  void displayText() {
    a = getInput('multplayer');
  }

  @override
  double generateRandomNum() {
    var x = (a * xPre) % m;
    xPre = x;
    return x / m;
  }
}

//done
class ICG extends RandomNumGenerator {
  int c;
  int a;
  @override
  void displayText() {
    c = getInput('constant');
    a = getInput('multplayer');
  }

  @override
  double generateRandomNum() {
    var x = (a * 1 / xPre) % m;
    xPre = x;
    return x / m;
  }
}

//done
class MRG extends RandomNumGenerator {
  List<double> allPre;
  List<double> multplayers = [];
  int q;
  int counter = 0;
  @override
  void displayText() {
    allPre = [xPre];
    q = getInput(' pleas chose a q =');

    for (int i = 0; i <= q; i++) {
      multplayers.add(getInput('a multplayer Number $i =').toDouble());
    }
  }

  @override
  double generateRandomNum() {
    double x = 0;
    for (int i = 0; i < q; i++) {
      x = x + multplayers[i] * allPre[i - q];
    }

    xPre = x;
    counter++;
    multplayers = [];
    return x / m;
  }
}

//done
class LFG extends RandomNumGenerator {
  List<int> allPre;
  int j;
  int k;
  int i = 0;
  int opration;
  @override
  void displayText() {
    j = getInput('constant');
    k = getInput('multplayer');
    opration = getInput(
        'what opration do you want \n 1>> + \n 2>> - \n 3>> X \n 4>> Xor ');
  }

  @override
  double generateRandomNum() {
    double x;
    if (opration == 1) {
      allPre[i - j] + allPre[i - k];
    } else if (opration == 2) {
      allPre[i - j] - allPre[i - k];
    } else if (opration == 3) {
      allPre[i - j] * allPre[i - k];
    } else if (opration == 4) {
      allPre[i - j] ^ allPre[i - k];
    } else {
      print('err plz chose between 1 and 4 ');
    }
    xPre = x;
    i++;
    return x / m;
  }
}

//done
class MSM extends RandomNumGenerator {
  @override
  void displayText() {}

  @override
  double generateRandomNum() {
    double x = (xPre * xPre) ~/ 100 % 10000.toDouble();
    // print(xPre * xPre);
    // print((xPre * xPre) ~/ 100);
    // print((xPre * xPre) ~/ 100 % 10000);
    xPre = x;
    return x.ceilToDouble();
  }
}

void main(List<String> arguments) {
  void run() {
    print(
        'hello , who ever you are , this is an Random Number generator algo ');
    int choise = getInput(
        'chose your algo  \n 0 >>Linear congruential generator (LCG) \n 1 >>Multiplicative congruential generator (MCG) \n 2 >>Inversive congruential generator (ICG) \n 3 >> Multiple Recursive generator (MRG)\n 4 >> Lagged Fibonacci generator (LFG) \n 5 >> Mid-square method (MSM) \n');
    if (choise == 0) {
      LCG().whatTestToDo();
    } else if (choise == 1) {
      MCG().whatTestToDo();
    } else if (choise == 2) {
      ICG().whatTestToDo();
    } else if (choise == 3) {
      MRG().whatTestToDo();
    } else if (choise == 4) {
      LFG().whatTestToDo();
    } else if (choise == 5) {
      MSM().whatTestToDo();
      ;
    } else {
      print('err plz chose between 0 and 5 only ');
    }
    print('done!');
    exit(5);
  }

  run();
}
