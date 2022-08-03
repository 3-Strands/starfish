import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/modules/groups_view/cubit/contacts_cubit.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:starfish/widgets/contact_list_item.dart';
import 'package:starfish/widgets/searchbar_widget.dart';

class ContactList extends StatelessWidget {
  const ContactList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final contactCubit = context.read<ContactsCubit>();

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
          onValueChanged: contactCubit.queryChanged,
          onDone: (_) {},
        ),
        SizedBox(height: 11.h),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
            child: BlocBuilder<ContactsCubit, ContactsState>(
              builder: (context, state) {
                if (state.permission == ContactPermission.unknown) {
                  return Center(
                    child: Text(appLocalizations.loading),
                  );
                } else if (state.permission == ContactPermission.denied) {
                  return Center(
                    child: Text(appLocalizations.contactAccessDenied),
                  );
                }

                final contacts = state.contactsToShow;

                return Scrollbar(
                  thickness: 5.w,
                  isAlwaysShown: false,
                  child: ListView.builder(
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

                          contactCubit.contactToggled(contact);
                        },
                      );
                    },
                  ),
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
                    contactCubit.inviteRequested();
                    Navigator.of(context).pop();
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
