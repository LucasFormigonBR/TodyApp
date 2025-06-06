abstract class TarefaState {}

class InitialTarefaState extends TarefaState {}

class LoadingTarefaState extends TarefaState {}

class SuccessTarefaState extends TarefaState {
  final String message;

  SuccessTarefaState(this.message);
}

class LoadedTarefaState extends TarefaState {
  final List<String> tarefas;

  LoadedTarefaState(this.tarefas);
}

class ErrorTarefaState extends TarefaState {
  final String message;

  ErrorTarefaState(this.message);
}
