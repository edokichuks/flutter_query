import 'package:flutter/material.dart';
import 'package:flutter_query/grapql_flutter_setup/services/flutter_graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';



//!2021 article on graphql

// class MyHomePage extends StatelessWidget {

//   final String readCounters = """
//     query readCounters(\$counterId: Int!) {
//         counter {
//             name
//             id
//         }
//     }
// """;

//   const MyHomePage({super.key});
//     @override
//     Widget build(BuildContext context) {
//         return Query(
//             options: QueryOptions(
//                 document: gql(readCounters),
//                 variables: {
//                 'counterId': 23,
//                 },
//                 pollInterval: Duration(seconds: 10),
//             ),
//             builder: (result, {fetchMore, refetch}) {
//                             if (result.hasException) {
//                     return Text(result.exception.toString());
//                 }

//                 if (result.isLoading) {
//                     return Text('Loading');
//                 }

//                 // it can be either Map or List
//                 List counters = result.data?['counter'];

//                 return ListView.builder(
//                 itemCount: repositories.length,
//                 itemBuilder: (context, index) {
//                     return Text(counters\[index\]['name']);
//                 });
//             },
//         );
//     }
// }

//?     Mutation code for creating, updating, and deleting

//?     Mutation(
//?       options: MutationOptions(
//?         document: gql(addCounter),
//?         update: (GraphQLDataProxy cache, QueryResult result) {
//?           return cache;
//?         },
//?         onCompleted: (dynamic resultData) {
//?           print(resultData);
//?         },
//?       ),
//?       builder: (
//?         RunMutation runMutation,
//?         QueryResult result,
//?       ) {
//?         return FlatButton(
//?           onPressed: () => runMutation({
//?             'counterId': 21,
//?           }),
//?           child: Text('Add Counter')
//?         );
//?       },
//?     );

//? Subscription

const counterSubscription = '''
subscription counterAdded {
    counterAdded {
        name
        id
    }
}
''';

//? Subscription(
//?     options: SubscriptionOptions(
//?         document: gql(counterSubscription),
//?     ),
//?     builder: (result) {
//?         if (result.hasException) {
//?             return Text("Error occured: " + result.exception.toString());
//?         }

//?         if (result.isLoading) {
//?             return Center(
//?                 child: const CircularProgressIndicator(),
//?             );
//?         }

//?         return ResultAccumulator.appendUniqueEntries(
//?             latest: result.data,
//?             builder: (context, {results}) => ...
//?         );
//?     }
//? ),
