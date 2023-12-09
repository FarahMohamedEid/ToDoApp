import 'package:flutter/material.dart';
import 'package:todo_app/core/cubit/app_cubit/app_cubit.dart';
import 'package:todo_app/core/models/note_model.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';
import 'package:todo_app/core/shared/constants/constants.dart';
import 'package:todo_app/core/shared/widgets/app_icon_button.dart';
import 'package:todo_app/feature/home/widgets/home_body_widget.dart';
import 'package:todo_app/feature/home/widgets/home_content_bottom_sheet.dart';
import 'package:todo_app/feature/home/widgets/home_header_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: ColorsManager.primary,
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          cubit.noteModel = NoteModel();
          cubit.setFormFieldsValues();
          showModalBottomSheet(
              context: context,
              isDismissible: true,
              enableDrag: true,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) => const ContentBottomSheet(),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: ColorsManager.secondary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsManager.primary,
        actions: [
          AppIconButton(
            onPressed: (){
              showToast(
                  message: 'this is feature is not available yet',
                  state: ToastStates.WARNING,
              );
            },
            iconPath: Icons.notifications,
          ),
          AppIconButton(
            onPressed: (){
              showToast(
                message: 'this is feature is not available yet',
                state: ToastStates.WARNING,
              );
            },
            iconPath: Icons.person,
          ),
        ],
        leading: AppIconButton(
          onPressed: (){
            showToast(
              message: 'this is feature is not available yet',
              state: ToastStates.WARNING,
            );
          },
          iconPath: Icons.menu,
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HomeHeaderWidget(),
          Spacer(),
          HomeBodyWidget(),
        ],
      ),
    );
  }
}
