import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_query/graphql_setup/services/graphql_client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLView extends StatelessWidget {
  GraphQLView({super.key});

  //? add these quaries in a different class.

  final updateUserMutation = gql(r'''
    mutation updateUser($id: ID, $first_name: String, $last_name: String) {
    updateUser(
    input: {id: $id, first_name: $first_name, last_name: $last_name,}
      ) {
    user {
      id
      first_name
      last_name
    }
    messages {
      field
      message
    }
  }
}
''');

  final getUserQuery = gql(r'''
      query getUser($id: ID) {
      user(id: $id) {
      id
      first_name
      last_name
   }
}
''');

  static final userUpdatedMutation = gql(r'''
subscription userUpdatedSubscription($id: String) {
        userUpdatedSubscription(id: $id) {
            ...UserFragment
        }
    }
    fragment UserFragment on User {
        id
        first_name
        last_name
    }
    ''');

//!another way to consume the query
//? Now add this your view model or your notifier for GET Queries
  Future<void> getUser() async {
    final result = await client2.value.query(
      QueryOptions(
        document: getUserQuery,
        variables: const {
          "id": "1",
        },
      ),
    );
//? Now add fxn can be passed in the notifier and handle logic properly.
    result.data;
  }

//? Now add this your view model or your notifier for creating, updating and deleting an object
  Future<void> updateUser() async {
    final result = await client2.value.mutate(
      MutationOptions(
        document: updateUserMutation,
        variables: const {"id": "1", "first_name": "John", "last_name": "Doe"},
      ),
    );

//? Now add fxn can be passed in the notifier and handle logic properly.
    result.data;
  }

  void _subscribe() async {
    final subscription = await websocketClient.subscribe(
      SubscriptionOptions(
        document: userUpdatedMutation,
      ),
    );

    subscription.listen((results) {
      final result = results.data?['user'];
      print('First Name: ${result["first_name"]}');
      print('Last Name: ${result["last_name"]}');
      // Handle the real-time update, e.g., update UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //!Query
            Query(
              options: QueryOptions(
                document: getUserQuery,
                variables: const {
                  "id": "1",
                },
              ),
              builder: (
                QueryResult result, {
                Future<QueryResult> Function(FetchMoreOptions)? fetchMore,
                Future<QueryResult?> Function()? refetch,
              }) {
                if (result.hasException) {
                  return const Text("Error");
                }
                if (result.isLoading) {
                  return const CircularProgressIndicator();
                }
                final user = result.data?["user"];
                return ListTile(
                  title: Text(user["first_name"]),
                  subtitle: Text(user["last_name"]),
                );
              },
            ),
            //!mutations
            Mutation(
                options: MutationOptions(
                  document: updateUserMutation,
                  update: (cache, result) => cache,
                  onCompleted: (dynamic resultData) {
                    print(resultData);
                  },
                ),
                builder: (runMutation, result) => TextButton(
                    onPressed: () => runMutation({
                          'counterId': 21,
                        }),
                    child: Text('Add Counter'))),

            //!Subscriptions

            Subscription(
              options: SubscriptionOptions(
                document: userUpdatedMutation,
              ),
              builder: (result) {
                final user = result.data?["user"];
                return ListTile(
                  title: Text(user["first_name"]),
                  subtitle: Text(user["last_name"]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
