import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/ui/controllers/add_new_task_controller.dart';
import 'package:taskmanager/ui/widgets/background_widget.dart';
import 'package:taskmanager/ui/widgets/circuler_process_indicator.dart';
import 'package:taskmanager/ui/widgets/profile_appbar.dart';
import 'package:taskmanager/ui/widgets/snack_bar_message.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _titleTEController.dispose();
    _descriptionTEController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileAppbar(context),
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _titleTEController,
                    decoration: const InputDecoration(hintText: 'Title'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter title';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionTEController,
                    maxLines: 4,
                    decoration: const InputDecoration(hintText: 'Description'),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<AddNewTaskController>(
                      builder: (addNewTaskController) {
                    return Visibility(
                      visible:
                          addNewTaskController.addNewTaskInProgess == false,
                      replacement: const CircleLoader(),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _addNewTask();
                            }
                          },
                          child: const Text('Add')),
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    bool result = await Get.find<AddNewTaskController>()
        .addNewTask(_titleTEController.text.trim(), _titleTEController.text);
    result
        ? showSnackBarMessage(context, 'New Task Added Successfully')
        : showSnackBarMessage(context, 'Failed to add New Task. Try again');
  }

  // Future<void> _addNewTask() async{
  //   _addNewTaskInProgress = true;
  //   if(mounted) setState(() {});
  //   Map<String, dynamic> requestData = {
  //     "title": _titleTEController.text.trim(),
  //     "description": _descriptionTEController.text.trim(),
  //     "status": "New",
  //   };
  //   NetworkResponse response = await NetworkCaller.postRequest(Urls.createTask, requestData);
  //   _addNewTaskInProgress = false;
  //   if(mounted) setState(() {});
  //
  //   if(response.isSuccess){
  //     _titleTEController.clear();
  //     _descriptionTEController.clear();
  //     if(mounted) showSnackBarMessage(context, 'New task created!');
  //   }else{
  //     if(mounted) showSnackBarMessage(context, 'Failed to create new task. Try again.');
  //   }
  // }
}
