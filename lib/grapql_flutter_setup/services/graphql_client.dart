import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

//!Another implementation
final HttpLink _httpLink = HttpLink(
  "<YOUR-BASE-URL>",
  defaultHeaders: {
    'Authorization': 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
    'AuthorizationSource': 'API',
  },
);

final ValueNotifier<GraphQLClient> client2 = ValueNotifier(GraphQLClient(
  link: _httpLink,
  cache: GraphQLCache(),
));

final httpLink = HttpLink("http://10.0.2.2:400/");

ValueNotifier<GraphQLClient> client1 = ValueNotifier(
  GraphQLClient(link: httpLink, cache: GraphQLCache()),
);
