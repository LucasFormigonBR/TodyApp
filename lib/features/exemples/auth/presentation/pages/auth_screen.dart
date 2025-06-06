// import 'package:flutter/material.dart';
// import 'package:flutter_mvvm_features_types/features/auth/domain/entities/user.dart';
// import 'package:flutter_mvvm_features_types/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:flutter_mvvm_features_types/features/auth/presentation/bloc/auth_state.dart';

// import '../bloc/auth_event.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({super.key});

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   late final AuthBloc bloc;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     bloc = AuthBloc();
//     bloc.inputAuth.add(LoadAuthEvent());
//   }

//   @override
//   void dispose() {
//     bloc.inputAuth.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Auth Page")),
//       body: StreamBuilder<AuthState>(
//         stream: bloc.streamAuth,
//         builder: (context, snapshot) {
//           final user = snapshot.data?.user ?? User(email: "", name: "");
//           if (snapshot.hasData) {
//             return Center(child: Text(user.toString()));
//           }
//           return const Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }
