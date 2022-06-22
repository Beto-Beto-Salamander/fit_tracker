import 'package:equatable/equatable.dart';

import 'package:fit_tracker/lib.dart';

class StoreParams extends Equatable {
  final UserEntity user;

  const StoreParams({ required this.user});

  @override
  List<Object> get props => [ user];


  StoreParams copyWith({
    UserEntity? user,
  }) {
    return StoreParams(
      
      user: user ?? this.user,
    );
  }

  @override
  bool get stringify => true;

}
