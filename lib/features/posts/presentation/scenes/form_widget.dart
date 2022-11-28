import 'package:clean_arch/features/posts/presentation/bloc/post_operation/posts_operations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/snack_bar.dart';
import '../../domain/entity/post.dart';
import '../widgets/Widgets.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;

  const FormWidget({Key? key, required this.isUpdatePost, this.post})
      : super(key: key);

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController bodyTextController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      titleTextController.text = widget.post!.title;
      bodyTextController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          defaultTextField(
              verticalContentPadding: 12,
              horizontalContentPadding: 12,
              controller: titleTextController,
              keyboardType: TextInputType.name,
              labelName: 'Title',
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the Title';
                }
                return null;
              }),
          const SizedBox(
            height: 16,
          ),
          defaultTextField(
              labelName: 'Body',
              maxLine: 6,
              minLine: 6,
              verticalContentPadding: 12,
              horizontalContentPadding: 12,
              controller: bodyTextController,
              keyboardType: TextInputType.name,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter post body';
                }
                return null;
              }),
          const SizedBox(
            height: 16,
          ),
          buildElevatedButton()
        ],
      ),
    );
  }

  Widget buildElevatedButton() {
    if (widget.isUpdatePost) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildElevatorButton(
            icon: Icons.delete_forever,
            label: 'Delete',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return BlocConsumer<PostsOperationsBloc,
                      PostsOperationsState>(builder: (context, state) {
                    if (state is LoadingPostsOperations) {
                      return AlertDialog(
                        title: buildLoadingProgressWidget(),
                      );
                    }
                    return buildDeleteWidget(widget.post!.id.toString());
                  }, listener: (context, state) {
                    if (state is ErrorPostsOperations) {
                      Navigator.of(context).pop();
                      SnackBarMessage().showErrorSnackBar(
                          context: context, msg: state.message);
                    } else if (state is SuccessPostsOperations) {
                      SnackBarMessage().showSuccessSnackBar(
                          context: context, msg: state.message);
                      Navigator.of(context).pop();
                    }
                  });
                },
              );
            },
          ),
          const SizedBox(
            width: 16,
          ),
          buildElevatorButton(
            icon: Icons.edit,
            label: 'Update',
            onPressed: () {
              if (formKey.currentState!.validate()) {
                BlocProvider.of<PostsOperationsBloc>(context).add(
                    UpdatePostEvent(Post(
                        id: widget.post!.id,
                        title: titleTextController.text,
                        body: bodyTextController.text)));
              }
            },
          )
        ],
      );
    } else {
      return buildElevatorButton(
        icon: Icons.add,
        label: 'Add',
        onPressed: () {
          if (formKey.currentState!.validate()) {
            BlocProvider.of<PostsOperationsBloc>(context).add(
              AddPostEvent(Post(
                  id: null,
                  title: titleTextController.text,
                  body: bodyTextController.text)),
            );
          }
        },
      );
    }
  }

  Widget buildElevatorButton(
      {required IconData icon,
      required String label,
      required Function onPressed}) {
    return ElevatedButton.icon(
        onPressed: () {
          onPressed();
        },
        icon: Icon(icon),
        label: Text(label));
  }

  Widget buildDeleteWidget(id) {
    return AlertDialog(
      title: const Text(
        'Are you sure?',
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No')),
        const SizedBox(
          width: 16,
        ),
        TextButton(
            onPressed: () {
              BlocProvider.of<PostsOperationsBloc>(context)
                  .add(DeletePostEvent(id));
            },
            child: const Text('Yes')),
      ],
    );
  }
}
