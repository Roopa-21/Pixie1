import 'package:equatable/equatable.dart';

abstract class NavBarEvent extends Equatable {
  const NavBarEvent();

  @override
  List<Object?> get props => [];
}

class NavBarItemTapped extends NavBarEvent {
  final int index;

  const NavBarItemTapped(this.index);

  @override
  List<Object?> get props => [index];
}
