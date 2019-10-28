import 'package:flutterdemo/src/models/coin.dart';
//import 'package:flutterdemo/src/models/private_data.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CoinsBloc {
  BehaviorSubject<List<Coin>> _coins$;
  BehaviorSubject<int> _maxListSize$;
  List<Coin> _defaultCoinList;

  BehaviorSubject<List<Coin>> get coins$ => _coins$;
  BehaviorSubject<int> get maxListSize$ => _maxListSize$;

  CoinsBloc() {
    _coins$ = BehaviorSubject<List<Coin>>();
    _maxListSize$ = BehaviorSubject<int>();
    _defaultCoinList = [];
    getCoins();
  }

  Future<void> getCoins() async {
    await _pushMaxListSize();
    //final String _maxList = _maxListSize$.value.toString();
    //final PrivateData _privateData =  await PrivateData.fromAssets("apikeyconfig.json");
    final String _url = "https://min-api.cryptocompare.com/data/top/totalvolfull?limit=10&tsym=USD&api_key=f23842408e3a0c02fce7c87f82eb4690c45b7dcd9bcfd8e88841f9d83c85ddf6";
    final _response = await http.get(_url);
    final Map<String, dynamic> _json = jsonDecode(_response.body);
    _defaultCoinList = [];
    for (var object in _json["Data"]) {
      _defaultCoinList.add(Coin.fromJson(object));
    }

    


    _coins$.add(_defaultCoinList);
  }

  void filterCoins(String text) {
    List<Coin> _result = [];
    text = text.toLowerCase().replaceAll(' ', '');
    for (var coin in _defaultCoinList) {
      final String _compareString =
          (coin.coinInfo.fullName + coin.coinInfo.symbol)
              .toLowerCase()
              .replaceAll(' ', '');
      if (_compareString.contains(text)) {
        _result.add(coin);
      }
    }
    _coins$.add(_result);
  }

  Future<void> _pushMaxListSize() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    final int _maxSize = _prefs.getInt("max size");
    _maxListSize$.add(_maxSize ?? 100);
  }

  Future<void> setMaxListSize(int value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt("max size", value);
    _maxListSize$.add(value);
  }

  void dispose() {
    _coins$.close();
    _maxListSize$.close();
  }
}
