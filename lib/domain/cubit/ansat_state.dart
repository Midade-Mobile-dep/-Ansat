part of 'ansat_cubit.dart';

@immutable
abstract class AnsatState {}

class AnsatInitial extends AnsatState {}



class AnsatChangeFavoritState extends AnsatState {}
class AnsatChangeBottomNavState extends AnsatState {}
class AnsatLoadingHomeDataState extends AnsatState {}

class AnsatSuccessHomeDataState extends AnsatState {}

class AnsatErrorHomeDataState extends AnsatState {}

class AnsatLoadingCategoryItemsState extends AnsatState {}

class AnsatSuccessCategoryItemsState extends AnsatState {}

class AnsatErrorCategoryItemsState extends AnsatState {}

class AnsatLoadingSerachState extends AnsatState {}

class AnsatSuccessSerachState extends AnsatState {}

class AnsatErrorSerachState extends AnsatState {}
