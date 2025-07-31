import 'package:bloc/bloc.dart';

class ApresentationCubit extends Cubit<int> {
  int _currentPage = 0;
  final int _totalPages = 3;

  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  ApresentationCubit() : super(0);

  void updatePage({int page = -1}) {
    if (page == -1) {
      _currentPage = _currentPage + 1;
      emit(_currentPage);
      return;
    }
    _currentPage = page;
    emit(_currentPage);
  }
}
