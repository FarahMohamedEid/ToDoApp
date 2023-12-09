import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todo_app/core/cubit/app_cubit/app_cubit.dart';
import 'package:todo_app/core/cubit/app_states/app_state.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';
import 'package:todo_app/core/shared/constants/constants.dart';
import 'package:todo_app/core/shared/fonts/font_manager.dart';
import '../../../core/shared/widgets/app_button.dart';
import '../../../core/shared/widgets/app_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/shared/extension/extension_manager.dart';

class ContentBottomSheet extends StatelessWidget {
  const ContentBottomSheet({
    super.key,
    this.indicatorTrigger = IndicatorTrigger.create,
    this.noteID,
  });

  const ContentBottomSheet.editing({
    super.key,
    this.indicatorTrigger = IndicatorTrigger.editing,
    this.noteID,
  });

  final IndicatorTrigger indicatorTrigger;
  final String? noteID;

  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    switch (indicatorTrigger) {
      case IndicatorTrigger.create:
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: EdgeInsets.only(
                top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create Note !!',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: ColorsManager.primary,
                                fontWeight: FontWeightManager.bold,
                              ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// title
                    AppFormField(
                      label: 'Title',
                      hint: 'enter your note title',
                      controller: cubit.titleController,
                      type: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      error: 'title is required',
                      onChange: (value) {
                        cubit.validateTitle = value;
                      },
                      prefixIcon: const Icon(Icons.title),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// date
                    AppFormField(
                      label: 'Date',
                      hint: 'Enter date',
                      controller: cubit.dateController,
                      textInputAction: TextInputAction.next,
                      error: 'Date is required',
                      type: TextInputType.datetime,
                      onTab: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: ColorsManager.secondary,
                                  onPrimary: ColorsManager.white,
                                  surface: ColorsManager.secondary,
                                  onSurface: ColorsManager.darkGray,
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child ?? const SizedBox(),
                            );
                          },
                        ).then((value) {
                          cubit.dateController.text = value?.formatDate ?? '';
                          return cubit.validateDate = value?.formatDate ?? '';
                        });
                      },
                      readOnly: true,
                      prefixIcon: const Icon(Icons.date_range),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// time
                    AppFormField(
                      label: 'Time',
                      hint: 'Enter time',
                      controller: cubit.timeController,
                      textInputAction: TextInputAction.next,
                      error: 'Time is required',
                      readOnly: true,
                      onTab: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          orientation: MediaQuery.of(context).orientation,
                        ).then((value) {
                          cubit.timeController.text =
                              DateTimeParsing.tryParseTimeHM(
                                  value ?? TimeOfDay.now());
                          return cubit.validateTime =
                              DateTimeParsing.tryParseTimeHM(
                                  value ?? TimeOfDay.now());
                        });
                      },
                      prefixIcon: const Icon(Icons.access_time),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// content
                    AppFormField(
                      label: 'What do you want to do?',
                      hint: 'Enter your note content',
                      controller: cubit.contentController,
                      textInputAction: TextInputAction.done,
                      error: 'Content is required',
                      onChange: (value) {
                        cubit.validateContent = value;
                      },
                      maxLines: 6,
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// buttons
                    Row(
                      children: [
                        /// cancel button
                        AppButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          title: 'Cancel',
                          buttonColor: ColorsManager.lightGray,
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                        /// create button
                        AppButton(
                          onPressed: () {
                            cubit.validateState = false;
                            cubit.validateId = cubit.idGenerator();
                            if (cubit.isButtonEnable) {
                              cubit.createNote();
                              Navigator.pop(context);
                            } else {
                              showToast(
                                  message: 'Please fill all fields',
                                  state: ToastStates.ERROR);
                            }
                          },
                          title: 'Create',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      case IndicatorTrigger.editing:
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            padding: EdgeInsets.only(
                top: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
                  BlocBuilder<AppCubit, AppStates>(builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Update Note !!',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: ColorsManager.primary,
                                fontWeight: FontWeightManager.bold,
                              ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    /// title
                    AppFormField(
                      label: 'Title',
                      hint: 'enter your note title',
                      controller: cubit.titleController,
                      textInputAction: TextInputAction.next,
                      error: 'title is required',
                      onChange: (value) {
                        cubit.validateTitle = value;
                      },
                      prefixIcon: const Icon(Icons.title),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// date
                    AppFormField(
                      label: 'Date',
                      hint: 'Enter date',
                      controller: cubit.dateController,
                      textInputAction: TextInputAction.next,
                      error: 'Date is required',
                      type: TextInputType.datetime,
                      onTab: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: ColorsManager.secondary,
                                  onPrimary: ColorsManager.white,
                                  surface: ColorsManager.secondary,
                                  onSurface: ColorsManager.darkGray,
                                ),
                                dialogBackgroundColor: Colors.white,
                              ),
                              child: child ?? const SizedBox(),
                            );
                          },
                        ).then((value) {
                          cubit.dateController.text = value?.formatDate ?? '';
                          return cubit.validateDate = value?.formatDate ?? '';
                        });
                      },
                      readOnly: true,
                      prefixIcon: const Icon(Icons.date_range),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// time
                    AppFormField(
                      label: 'Time',
                      hint: 'Enter time',
                      controller: cubit.timeController,
                      textInputAction: TextInputAction.next,
                      error: 'Time is required',
                      readOnly: true,
                      onTab: () {
                        showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          orientation: MediaQuery.of(context).orientation,
                        ).then((value) {
                          cubit.timeController.text =
                              DateTimeParsing.tryParseTimeHM(
                                  value ?? TimeOfDay.now());
                          return cubit.validateTime =
                              DateTimeParsing.tryParseTimeHM(
                                  value ?? TimeOfDay.now());
                        });
                      },
                      prefixIcon: const Icon(Icons.access_time),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    /// content
                    AppFormField(
                      label: 'What do you want to do?',
                      hint: 'Enter your note content',
                      controller: cubit.contentController,
                      textInputAction: TextInputAction.done,
                      error: 'Content is required',
                      onChange: (value) {
                        cubit.validateContent = value;
                      },
                      maxLines: 6,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    /// delete button
                    InkWell(
                      onTap: () {
                        cubit.deleteNote(id: noteID ?? '');
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete_outline_outlined,
                            color: ColorsManager.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Delete Note',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: ColorsManager.red,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    /// buttons
                    Row(
                      children: [
                        /// cancel button
                        AppButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          title: 'Cancel',
                          buttonColor: ColorsManager.lightGray,
                        ),
                        const SizedBox(
                          width: 10,
                        ),

                        /// update button
                        AppButton(
                          onPressed: () {
                            if (cubit.isButtonEnable) {
                              cubit.updateNote(id: noteID ?? '');
                              Navigator.pop(context);
                            } else {
                              showToast(
                                  message: 'Please fill all fields',
                                  state: ToastStates.ERROR);
                            }
                          },
                          title: 'Update',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              }),
            ),
          ),
        );
    }
  }
}

enum IndicatorTrigger {
  create,
  editing,
}
