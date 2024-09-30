import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixieapp/blocs/Navbar_Bloc/navbar_event.dart';
import 'package:pixieapp/blocs/Navbar_Bloc/navbar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  NavBarBloc() : super(const NavBarState(selectedIndex: 0)) {
    on<NavBarItemTapped>((event, emit) {
      emit(NavBarState(selectedIndex: event.index));
    });
  }
}
