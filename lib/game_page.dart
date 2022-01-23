import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'home_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  VideoPlayerController wincontroller;
  VideoPlayerController losecontroller;

  VideoPlayerController background_1_controller;

  VideoPlayerController background_11_controller;
  VideoPlayerController background_13_controller;

  VideoPlayerController background_21_controller;
  VideoPlayerController background_23_controller;

  VideoPlayerController background_31_controller;
  VideoPlayerController background_33_controller;

  Future<void> futureControllerwin;
  Future<void> futureControllerlose;

  double resultpersent = 0.0;
  int result = 0;
  Timer timer;
  Timer videotimer;
  Timer lasttimer;
  Timer testtimer;
  int level = 1;

  List<int> leveltime = [3000, 2000, 1000];
  List<int> leveleter = [20, 30, 60];
  int maxlitter, millisecond;
  int time = 0;
  bool end = false;
  bool win = false;
  bool lose = false;
  bool stop = false;
  bool test = false;

  bool takeOne = false;
  bool finishgame = false;
  bool wingame = false;
  List<bool> collect = [false, false, false, false, false, false];
  List<bool> testcollect = [false, false, false, false];

  int testpickup = 0;

  AudioCache _audioCache;

  @override
  void dispose() {
    wincontroller.dispose();
    losecontroller.dispose();
    background_11_controller.dispose();
    background_13_controller.dispose();

    background_21_controller.dispose();
    background_23_controller.dispose();

    background_31_controller.dispose();
    background_33_controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _audioCache = AudioCache(
      prefix: 'assets/',
      fixedPlayer: AudioPlayer()..setReleaseMode(ReleaseMode.STOP),
    );

    wincontroller = VideoPlayerController.asset("assets/win.mp4");
    losecontroller = VideoPlayerController.asset("assets/lose.mp4");
    futureControllerwin = wincontroller.initialize();
    futureControllerlose = losecontroller.initialize();

    background_11_controller = VideoPlayerController.asset("assets/v_1.mp4")
      ..initialize().then((_) {
        background_11_controller.setLooping(true);
      });

    background_13_controller = VideoPlayerController.asset("assets/v_3.mp4")
      ..initialize().then((_) {
        background_13_controller.setLooping(false);
      });

    background_21_controller = VideoPlayerController.asset("assets/v_11.mp4")
      ..initialize().then((_) {
        background_21_controller.setLooping(true);
      });

    background_23_controller = VideoPlayerController.asset("assets/v_33.mp4")
      ..initialize().then((_) {
        background_23_controller.setLooping(false);
      });

    background_31_controller = VideoPlayerController.asset("assets/v_111.mp4")
      ..initialize().then((_) {
        background_31_controller.setLooping(true);
      });

    background_33_controller = VideoPlayerController.asset("assets/v_333.mp4")
      ..initialize().then((_) {
        background_33_controller.setLooping(false);
      });

    wincontroller.setLooping(false);
    wincontroller.setVolume(100.0);

    losecontroller.setLooping(false);
    losecontroller.setVolume(100.0);

    millisecond = 3000;
    maxlitter = 20;
    super.initState();
    startgame();
  }

  int sublevel = 1;

  Widget getWidget() {
    if (level == 1 && sublevel == 1) {
      if (!stop) background_11_controller.play();
      return SizedBox(
        width: background_11_controller.value.size?.width ?? 0,
        height: background_11_controller.value.size?.height ?? 0,
        child: VideoPlayer(background_11_controller),
      );
    } else if (level == 1 && sublevel == 3) {
      if (!stop && !end) background_13_controller.play();
      return SizedBox(
        width: background_13_controller.value.size?.width ?? 0,
        height: background_13_controller.value.size?.height ?? 0,
        child: VideoPlayer(background_13_controller),
      );
    } else if (level == 2 && sublevel == 1) {
      if (!stop) background_21_controller.play();
      return SizedBox(
        width: background_21_controller.value.size?.width ?? 0,
        height: background_21_controller.value.size?.height ?? 0,
        child: VideoPlayer(background_21_controller),
      );
    } else if (level == 2 && sublevel == 3) {
      if (!stop && !end) background_23_controller.play();
      return SizedBox(
        width: background_23_controller.value.size?.width ?? 0,
        height: background_23_controller.value.size?.height ?? 0,
        child: VideoPlayer(background_23_controller),
      );
    } else if (level == 3 && sublevel == 1) {
      if (!stop) background_31_controller.play();
      return SizedBox(
        width: background_31_controller.value.size?.width ?? 0,
        height: background_31_controller.value.size?.height ?? 0,
        child: VideoPlayer(background_31_controller),
      );
    } else if (level == 3 && sublevel == 3) {
      if (!stop && !end) background_33_controller.play();
      return SizedBox(
        width: background_33_controller.value.size?.width ?? 0,
        height: background_33_controller.value.size?.height ?? 0,
        child: VideoPlayer(background_33_controller),
      );   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.fill,
                child: getWidget(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      child: IconButton(
                        icon: Image.asset(
                          "assets/pause.png",
                        ),
                        iconSize: 35,
                        onPressed: () {
                          if (!end) pause();
                        },
                      ),
                    ),
                    Container(
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/result_ic3.png",
                            height: MediaQuery.of(context).size.height * 0.10,
                            width: MediaQuery.of(context).size.width * 0.65,
                          ),
                          Card(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 30, left: 17),
                            child: Container(
                              child: Text(
                                "  " +
                                    (resultpersent * 100).toInt().toString() +
                                    " % ",
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.16,
                                top: 32),
                            height: MediaQuery.of(context).size.height * 0.023,
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff726d6d),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: resultpersent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: resultpersent >= 0.5
                                          ? Color(0xff229702)
                                          : Color(0xffec0505),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            child: Image.asset(
                              "assets/coin.png",
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.10,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 30),
                            child: Text(
                              result.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        "assets/time_ic.png",
                        height: MediaQuery.of(context).size.height * 0.10,
                        width: MediaQuery.of(context).size.width * 0.10,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (end && win && level < 3)
                              Container(
                                height: 200,
                                width: 400,
                                child: FutureBuilder(
                                  future: futureControllerwin,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Center(
                                        child: AspectRatio(
                                          aspectRatio:
                                              wincontroller.value.aspectRatio,
                                          child: VideoPlayer(wincontroller),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            if (end && lose)
                              Container(
                                width: 350,
                                child: FutureBuilder(
                                  future: futureControllerlose,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return Center(
                                        child: AspectRatio(
                                          aspectRatio:
                                              losecontroller.value.aspectRatio,
                                          child: VideoPlayer(losecontroller),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (stop)
                              Container(
                                width: 250,
                                height: 300,
                                color: Color(0x602dce08),
                                child: Container(
                                  width: 200,
                                  height: 250,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: IconButton(
                                              icon: Image.asset(
                                                "assets/pause.png",
                                              ),
                                              iconSize: 90,
                                              onPressed: () {
                                                continueGame();
                                              },
                                            ),
                                          ),
                                          Text(
                                            "أكمل اللعب",
                                            style: TextStyle(fontSize: 28),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            child: IconButton(
                                              icon: Image.asset(
                                                "assets/icon_logout.png",
                                              ),
                                              iconSize: 90,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()));
                                              },
                                            ),
                                          ),
                                          Text(
                                            "انهاء اللعب",
                                            style: TextStyle(fontSize: 28),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.50,
                              ),
                              (time % 6 != 1 || end || stop || collect[1])
                                  ? Container(
                                      width: 60,
                                    )
                                  : Container(
                                      margin:
                                          EdgeInsets.only(left: 5, right: 5),
                                      child: IconButton(
                                        icon: Image.asset(
                                          "assets/banana-peel-fruit-peeled-banana-peel-2175576e824e7c4e5d2f55a2a818493b.png",
                                        ),
                                        iconSize: 70,
                                        onPressed: () {
                                          changeresult(1);
                                        },
                                      ),
                                    ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.05,
                              ),
                              (time % 6 != 5 || end || stop || collect[5])
                                  ? Container(
                                      width: 60,
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(right: 5),
                                      child: IconButton(
                                        icon: Image.asset(
                                          "assets/orange.png",
                                        ),
                                        iconSize: 70,
                                        onPressed: () {
                                          changeresult(5);
                                        },
                                      ),
                                    ),
                            ],
                          ),
                          if (sublevel != 3)
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.50,
                                ),
                                (time % 6 != 3 || end || stop || collect[3])
                                    ? Container(
                                        width: 60,
                                      )
                                    : Container(
                                        margin:
                                            EdgeInsets.only(left: 5, right: 5),
                                        child: IconButton(
                                          icon: Image.asset(
                                            "assets/banana.png",
                                          ),
                                          iconSize: 70,
                                          onPressed: () {
                                            changeresult(3);
                                          },
                                        ),
                                      ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                (time % 6 != 2 || end || stop || collect[2])
                                    ? Container(
                                        width: 60,
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: IconButton(
                                          icon: Image.asset(
                                            "assets/vegetarian-cuisine-vegetable-pad-thai-leftovers-peel-vegetable-af091a4eb3d0101ed0b8e35d2812caa1.png",
                                          ),
                                          iconSize: 70,
                                          onPressed: () {
                                            changeresult(2);
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          if (sublevel != 3)
                            Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                ),
                                (time % 6 != 4 || end || stop || collect[4])
                                    ? Container(
                                        width: 60,
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                        ),
                                        child: IconButton(
                                          icon: Image.asset(
                                            "assets/96ef1m5d523icsoaa4a0arte17-a12d30a307e984b9bf45fa1163dc988c.png",
                                          ),
                                          iconSize: 70,
                                          onPressed: () {
                                            changeresult(4);
                                          },
                                        ),
                                      ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                ),
                                (time % 6 != 0 || end || stop || collect[0])
                                    ? Container(
                                        width: 60,
                                      )
                                    : Container(
                                        margin: EdgeInsets.only(
                                          right: 5,
                                        ),
                                        child: IconButton(
                                          icon: Image.asset(
                                            "assets/plastic-bottle-recycling-waste-recycled-plastic-bottles-df26afdafdc64540e4c2b709008dc01b.png",
                                          ),
                                          iconSize: 70,
                                          onPressed: () {
                                            changeresult(0);
                                          },
                                        ),
                                      ),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (test)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (finishgame && wingame)
                                Column(
                                  children: [
                                    Container(
                                      child: IconButton(
                                        icon: Image.asset(
                                          "assets/2222.png",
                                        ),
                                        iconSize: 200,
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      height: 300,
                                      color: Color(0x602dce08),
                                      child: Container(
                                        width: 200,
                                        height: 250,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                startagain();
                                              },
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(250)),
                                                  child: Center(
                                                    child: Text(
                                                      "اعادة اللعب",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => HomePage()),
                                                );
                                              },
                                              child: Center(
                                                child: Container(
                                                  padding: EdgeInsets.all(5),
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius: BorderRadius.circular(250)),
                                                  child: Center(
                                                    child: Text(
                                                      "خروج",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 25),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              if (takeOne && !wingame)
                                Container(
                                  child: IconButton(
                                    icon: Image.asset(
                                      "assets/6134170.png",
                                    ),
                                    iconSize: 200,
                                  ),
                                ),
                            ],
                          ),
                          if (!takeOne)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        takeOne = true;
                                        starttesttimer();
                                      });
                                    },
                                    icon: Image.asset(
                                      "assets/10.png",
                                    ),
                                    iconSize: 75,
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        takeOne = true;
                                        starttesttimer();
                                      });
                                    },
                                    icon: Image.asset(
                                      "assets/9.png",
                                    ),
                                    iconSize: 75,
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        takeOne = true;
                                        starttesttimer();
                                      });
                                    },
                                    icon: Image.asset(
                                      "assets/hooof7664t4plc3g816gnjoshf-9d4fa84a72f741cfe914cc0c7245a26c.png",
                                    ),
                                    iconSize: 75,
                                  ),
                                ),
                                Container(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        takeOne = true;
                                        starttesttimer();
                                      });
                                    },
                                    icon: Image.asset(
                                      "assets/11.png",
                                    ),
                                    iconSize: 100,
                                  ),
                                ),
                              ],
                            ),
                          if (takeOne && !finishgame)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (!testcollect[0])
                                  Container(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          testcollect[0] = true;
                                          testpickup++;
                                        });
                                      },
                                      icon: Image.asset(
                                        "assets/96ef1m5d523icsoaa4a0arte17-a12d30a307e984b9bf45fa1163dc988c.png",
                                      ),
                                      iconSize: 75,
                                    ),
                                  ),
                                if (!testcollect[1])
                                  Container(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          testcollect[1] = true;
                                          testpickup++;
                                        });
                                      },
                                      icon: Image.asset(
                                        "assets/banana-peel-fruit-peeled-banana-peel-2175576e824e7c4e5d2f55a2a818493b.png",
                                      ),
                                      iconSize: 75,
                                    ),
                                  ),
                                if (!testcollect[2])
                                  Container(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          testcollect[2] = true;
                                          testpickup++;
                                        });
                                      },
                                      icon: Image.asset(
                                        "assets/plastic-bin-bag-waste-kerbside-collection-transfer-station-garbage-collection-69888d22bbe3bf371037e7b7c6ebd627 (1).png",
                                      ),
                                      iconSize: 75,
                                    ),
                                  ),
                                if (!testcollect[3])
                                  Container(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          testcollect[3] = true;
                                          testpickup++;
                                        });
                                      },
                                      icon: Image.asset(
                                        "assets/vegetarian-cuisine-vegetable-pad-thai-leftovers-peel-vegetable-af091a4eb3d0101ed0b8e35d2812caa1.png",
                                      ),
                                      iconSize: 75,
                                    ),
                                  ),
                              ],
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void startgame() {
    if (time < maxlitter && !stop) {
      timer = Timer(Duration(milliseconds: millisecond), () {
        try {
          setState(() {
            time++;
            collect = [false, false, false, false, false, false];
          });
        } catch (e) {}
        startgame();
      });
    } else if (time == maxlitter) {
      setState(() {
        sublevel = 3;
      });
      Future.delayed(const Duration(milliseconds: 3000), () {
        endgame();
      });
    }
  }

  void changeresult(int i) {
    setState(() {
      collect[i] = true;
      result++;
      resultpersent = (result / maxlitter);
    });
  }

  void endgame() {
    if (resultpersent >= 0.5) {
      setState(() {
        win = true;
        end = true;
        if (sublevel == 3 && level == 3) {
          testlevel3();
        } else {
          wincontroller.initialize().then((value) {
            wincontroller.setLooping(false);
            wincontroller.setVolume(100.0);
            wincontroller.play();
          });
          last();
        }
      });
    } else {
      setState(() {
        lose = true;
        end = true;
        losecontroller.initialize().then((value) {
          losecontroller.setLooping(false);
          losecontroller.setVolume(100.0);
          losecontroller.play();
        });
        last();
      });
    }
  }

  last() {
    videotimer = Timer(Duration(milliseconds: 15000), () {
      try {
        if (win) {
          level++;
          maxlitter = leveleter[level - 1];
          millisecond = leveltime[level - 1];
        }
        playagain();
      } catch (e) {}
    });
  }

  void playagain() {
    setState(() {
      sublevel = 1;
      resultpersent = 0.0;
      result = 0;
      time = 0;
      end = false;
      win = false;
      lose = false;
      collect = [false, false, false, false, false, false];
    });
    startgame();
  }
  void startagain() {
    setState(() {
      sublevel = 1;
      resultpersent = 0.0;
      result = 0;
      time = 0;
      end = false;
      win = false;
      lose = false;
      collect = [false, false, false, false, false, false];
      testpickup = 0;
      test = false;
      takeOne = false;
      finishgame = false;
      wingame = false;
      testcollect = [false, false, false, false];
      level = 1;
      millisecond = 3000;
      maxlitter = 20;
    });
    startgame();
  }

  void pause() {
    setState(() {
      if (!end) {   if (level == 1 && sublevel == 1) {
          background_11_controller.pause();
        } else if (level == 1 && sublevel == 3) {
          background_13_controller.pause();
        } else if (level == 2 && sublevel == 1) {
          background_21_controller.pause();
        } else if (level == 2 && sublevel == 3) {
          background_23_controller.pause();
        } else if (level == 3 && sublevel == 1) {
          background_31_controller.pause();
        } else if (level == 3 && sublevel == 3) {
          background_33_controller.pause(); }}            stop = true;       });
  }
  void continueGame() {
    setState(() {
      if (!end) {  if (level == 1 && sublevel == 1) {
          background_11_controller.play();
        } else if (level == 1 && sublevel == 3) {
          background_13_controller.play();
        } else if (level == 2 && sublevel == 1) {
          background_21_controller.play();
        } else if (level == 2 && sublevel == 3) {
          background_23_controller.play();
        } else if (level == 3 && sublevel == 1) {
          background_31_controller.play();
        } else if (level == 3 && sublevel == 3) {
          background_33_controller.play(); }}         stop = false;            });
    startgame();
  }

  void testlevel3() {
    test = true;
    _audioCache.play('sound.mp3');
  }

  void starttesttimer() {
    testtimer = Timer(Duration(milliseconds: 10000), () {
      try {
        if (testpickup == 4) {
          setState(() {
            wingame = true;
            finishgame = true;
          });
        } else {
          testpickup = 0;
          test = false;
          takeOne = false;
          finishgame = false;
          wingame = false;
          testcollect = [false, false, false, false];
          playagain();
          setState(() {});
        }
      } catch (e) {}
    });
  }
}
