import 'dart:io';
import 'package:crew_app/models/complete_job_model.dart';
import 'package:crew_app/modules/base_controller.dart';
import 'package:crew_app/providers/job_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class JobController extends BaseController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final provider = Get.find<JobProvider>();

  late String jobId;
  
  final List<String> signItems = [
    'Terms and Conditions',
    'Onsite Safety Risk Assessment',
    'Pre Move',
    'Post Move',
  ];

  @override
  void onInit() {
    tabController = TabController(length: 5,vsync: this);
    jobId = Get.arguments['jobId'] ?? '66e154f7f82f6da9d1fc0285';
    super.onInit();
    getJob();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void getJob() {
    provider.fetchJobSummary(jobId: jobId).then((jobNew) {
      job.value = jobNew;
    }).whenComplete(() {});
  }

  Rxn<CompleteJob> job = Rxn<CompleteJob>(null);

  final List<Inventory> inventoryItems = [
    // Example items, replace with actual data
    // InventoryItem(
    //   name: 'Bedroom',
    //   description: ['Single Mattress', 'ola', 'hlo', 'so', 'bruh'],
    //   length: [0.103, 0.3434, 0.3443, 0.43, 0.4544],
    // ),
    // InventoryItem(
    //   name: 'Kitchen',
    //   description: ['double Mattress', 'hum', 'huh'],
    //   length: [0.183, 0.70, 0.44],
    // ),
    // InventoryItem(
    //   name: 'Living',
    //   description: ['Uff Mattress', 'LaLaLalAlala', 'Lallla laaa la'],
    //   length: [0.183, 0.70, 0.44],
    // ),
    // InventoryItem(
    //   name: 'Outside',
    //   description: ['Dhool Mattress', 'Hehe', 'huh'],
    //   length: [0.183, 0.70, 0.44],
    // ),
  ];

  void toggleItemExpansion(Inventory item) {
    // item.isExpanded.value = !item.isExpanded.value;
  }

  // Observable list of ImageItem to store images and their respective picked time
  var images = <ImageItem>[].obs;

  // Function to pick an image from the gallery or camera
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      // Get the app's documents directory
      final appDir = await getApplicationDocumentsDirectory();
      // Create a path for storing the image
      final fileName = path.basename(pickedFile.path);
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName');

      // Create an ImageItem with the saved image and the current time
      final imageItem = ImageItem(
        imageFile: savedImage,
        pickedTime: DateTime.now(),
      );

      // Add the ImageItem to the observable list
      images.add(imageItem);
    } else {
      Get.snackbar('Discard', 'No image was selected');
    }
  }

  // Function to remove an image from the list and delete the file
  void removeImage(ImageItem imageItem) {
    images.remove(imageItem);
    // imageItem.imageFile.delete();
  }

  void call() {
    // Logic for call
  }

  void message() {
    // Logic fro message
  }

  var jobStarted = false.obs; // Tracks if the job has started
  var jobPaused = false.obs; // Tracks if the job is paused

  void startJob() {
    jobStarted.value = true; // Update the state when the job starts
    jobPaused.value = false; // Ensure job is not paused when it starts
    // Logic for starting the job
  }

  void pauseJob() {
    jobPaused.value = true; // Update the state to paused
    // Logic for pausing the job
  }

  void resumeJob() {
    jobPaused.value = false; // Update the state to resumed
    // Logic for resuming the job
  }

  void onTheWay() {
    // Logic for setting the job on the way
  }
}

class ImageItem {
  File? imageFile;
  DateTime? pickedTime;

  ImageItem({this.imageFile, this.pickedTime});
}
