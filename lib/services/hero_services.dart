import 'dart:convert';

import 'package:dota_hero_list/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HeroProvider extends ChangeNotifier {
  bool _loading = false;
  bool get loading => _loading;
  set loading(bool newBool) {
    _loading = newBool;
    notifyListeners();
  }

  String _statusGetHero = "";
  String get statusGetHero => _statusGetHero;
  set statusGetHero(String newString) {
    _statusGetHero = newString;
    notifyListeners();
  }

  List _dataHeroes = [];
  List get dataHeroes => _dataHeroes;
  set dataHeroes(List newList) {
    _dataHeroes = newList;
    notifyListeners();
  }

  Future<dynamic> getDataHeroes() async {
    try {
      var response = await http.get(Uri.parse("$baseUrl/api/herostats"));
      if (response.statusCode == 200) {
        _statusGetHero = "Berhasil";
        var data = jsonDecode(response.body);
        _dataHeroes = data;
        print("isi data heroes: $dataHeroes");
      } else {
        _statusGetHero = "Gagal";
      }
    } catch (e) {
      _statusGetHero = "Gagal";
      print("isi error: $e");
    }
  }
}
