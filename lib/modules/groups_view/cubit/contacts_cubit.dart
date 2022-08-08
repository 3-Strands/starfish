import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/helpers/uuid_generator.dart';
import 'package:starfish/wrappers/sms.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit({
    required User currentUser,
    List<User>? selectedUsers,
  })  : _currentUser = currentUser,
        _selectedUsers = selectedUsers ?? [],
        super(ContactsState());

  final User _currentUser;
  final List<User> _selectedUsers;

  void contactsRequested() async {
    try {
      if (!mightBeAbleToAccessContacts) {
        emit(state.copyWith(permission: ContactPermission.unavailable));
      } else if (await hasContactAccess(shouldAskIfUnknown: true)) {
        await _loadContacts();
      } else {
        emit(state.copyWith(permission: ContactPermission.denied));
      }
    } catch (_) {
      emit(state.copyWith(permission: ContactPermission.denied));
    }
  }

  Future<void> _loadContacts() async {
    final selectedNumbers =
        _selectedUsers.map((user) => user.fullPhone).toSet();

    final contacts = (await getAllContacts())
        .where((user) => !(user.diallingCode == _currentUser.diallingCode &&
            user.phone == _currentUser.phone))
        .toList();

    emit(state.copyWith(
      permission: ContactPermission.granted,
      contacts: contacts,
      alreadySelectedContacts: contacts
          .where((contact) => selectedNumbers.contains(contact.fullPhone))
          .toSet(),
    ));
  }

  void contactToggled(User user) {
    final newlySelectedContacts = {...state.newlySelectedContacts};
    if (newlySelectedContacts.contains(user)) {
      newlySelectedContacts.remove(user);
    } else {
      newlySelectedContacts.add(user);
    }
    emit(state.copyWith(
      newlySelectedContacts: newlySelectedContacts,
    ));
  }

  void personNameSubmitted(String name) {
    if (name.isEmpty) {
      return;
    }
    final lowerCaseName = name.toLowerCase();
    final userMatchesName =
        (User user) => user.name.toLowerCase() == lowerCaseName;

    if (state.alreadySelectedContacts.any(userMatchesName) ||
        state.newlySelectedContacts.any(userMatchesName)) {
      emit(state.copyWith(error: ContactError.nameAlreadyExists));
      return;
    }
    contactToggled(User(
      id: UuidGenerator.uuid(),
      name: name,
    ));
  }

  void queryChanged(String query) {
    emit(state.copyWith(query: query));
  }

  void inviteRequested() {
    // TODO: Invite users in newlySelectedContacts.
  }
}
