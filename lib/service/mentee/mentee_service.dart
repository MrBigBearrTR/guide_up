import '../../core/models/mentor/mentee_model.dart';
import '../../repository/mentee/mentee_repository.dart';

class MenteeService {
  late MenteeRepository _menteeRepository;


  MenteeService() {
    _menteeRepository = MenteeRepository();
  }

  Future<double> getTotalPriceByUserId(String userId) async {
    List <Mentee> menteeList = await _menteeRepository.getMenteeListByUserId(userId);
    double totalPrice = 0.0;

    for (var mentee in menteeList) {
      if (mentee.isApproval() && mentee.getPrice() != null && double.parse(mentee.getPrice()!) > 0) {
        totalPrice += double.parse(mentee.getPrice()!);
      } 
    }
    return totalPrice;
  }
}