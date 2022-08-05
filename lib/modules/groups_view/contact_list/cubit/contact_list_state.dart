part of 'contact_list_cubit.dart';

enum ContactListPermission {
  unknown,
  granted,
  denied,
  unavailable,
}

@immutable
class ContactListState {
  const ContactListState({
    this.contacts,
    this.alreadySelectedContacts = const {},
    this.newlySelectedContacts = const {},
    this.permission = ContactListPermission.unknown,
    this.query = '',
  });

  final List<User>? contacts;
  final Set<User> alreadySelectedContacts;
  final Set<User> newlySelectedContacts;
  final ContactListPermission permission;
  final String query;

  List<User> get contactsToShow {
    var contactsToShow = this.contacts ?? [];

    if (query.isNotEmpty) {
      final lowerCaseQuery = query.toLowerCase();
      contactsToShow = contactsToShow
          .where((data) => data.name.toLowerCase().contains(lowerCaseQuery))
          .toList();
    }

    return contactsToShow;
  }

  bool isSelected(User contact) =>
      alreadySelectedContacts.contains(contact) ||
      newlySelectedContacts.contains(contact);

  ContactListState copyWith({
    List<User>? contacts,
    Set<User>? alreadySelectedContacts,
    Set<User>? newlySelectedContacts,
    ContactListPermission? permission,
    String? query,
  }) =>
      ContactListState(
        contacts: contacts ?? this.contacts,
        alreadySelectedContacts:
            alreadySelectedContacts ?? this.alreadySelectedContacts,
        newlySelectedContacts:
            newlySelectedContacts ?? this.newlySelectedContacts,
        permission: permission ?? this.permission,
        query: query ?? this.query,
      );
}
