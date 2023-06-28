// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconly/iconly.dart';
import 'package:jobbhai/common/custom_forms_kit.dart';
import 'package:jobbhai/common/info_chip.dart';
import 'package:jobbhai/core/enums/work_type.dart';
import 'package:jobbhai/core/enums/working_mode.dart';

import 'package:jobbhai/core/extensions/datetime_formatter.dart';
import 'package:jobbhai/core/extensions/sentence_splitter.dart';
import 'package:jobbhai/features/recruiter/post_job/controller/post_job_controller.dart';
import 'package:jobbhai/theme/colors.dart';

class PostAJobView extends ConsumerStatefulWidget {
  const PostAJobView({super.key});

  @override
  ConsumerState<PostAJobView> createState() => _PostAJobViewState();
}

class _PostAJobViewState extends ConsumerState<PostAJobView> {
  @override
  void initState() {
    super.initState();
    deadlineController.text = deadline.toOrdinalDate();
  }

  @override
  void dispose() {
    deadlineController.dispose();
    jobTitleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    benefitsController.dispose();
    requirementController.dispose();
    salaryController.dispose();
    deadlineController.dispose();
    responsibilitiesController.dispose();
    super.dispose();
  }

  final jobTitleController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final benefitsController = TextEditingController();
  final requirementController = TextEditingController();
  final salaryController = TextEditingController();
  final deadlineController = TextEditingController();

  final responsibilitiesController = TextEditingController();
  WorkType _seletectedWorkType = WorkType.fullTime;
  WorkingMode _seletectedWorkMode = WorkingMode.onSite;
  List<String> perksAndBenefits = [];

  DateTime deadline = DateTime.now().add(const Duration(days: 1));

  void _postJob() {
    ref.watch(postJobControllerProvider.notifier).postJob(
        jobTitle: jobTitleController.text,
        workingMode: _seletectedWorkMode.text,
        description: descriptionController.text,
        location: locationController.text,
        jobType: _seletectedWorkType.text,
        salary: salaryController.text,
        responsibilities: responsibilitiesController.text.sentenceToList(),
        requirement: requirementController.text.sentenceToList(),
        benefits: perksAndBenefits,
        ref: ref,
        context: context,
        deadline: deadline);
  }

  Widget _perksChips(String chipName) {
    final isSelected = perksAndBenefits.contains(chipName);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            perksAndBenefits.remove(chipName);
          } else {
            perksAndBenefits.add(chipName);
          }
        });
      },
      child: InfoChip(
          title: chipName,
          titleColor:
              isSelected ? AppColors.primaryColor : AppColors.secondaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final txtStyle = Theme.of(context).textTheme.displayMedium;
    final jobState = ref.watch(postJobControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post A Job'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(text: 'Title', bold: true, formSpacing: true),
              CustomTextField(controller: jobTitleController),
              const CustomText(
                  text: 'Description', bold: true, formSpacing: true),
              CustomTextField(
                  controller: descriptionController, enableMaxlines: true),
              const CustomText(
                  text: 'Work Mode', bold: true, formSpacing: true),
              for (var mode in WorkingMode.values)
                RadioTile<WorkingMode>(
                  title: mode.text,
                  value: mode,
                  groupValue: _seletectedWorkMode,
                  onChanged: (value) =>
                      setState(() => _seletectedWorkMode = value!),
                ),
              const CustomText(
                  text: 'Work Type', bold: true, formSpacing: true),
              for (var type in WorkType.values)
                RadioTile<WorkType>(
                  title: type.text,
                  value: type,
                  groupValue: _seletectedWorkType,
                  onChanged: (value) =>
                      setState(() => _seletectedWorkType = value!),
                ),
              // TextButton(
              //     onPressed: () => showCountryPicker(
              //           showSearch: false,
              //           context: context,
              //           onSelect: (Country country) {
              //             print('Select country: ${country.name}');
              //           },
              //         ),
              //     child: const Text('cout')),
              const CustomText(text: 'Location', bold: true, formSpacing: true),
              CustomTextField(controller: locationController),
              const CustomText(text: 'Salary', bold: true, formSpacing: true),
              CustomTextField(
                controller: salaryController,
                inputType: TextInputType.number,
                // prefixIcon: Icons.attach_money_sharp,
              ),
              const CustomText(
                  text: 'Requirements', bold: true, formSpacing: true),
              CustomTextField(
                  controller: requirementController, enableMaxlines: true),
              const CustomText(
                  text: 'Responsibilities', bold: true, formSpacing: true),
              CustomTextField(
                  controller: responsibilitiesController, enableMaxlines: true),
              const CustomText(
                  text: 'Perks & Benefits', bold: true, formSpacing: true),
              Wrap(
                spacing: 8.0,
                runSpacing: 10,
                children: [
                  _perksChips('Medical/Health Insurance'),
                  _perksChips('Paid Sick Leave'),
                  _perksChips('Performance Bonus'),
                  _perksChips('Transportation Allowance'),
                  _perksChips('Skill development'),
                  _perksChips('Equity package'),
                  _perksChips('Maternity / paternity leave'),
                  _perksChips('Paid holiday,'),
                ],
              ),
              const CustomText(text: 'Deadline', bold: true, formSpacing: true),
              GestureDetector(
                onTap: () async {
                  final DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: deadline,
                      firstDate: DateTime.now().add(const Duration(days: 1)),
                      lastDate: DateTime(2050));
                  if (date != null) {
                    setState(() {
                      deadline = date;
                      deadlineController.text = deadline.toOrdinalDate();
                    });
                  }
                },
                child: CustomTextField(
                    controller: deadlineController,
                    editable: false,
                    suffixIcon: IconlyLight.calendar),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25),
        child: ElevatedButton(
            onPressed: _postJob,
            child: jobState == JobState.loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Submit',
                    style: txtStyle!.copyWith(color: AppColors.greyColor),
                  )),
      ),
    );
  }
}

class RadioTile<T> extends StatelessWidget {
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const RadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile<T>(
      dense: true,
      contentPadding: const EdgeInsets.all(5),
      title: CustomText(text: title),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
