import 'package:equatable/equatable.dart';

class UIMessage extends Equatable {
  const UIMessage({this.errorMsg, this.successMsg, this.data});

  final String? successMsg;
  final String? errorMsg;
  final dynamic data;

  Map<String, dynamic> toJson() => {
        'successMsg': successMsg,
        'errorMsg': errorMsg,
        'data': data,
      };

  @override
  List<Object?> get props => [successMsg, errorMsg, data];
}
