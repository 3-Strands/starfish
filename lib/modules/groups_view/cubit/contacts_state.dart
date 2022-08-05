part of 'contacts_cubit.dart';

enum ContactPermission {
  unknown,
  granted,
  denied,
  unavailable,
}

enum ContactError {
  nameAlreadyExists,
}

@immutable
class ContactsState {
  const ContactsState({
    this.contacts,
    this.alreadySelectedContacts = const {},
    this.newlySelectedContacts = const {},
    this.permission = ContactPermission.unknown,
    this.query = '',
    this.error,
  });

  final List<User>? contacts;
  final Set<User> alreadySelectedContacts;
  final Set<User> newlySelectedContacts;
  final ContactPermission permission;
  final String query;
  final ContactError? error;

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
      alreadySelectedContacts.contains(contact.id) ||
      newlySelectedContacts.contains(contact.id);

  ContactsState copyWith({
    List<User>? contacts,
    Set<User>? alreadySelectedContacts,
    Set<User>? newlySelectedContacts,
    ContactPermission? permission,
    String? query,
    ContactError? error,
  }) =>
      ContactsState(
        contacts: contacts ?? this.contacts,
        alreadySelectedContacts:
            alreadySelectedContacts ?? this.alreadySelectedContacts,
        newlySelectedContacts:
            newlySelectedContacts ?? this.newlySelectedContacts,
        permission: permission ?? this.permission,
        query: query ?? this.query,
        error: error, // NOT default to this.error
      );
}
