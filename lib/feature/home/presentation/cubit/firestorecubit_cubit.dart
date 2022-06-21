import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'firestorecubit_state.dart';

class FirestorecubitCubit extends Cubit<FirestorecubitState> {
  FirestorecubitCubit() : super(FirestorecubitInitial());
}
