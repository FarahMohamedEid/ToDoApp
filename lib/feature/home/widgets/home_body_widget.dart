import 'package:flutter/material.dart';
import 'package:todo_app/core/cubit/app_cubit/app_cubit.dart';
import 'package:todo_app/core/cubit/app_states/app_state.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';
import 'package:todo_app/core/shared/fonts/font_manager.dart';
import 'package:todo_app/core/shared/widgets/asset_png.dart';
import 'package:todo_app/feature/home/widgets/home_content_bottom_sheet.dart';
import 'package:todo_app/feature/home/widgets/home_note_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
      var cubit = AppCubit.get(context);
      return Container(
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.7,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Expanded(
                child: cubit.notesList.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const AssetPng(
                            imagePath: 'no_data',
                            size: 150,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            'No Tasks Yet, Please Add Some Tasks',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: ColorsManager.darkGray,
                                  fontWeight: FontWeightManager.bold,
                                ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            cubit.noteModel = cubit.notesList[index];
                            cubit.setFormFieldsValues();
                            showModalBottomSheet(
                              context: context,
                              isDismissible: true,
                              enableDrag: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (BuildContext context) =>
                                  ContentBottomSheet.editing(
                                      noteID: cubit.notesList[index].id!),
                            );
                          },
                          child: HomeNoteItem(item: cubit.notesList[index]),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemCount: cubit.notesList.length,
                      ),
              ),
            ],
          ));
    });
  }
}
