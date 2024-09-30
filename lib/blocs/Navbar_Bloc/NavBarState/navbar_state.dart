import 'package:equatable/equatable.dart';

class NavBarState extends Equatable {
  final int selectedIndex;

  const NavBarState({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}
