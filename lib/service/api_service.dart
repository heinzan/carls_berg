import 'package:carlsberg/app_constant.dart';
import 'package:carlsberg/model/available_point_modae.dart';
import 'package:carlsberg/model/event_model.dart';
import 'package:carlsberg/model/event_response.dart';
import 'package:dio/dio.dart';

class Api {
  Response response;
  Dio dio = Dio();

  Future<EventResponse> getEventList() async {

    response = await dio.get(AppConstant.BASEURL + "events");

    EventResponse eventResponse = EventResponse.fromJson(response.data);

    return eventResponse;

  }

  Future<bool> createEvent(String eventName, int point, String date) async {
    FormData formData = FormData.fromMap(
        {"event_name": eventName, "event_point": point, "event_date": date});

    response =
        await dio.post(AppConstant.BASEURL + "event/create", data: formData);

    var success = response.statusCode == 200;
    return success;
  }

  Future<bool> insertPoint(int eventId, int employeeId, int point) async {
    FormData formData = FormData.fromMap(
        {"event_id": eventId, "employee_card_id": employeeId, "point": point});

    response =
        await dio.post(AppConstant.BASEURL + "point/insert", data: formData);

    var success = response.statusCode == 200;
    return success;
  }


  Future<bool> redeemPoint(int employeeId , int point ) async {

    FormData formData = FormData.fromMap(
        {"employee_card_id": employeeId, "redeem_point": point});

    response =
    await dio.post(AppConstant.BASEURL + "point/redeem", data: formData);

    var success = response.statusCode == 200;
    return success;
  }

  Future<AvailablePoint> checkPoint(int employeeId) async{

  }


}
