// ignore_for_file: non_constant_identifier_names

import 'status.dart';

class ApiResponses<T> {
  Status? status;
  T? data;
  String? message;
  int? code;
  bool? success;

  ApiResponses({this.data, this.message, this.status, this.code, this.success});

  ApiResponses.Idle() : status = Status.IDLE;
  ApiResponses.Loading() : status = Status.LOADING;
  ApiResponses.Success(this.data, {this.code, this.message, this.success})
    : status = Status.SUCCESS;
  ApiResponses.Error(this.message, {this.code, this.success})
    : status = Status.ERROR;
}
