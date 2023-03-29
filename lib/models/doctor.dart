import 'package:cloud_firestore/cloud_firestore.dart';
class DoctorModel {
  const DoctorModel(
      {required this.id,
         required this.doctorDegree,
        required this.doctorName ,
        required this.doctorSpecialty ,
        required this.doctorRating ,
        required this.doctorHospital ,
        required this.doctorNumberOfPatient ,
        required this.doctorYearOfExperience ,
        required this.doctorDescription ,
        required this.doctorPicture ,
        required this.doctorIsOpen });
  final String id;
  final String doctorName;
  final String doctorDegree;
  final String doctorSpecialty;
  final String doctorRating;
  final String doctorHospital;
  final String doctorNumberOfPatient;
  final String doctorYearOfExperience;
  final String doctorDescription;
  final String doctorPicture;
  final bool doctorIsOpen;



factory DoctorModel.fromSnapshot(
DocumentSnapshot<Map<String, dynamic>> document) {
  final data = document.data()!;
  return DoctorModel(id: document.id,
      doctorDegree: data["DoctorDegree"],
      doctorName: data["DoctorName"],
      doctorSpecialty: data["DoctorSpacialty"],
      doctorRating: data["DoctorRating"],
      doctorHospital: data["DoctorHospital"],
      doctorNumberOfPatient: data["DoctorNoPatient"],
      doctorYearOfExperience: data["DoctorExperience"],
      doctorDescription: data["DoctorDescription"],
      doctorPicture: data["DoctorPicture"],
      doctorIsOpen: data["DoctorIsOpen"]);
  }
}

// var topDoctors = [
//   Doctor(
//     doctorName: 'dr. Gilang Segara Bening',
//     doctorSpecialty: 'Heart',
//     doctorRating: '4.8',
//     doctorHospital: 'Persahabatan Hospital',
//     doctorNumberOfPatient: '1221',
//     doctorYearOfExperience: '3',
//     doctorDescription:
//         'is one of the best doctors in the Persahabat Hospital. He has saved more than 1000 patients in the past 3 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
//     doctorPicture: 'img-men-01.png',
//     doctorIsOpen: true
//   ),
//   Doctor(
//     doctorName: 'dr. Shabil Chan',
//     doctorSpecialty: 'Dental',
//     doctorRating: '4.7',
//     doctorHospital: 'Columbia Asia Hospital',
//     doctorNumberOfPatient: '964',
//     doctorYearOfExperience: '4',
//     doctorDescription:
//         'is one of the best doctors in the Columbia Asia Hospital. He has saved more than 900 patients in the past 4 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
//     doctorPicture: 'img-women-01.png',
//     doctorIsOpen: false
//   ),
//   Doctor(
//     doctorName: 'dr. Mustakim',
//     doctorSpecialty: 'Eye',
//     doctorRating: '4.9',
//     doctorHospital: 'Salemba Carolus Hospital',
//     doctorNumberOfPatient: '762',
//     doctorYearOfExperience: '5',
//     doctorDescription:
//         'is one of the best doctors in the Salemba Carolus Hospital. He has saved more than 700 patients in the past 5 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
//     doctorPicture: 'img-men-02.png',
//     doctorIsOpen: true
//   ),
//   Doctor(
//     doctorName: 'dr. Suprihatini',
//     doctorSpecialty: 'Heart',
//     doctorRating: '4.8',
//     doctorHospital: 'Salemba Carolus Hospital',
//     doctorNumberOfPatient: '1451',
//     doctorYearOfExperience: '6',
//     doctorDescription:
//         'is one of the best doctors in the Salemba Carolus Hospital. He has saved more than 1400 patients in the past 6 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
//     doctorPicture: 'img-women-02.png',
//     doctorIsOpen: false
//   ),
//   Doctor(
//     doctorName: 'dr. Robert Posy',
//     doctorSpecialty: 'Child',
//     doctorRating: '4.6',
//     doctorHospital: 'Kariadi Hospital',
//     doctorNumberOfPatient: '551',
//     doctorYearOfExperience: '3',
//     doctorDescription:
//         'is one of the best doctors in the Kariadi Carolus Hospital. He has saved more than 500 patients in the past 3 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
//     doctorPicture: 'img-men-03.png',
//     doctorIsOpen: true
//   ),
//   Doctor(
//     doctorName: 'dr. Matilde Hani',
//     doctorSpecialty: 'Heart',
//     doctorRating: '4.7',
//     doctorHospital: 'Wiloso Hospital',
//     doctorNumberOfPatient: '888',
//     doctorYearOfExperience: '4',
//     doctorDescription:
//         'is one of the best doctors in the Wiloso Hospital. He has saved more than 800 patients in the past 4 years. He has also received many awards from domestic and abroad as the best doctors. He is available on a private or schedule.',
//     doctorPicture: 'img-women-03.png',
//     doctorIsOpen: true
//   ),
// ];

// class DoctorMenu {
//   String name;
//   String image;
//
//   DoctorMenu({this.name = '', this.image = ''});
// }
//
// var doctorMenu = [
//   DoctorMenu(name: 'Consultation', image: 'img-consultation.svg'),
//   DoctorMenu(name: 'Dental', image: 'img-dental.svg'),
//   DoctorMenu(name: 'Heart', image: 'img-heart.svg'),
//   DoctorMenu(name: 'Hospitals', image: 'img-hospital.svg'),
//   DoctorMenu(name: 'Medicines', image: 'img-medicine.svg'),
//   DoctorMenu(name: 'Physician', image: 'img-physician.svg'),
//   DoctorMenu(name: 'Skin', image: 'img-skin.svg'),
//   DoctorMenu(name: 'Surgeon', image: 'img-surgeon.svg'),
// ];
