import 'package:deneme/firebase/firebase_store.dart';
import 'package:deneme/model/user.dart';
import 'package:deneme/ui/user_card.dart';
import 'package:deneme/util/colors.dart';
import 'package:deneme/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:deneme/ui/navBar.dart';
import 'package:deneme/util/analytics.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();

  static const String routeName = "/search";

}

class _SearchState extends State<SearchView>
{
  Future? finished;
  List all = [];
  List results = [];
  List newList = [];

  TextEditingController textInput = TextEditingController();

  @override
  void initState(){
    super.initState();
    textInput.addListener(_searchChanged);
  }

  @override
  void dispose(){
    textInput.removeListener(_searchChanged);
    textInput.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    finished =_getList();
  }

  _searchChanged(){

    if(textInput.text != "")
      {
        for(var item in all)
          {
            if(item.get("name").contains(textInput.text))
              {
                newList.add(item);
              }
          }
        setState((){results = newList;
        newList=[];});
      }
    else{
      setState((){
        results = all;
      });
    }
  }

  _getList()async{
    var data = StoreService.myStore.collection("users").snapshots();
    setState((){
      data.listen((event) {all = event.docs;});
    });
    _searchChanged();
    return "finished";
  }


  @override
  Widget build(BuildContext context)
  {
    FireAnalytics.setAnalyticsScreen(SearchView.routeName);
    return GestureDetector(onTap: (){
      FocusScope.of(context).requestFocus(new FocusNode());
      textInput.clear();
    },child:Scaffold(
      appBar: AppBar(title: Text("Food, Drink, People...", style: appBarTexts,), centerTitle: true, backgroundColor: AppColors.appBarBackground,),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(children: [
          SizedBox(height: 24,),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width/1.2,
              child: TextField(
              controller: textInput,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(64),borderSide: BorderSide(color: Colors.lightBlue, width: 4)),
                filled: true,
                fillColor: Colors.grey,
                hintText: ("What are you looking for?"),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(64)),
                prefixIcon: IconButton(onPressed: (){},icon: Icon(Icons.search),),
                suffixIcon: IconButton(
                  onPressed: (){
                    textInput.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            ),
          ],
        ),
          Expanded(child: Container(
            color: Colors.grey,
            child: ListView.builder(
              itemCount: results.length,
                itemBuilder: (BuildContext context, int index){
                return UserCard(theUser: myUser.fromJson(results[index].data() as Map<String, dynamic>));
                }),
          ))

        ]),
      ),
      bottomNavigationBar: NavBar(),
    ));
  }
}