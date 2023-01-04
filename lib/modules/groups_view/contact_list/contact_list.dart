import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/groups_view/contact_list/cubit/contact_list_cubit.dart';
import 'package:starfish/src/grpc_extensions.dart';
import 'package:starfish/utils/currentUser.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/contact_list_item.dart';
import 'package:starfish/widgets/searchbar_widget.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key, this.selectedUsers}) : super(key: key);

  final List<User>? selectedUsers;

  static Future<Set<User>?> showAsBottomSheet(BuildContext context,
      {List<User>? selectedUsers}) {
    final widget = SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      child: ContactList(selectedUsers: selectedUsers),
    );
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34.r), topRight: Radius.circular(34.r)),
      ),
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      builder: (BuildContext context) => widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactListCubit(
        currentUser: context.currentUser,
        selectedUsers: selectedUsers,
      ),
      child: const ContactListView(),
    );
  }
}

class ContactListView extends StatelessWidget {
  const ContactListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final contactListCubit = context.read<ContactListCubit>();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
          child: Text(
            appLocalizations.selectPropleToInvite,
            textAlign: TextAlign.left,
            style: titleTextStyle,
          ),
        ),
        SizedBox(height: 11.h),
        SearchBar(
          initialValue: '',
          onValueChanged: contactListCubit.queryChanged,
          onDone: (_) {},
        ),
        SizedBox(height: 11.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
            child: BlocBuilder<ContactListCubit, ContactListState>(
              builder: (context, state) {
                if (state.permission == ContactListPermission.unknown) {
                  return Center(
                    child: Text(appLocalizations.loading),
                  );
                } else if (state.permission == ContactListPermission.denied) {
                  return Center(
                    child: Text(appLocalizations.contactAccessDenied),
                  );
                }

                final contacts = state.contactsToShow;

                return ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final contact = contacts[index];
                    return ContactListItem(
                      contact: contact,
                      isSelected: state.isSelected(contact),
                      onTap: () {
                        //TODO: check if contact number already registered/selected for any other group member

                        if (state.alreadySelectedContacts
                            .contains(contact.id)) {
                          StarfishSnackbar.showErrorMessage(context,
                              appLocalizations.phonenumberAlreadyAdded);
                          return;
                        }

                        contactListCubit.contactToggled(contact);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
        Container(
          height: 75.h,
          padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
          color: AppColors.txtFieldBackground,
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(appLocalizations.cancel),
                ),
              ),
              SizedBox(width: 25.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      contactListCubit.state.newlySelectedContacts,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.selectedButtonBG,
                  ),
                  child: Text(appLocalizations.invite),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
