import 'package:carlsberg/model/event_model.dart';
import 'package:carlsberg/model/event_response.dart';
import 'package:carlsberg/service/api_service.dart';
import 'package:carlsberg/viewmodel/base_viewmodel.dart';

class EventViewModel extends BaseViewModel{
  Api api = Api();
  List<EventModel> tempList = List<EventModel>();
  List<EventModel> eventList = List<EventModel>();

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
}