part of 'bloc.dart';

abstract class EventBloc {}

class InitialEvent extends EventBloc {
  InitialEvent();
}

class AddTOCart extends EventBloc {
  DealProducts prod;
  AddTOCart({required this.prod});
}
