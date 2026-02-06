// ignore_for_file: non_constant_identifier_names

import 'status.dart';

class ApiResponces<T> {
  Status? status;
  T? data;
  String? message;
  int? code;
  bool? success;

  ApiResponces({this.data, this.message, this.status, this.code, this.success});

  ApiResponces.Idle() : status = Status.IDLE;
  ApiResponces.Loading() : status = Status.LOADING;
  ApiResponces.Success(this.data, {this.code, this.message, this.success})
    : status = Status.SUCCESS;
  ApiResponces.Error(this.message, {this.code, this.success})
    : status = Status.ERROR;
}
