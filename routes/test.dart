import 'dart:io';
import 'package:dart_frog/dart_frog.dart';

Future<Response> onRequest(RequestContext context) async {
  final result = context.request.method;

  switch(result){
    case HttpMethod.get:
      return _onGet(context);
    case HttpMethod.post:
      return _onPost(context);    

    default:
      return Response.json(
        statusCode: HttpStatus.badRequest, body: {'data': 'bad request'},
      );
  }
}

Future<Response> _onPost(RequestContext context) async {

  final token = context.request.headers['token'];
    if (token == null) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {'error': 'Token is missing'},
      );
    }
  
  final body = await context.request.json() as Map<String, dynamic>;

  if(body.containsKey('name')){

    return Response.json(statusCode: HttpStatus.ok, body: {
      'data': [body['name'],body['username'],body['phone']],
    },);
  } else {
    return Response.json(
      statusCode: HttpStatus.badRequest,
      body: {'error': 'name field was missing'},);
  }
} 

Future<Response> _onGet(RequestContext context) async {

  final token = context.request.headers['token'];
    if (token == null) {
      return Response.json(
        statusCode: HttpStatus.unauthorized,
        body: {'error': 'Token is missing'},
      );
    }

  final data = context.request.headers['token'];
  return Response.json(
    statusCode: HttpStatus.ok,
    body: {'data': 'A good request we recieved this $data'},
    headers: {'token': 'not valid $data'},);
}
