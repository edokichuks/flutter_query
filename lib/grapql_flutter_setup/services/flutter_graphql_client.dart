

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final httpLink = HttpLink("http://10.0.2.2:400/");

ValueNotifier<GraphQLClient> client1 = ValueNotifier(
  GraphQLClient(link: httpLink, cache: GraphQLCache()),
);
