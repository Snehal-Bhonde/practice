

import 'package:rxdart/subjects.dart';

class RadiusBloc {
  BehaviorSubject<double> radBehavior = BehaviorSubject();
  double radius=0;
  Stream<double> get radStream => radBehavior.stream;

  setRadius(double radius) async {
   // radius=radius!=0?radius:this.radius;
    radBehavior.sink.add(radius);
  }
}