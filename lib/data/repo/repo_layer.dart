import 'package:valorantgame/data/webservices/web_service.dart';

class RepoLayer {
  final WebServices webServices;

  RepoLayer({required this.webServices});

  Future<dynamic> getAgent() async {
    return await webServices.getAgent();
  }
}
