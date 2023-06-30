import 'dart:convert';
import 'dart:io';

import 'package:practice/model/album_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter/material.dart';

import 'home_repo.dart';

class HomeBloc {
  final HomeRepo _homeRepo = HomeRepo();
  BehaviorSubject<String> postBehavior = BehaviorSubject();

  Stream<String> get postStream => postBehavior.stream;

  final _repository = RepositoryPost();

  setAlbum(String title) async {
    Album ip = await _homeRepo.createAlbum(title);
    postBehavior.sink.add(ip.title);
  }
}

final homeBloc=HomeBloc();