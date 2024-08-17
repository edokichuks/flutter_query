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

WebSocketLink websocketLink = WebSocketLink(
  '<YOUR-GRAPHQL-SUBSCRIPTION-ENDPOINT>',
  config: SocketClientConfig(
    autoReconnect: true,
    inactivityTimeout: Duration(seconds: 30),
  ),
);

GraphQLClient websocketClient = GraphQLClient(
  link: websocketLink,
  cache: GraphQLCache(),
);
