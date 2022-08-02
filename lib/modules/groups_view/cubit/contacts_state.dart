part of 'contacts_cubit.dart';

enum ContactPermission {
  unknown,
  granted,
  denied,
  unavailable,
}

@immutable
class ContactsState {
  const ContactsState({
    this.contacts,
    this.alreadySelectedContacts = const {},
    this.newlySelectedContacts = const {},
    this.permission = ContactPermission.unknown,
    this.query = '',
  });

  final List<User>? contacts;
  final Set<String> alreadySelectedContacts;
  final Set<String> newlySelectedContacts;
  final ContactPermission permission;
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
      alreadySelectedContacts.contains(contact.id) ||
      newlySelectedContacts.contains(contact.id);

  ContactsState copyWith({
    List<User>? contacts,
    Set<String>? alreadySelectedContacts,
    Set<String>? newlySelectedContacts,
    ContactPermission? permission,
    String? query,
  }) =>
      ContactsState(
        contacts: contacts ?? this.contacts,
        alreadySelectedContacts:
            alreadySelectedContacts ?? this.alreadySelectedContacts,
        newlySelectedContacts:
            newlySelectedContacts ?? this.newlySelectedContacts,
        permission: permission ?? this.permission,
        query: query ?? this.query,
      );
}
