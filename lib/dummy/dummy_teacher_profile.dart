import 'package:self_project/object/object_extended_teacher_profile.dart';
import 'package:self_project/object/object_teacher_profile.dart';
import 'dummy_profile.dart';

ExtendedTeacherProfile eunchaeTeacher = ExtendedTeacherProfile(
  profile: eunchae,
  nickname: '최고의 선생',
  profileImagePath: 'assets/image/profile_eunchae.jpg',
  univ: '경희',
  major: '식품환경신소재공학과',
  studentID: 16,
  budget: 4,
  subjects: [Subject.math],
);
ExtendedTeacherProfile haewonTeacher = ExtendedTeacherProfile(
  profile: haewon,
  nickname: '수학천재',
  profileImagePath: 'assets/image/profile_haewon.jpg',
  univ: '경비',
  major: '컴퓨터공학과',
  studentID: 19,
  budget: 4,
  subjects: [Subject.korean, Subject.society],
);
ExtendedTeacherProfile jiheonTeacher = ExtendedTeacherProfile(
  profile: jiheon,
  nickname: '특징: 귀여움',
  univ: '한국외국어',
  subjects: [Subject.english],
);
ExtendedTeacherProfile heechanTeacher = ExtendedTeacherProfile(
  profile: heechan,
  nickname: '월드컵 우승 경력 4회',
  profileImagePath: 'assets/image/profile_heechan.jpg',
  univ: '울산',
  major: '경제학과',
  studentID: 23,
  budget: 1000,
  subjects: [Subject.math, Subject.science, Subject.essay, Subject.others],
);
ExtendedTeacherProfile messiTeacher = ExtendedTeacherProfile(
  profile: messi,
  nickname: '메가스터디 1타 강사 출신',
  univ: '뉴욕주립',
  major: '단소학과',
  studentID: 89,
  budget: 1,
  subjects: [Subject.math],
);

List<ExtendedTeacherProfile> teacherProfiles = <ExtendedTeacherProfile>[
  eunchaeTeacher,
  haewonTeacher,
  jiheonTeacher,
  heechanTeacher,
  messiTeacher
];
