import 'package:carlsberg/model/event_model.dart';
import 'package:carlsberg/model/event_response.dart';
import 'package:carlsberg/service/api_service.dart';
import 'package:carlsberg/viewmodel/base_viewmodel.dart';

class EventViewModel extends BaseViewModel{
  Api api = Api();
  List<EventModel> tempList = List<EventModel>();
  List<EventModel> eventList = List<EventModel>();
  DateTime  pickDate;

  Future getEventList() async{

    EventResponse _eventResponse = await api.getEventList();
        tempList.addAll(_eventResponse.data);
     eventList = List.from(tempList.reversed);
    notifyListeners();


  }

  Future<bool> createEvent(String eventName , String point , String date) async{
    var success = await api.createEvent(eventName, int.parse(point), date);
    return success;

  }

  Future<bool> insertPoint(int eventId , int employeeId , int point) async{
    var success = await api.insertPoint(eventId, employeeId, point);
    return success;
  }

  Future<bool> redeemPoint(String  employeeId , String redeemPoint) async{
    int id =int.parse(employeeId) ;
    int point = int.parse(redeemPoint);
    var success = await api.redeemPoint(id, point);
    return success;
  }

  Future checkPoint(String employeeId) async{

  }
}