import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jobbhai/common/custom_forms_kit.dart';
import 'package:jobbhai/core/extensions/sentence_splitter.dart';
import 'package:jobbhai/core/resuables/pick_file.dart';
import 'package:jobbhai/features/authentication/controller/auth_controller.dart';
import 'package:jobbhai/model/applicant.dart';

class EditApplicantProfile extends ConsumerStatefulWidget {
  final Applicant applicant;
  const EditApplicantProfile({super.key, required this.applicant});

  @override
  ConsumerState<EditApplicantProfile> createState() =>
      _EditApplicantProfileState();
}

class _EditApplicantProfileState extends ConsumerState<EditApplicantProfile> {
  File? imageFile;
  bool imagePicked = false;
  void pickImage() async {
    imageFile = await PickFile.pickImage();
    setState(() {
      imagePicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final nameController = TextEditingController(text: widget.applicant.name);
    final aboutController = TextEditingController(text: widget.applicant.about);
    final experienceController = TextEditingController(
        text: widget.applicant.experience
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', ''));
    final locationController =
        TextEditingController(text: widget.applicant.location);
    final titleController = TextEditingController(text: widget.applicant.title);
    final skillsController = TextEditingController(
        text: widget.applicant.skills
            .toString()
            .replaceAll('[', '')
            .replaceAll(']', ''));
    void updateProfile() {
      ref.watch(authControllerProvider.notifier).updateApplicantProfile(
            image: imageFile,
            context: context,
            applicant: widget.applicant.copyWith(
              name: nameController.text,
              about: aboutController.text,
              experience: experienceController.text.sentenceToList(),
              location: locationController.text,
              profilePicture: '',
              skills: skillsController.text.sentenceToList(),
              title: titleController.text,
            ),
            ref: ref,
          );
    }

    final textStyle = Theme.of(context).textTheme.displayLarge!;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ElevatedButton(
            onPressed: updateProfile,
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Update Profile',
                    style:
                        textStyle.copyWith(color: Colors.white, fontSize: 17),
                  )),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            //scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: InkWell(
                  onTap: pickImage,
                  child: CircleAvatar(
                      radius: 35,
                      child: imagePicked
                          ? ClipOval(child: Image.file(imageFile!))
                          : widget.applicant.profilePicture.isEmpty
                              ? const SizedBox.shrink()
                              : Image.network(widget.applicant.profilePicture)),
                ),
              ),
              const CustomText(text: 'Name', bold: true, formSpacing: true),
              CustomTextField(controller: nameController),
              const CustomText(text: 'Title', bold: true, formSpacing: true),
              CustomTextField(
                controller: titleController,
                hintText: 'Eg. Mobile App Developer',
                showHintText: true,
              ),
              const CustomText(text: 'Skills', bold: true, formSpacing: true),
              CustomTextField(
                controller: skillsController,
                enableMaxlines: true,
                hintText: 'Eg. Flutter, AppWrite, Python',
                showHintText: true,
              ),
              const CustomText(
                  text: 'Experience', bold: true, formSpacing: true),
              CustomTextField(
                controller: experienceController,
                enableMaxlines: true,
                hintText: 'Eg. Mobile dev at Inteli Kode',
                showHintText: true,
              ),
              const CustomText(text: 'Location', bold: true, formSpacing: true),
              CustomTextField(
                controller: locationController,
                hintText: 'Eg. Ghana, Accra',
                showHintText: true,
              ),
              const CustomText(text: 'About', bold: true, formSpacing: true),
              CustomTextField(
                controller: aboutController,
                enableMaxlines: true,
                hintText: 'Eg. Mobile dev at Inteli Kode',
                showHintText: true,
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
