import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:starfish/models/user.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/wrappers/sms.dart';

part 'contact_list_state.dart';

class ContactListCubit extends Cubit<ContactListState> {
  ContactListCubit({
    required AppUser currentUser,
    List<User>? selectedUsers,
  })  : _currentUser = currentUser,
        _selectedUsers = selectedUsers ?? [],
        super(ContactListState()) {
    _init();
  }

  final AppUser _currentUser;
  final List<User> _selectedUsers;

  void _init() async {
    try {
      if (await hasContactAccess(shouldAskIfUnknown: true)) {
        await _loadContacts();
      } else {
        emit(state.copyWith(permission: ContactListPermission.denied));
      }
    } catch (_) {
      emit(state.copyWith(permission: ContactListPermission.denied));
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
      permission: ContactListPermission.granted,
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

  void queryChanged(String query) {
    emit(state.copyWith(query: query));
  }
}
