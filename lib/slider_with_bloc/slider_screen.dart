
import 'package:flutter/material.dart';
import 'package:practice/slider_with_bloc/slider_bloc.dart';

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  RadiusBloc _radiusBloc=RadiusBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
      ),
      body: StreamBuilder<double>(
        stream: _radiusBloc.radStream,
        builder: (context, snapshot) {
              return Column(
                children: [
                  Slider(
                    value:snapshot.data==null?0: snapshot.data!,
                    onChanged: (value){
                      _radiusBloc.setRadius(value);
                    },
                    min:0,
                    max:50,

                  ),
                  const SizedBox( height: 8,),
                  Text("Border Radius: ${snapshot.data==null?0: snapshot.data!.toStringAsFixed(2)}"),
                  const SizedBox( height: 16,),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(snapshot.data==null?0: snapshot.data!)
                    ),
                  ),
                ],
              );

        }
      ),
    );
  }
}
