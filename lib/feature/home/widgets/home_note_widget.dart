import 'package:flutter/material.dart';
import 'package:todo_app/core/cubit/app_cubit/app_cubit.dart';
import 'package:todo_app/core/cubit/app_states/app_state.dart';
import 'package:todo_app/core/models/note_model.dart';
import 'package:todo_app/core/shared/colors/colors_manager.dart';
import 'package:todo_app/core/shared/fonts/font_manager.dart';
import 'package:todo_app/core/shared/widgets/asset_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeNoteItem extends StatelessWidget {
  const HomeNoteItem({
    super.key,
    required this.item,
  });

  final NoteModel item;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppStates>(
      builder: (context,state) {
        var cubit = AppCubit.get(context);
        return SizedBox(
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorsManager.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: const AssetSvg(
                  imagePath: 'todo',
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title ?? '',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeightManager.bold,
                          ),
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          item.time ?? '',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: ColorsManager.darkGray,
                              ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          'on',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorsManager.darkGray,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          item.date ?? '',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorsManager.darkGray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: item.done ?? false,
                splashRadius: 26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                activeColor: ColorsManager.green,
                onChanged: (value) {
                  cubit.noteModel = item;
                  cubit.validateState = value!;
                  cubit.updateNote(id: item.id ?? '');
                },
              ),
            ],
          ),
        );
      }
    );
  }
}
