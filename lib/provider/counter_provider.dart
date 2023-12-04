import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider extends StatefulWidget {
  const CounterProvider({super.key});

  @override
  State<CounterProvider> createState() => _CounterProviderState();
}

class _CounterProviderState extends State<CounterProvider> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_)=>MainModel(),
    child:Consumer<MainModel>(
      builder: (context,model,child)=>Scaffold(
        appBar: AppBar(
          title: const Text("Counter using Provider"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("You have pushed the button this many times:"),
          Text("${model.counter}", style: TextStyle(fontSize: 14,color: Colors.green),)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:()=> model.counter--,
          //onPressed:()=> Provider.of<MainModel>(context, listen: false)._counter++,
          tooltip: "Increment",
          child: const Icon(Icons.add),
        ),
      )
    ));

  }
}

class MainModel extends ChangeNotifier{
  int _counter=0;
  int get counter=>_counter;

  set counter(int value){
    if(value!=_counter){
      _counter=value;
      notifyListeners();
    }
  }
}