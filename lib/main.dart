import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController();
  final List<bool> _selection = [true,false,false];
  late String tip = 'Please Insert Amount';

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              if(tip != null)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    tip,
                    style: const TextStyle(fontSize:30),
                  ),
                ),
              const Text('Total Amount',style: TextStyle(color:Colors.red),),
              SizedBox(
                width:70,
                child: TextField(
                  controller: controller,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(hintText: '\$100.00'),
                  keyboardType: const TextInputType.numberWithOptions(decimal:true),
                ),
              ),
              Padding(
                padding:const EdgeInsets.all(20),
                child: ToggleButtons(
                  children: const [Text('10%'),Text('15%'),Text('20%')],
                  isSelected: _selection,
                  onPressed: updateSelection
                ),
              ),
              MaterialButton(
                onPressed: calculateTip, 
                child: const Text('Calculate Tip'),
                color: Colors.green,
                textColor: Colors.white,
              )
            ]
          )
        )
      );
    
  }

  void updateSelection(int selectIndex){
    setState(
      (){
        for(int i=0;i<_selection.length;i++){
          _selection[i] = selectIndex == i;
        }
      }
    );
  }

  void calculateTip(){
    if(controller.text != ''){
      final totalAmount = double.parse(controller.text);
    
      final selectedIndex = _selection.indexWhere((element)=>element);
      final tipPercentage = [0.1,0.15,0.2][selectedIndex];

      final tipTotal = (totalAmount * tipPercentage).toStringAsFixed(2);

      setState(
        (){
          tip = '\$$tipTotal';
        }
      );
    }
    
  }
}
