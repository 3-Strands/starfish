import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starfish/models/user.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/wrappers/sms.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit({
    required AppUser currentUser,
    List<User>? selectedUsers,
  })  : _currentUser = currentUser,
        _alreadySelectedUsers = selectedUsers ?? [],
        super(ContactsState()) {
    _checkPermissions();
  }

  final AppUser _currentUser;
  final List<User> _alreadySelectedUsers;

  void _checkPermissions() async {
    try {
      if (!mightBeAbleToAccessContacts) {
        emit(state.copyWith(permission: ContactPermission.unavailable));
      } else if (await hasContactAccess()) {
        await _loadContacts();
      }
    } catch (_) {
      emit(state.copyWith(permission: ContactPermission.denied));
    }
  }

  Future<void> _loadContacts() async {
    final selectedNumbers =
        _alreadySelectedUsers.map((user) => user.fullNumber).toSet();

    final contacts = (await getAllContacts())
        .where((user) => !(user.diallingCode == _currentUser.diallingCode &&
            user.phone == _currentUser.phone))
        .toList();

    emit(state.copyWith(
      permission: ContactPermission.granted,
      contacts: contacts,
      alreadySelectedContacts: contacts
          .where((contact) => selectedNumbers.contains(contact.fullNumber))
          .map((contact) => contact.id)
          .toSet(),
    ));
  }

  void contactToggled(String userId) {
    final newlySelectedContacts = {...state.newlySelectedContacts};
    if (newlySelectedContacts.contains(userId)) {
      newlySelectedContacts.remove(userId);
    } else {
      newlySelectedContacts.add(userId);
    }
    emit(state.copyWith(
      newlySelectedContacts: newlySelectedContacts,
    ));
  }

  void queryChanged(String query) {
    emit(state.copyWith(query: query));
  }

  void inviteRequested() {
    // TODO: Invite users in newlySelectedContacts.
  }
}

extension HashPhone on User {
  String get fullNumber => '$diallingCode $phone';
}
