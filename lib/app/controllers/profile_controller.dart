import 'package:get/get.dart';

class ProfileController extends GetxController {
  final isEditing = false.obs;
  final isProfileComplete = true.obs; // Set to true untuk demo profile lengkap

  // Form controllers
  final nameController = ''.obs;
  final emailController = ''.obs;
  final phoneController = ''.obs;
  final fullAddressController = ''.obs;
  final postalCodeController = ''.obs;

  // Dropdown selections
  final selectedCountry = Rxn<String>();
  final selectedProvince = Rxn<String>();
  final selectedDistrict = Rxn<String>();
  final selectedSubDistrict = Rxn<String>();

  // Dropdown data
  final countries = <String>[
    'Indonesia',
    'Malaysia',
    'Singapore',
    'Thailand',
    'Vietnam',
  ].obs;

  final provinces = <String>[
    'DKI Jakarta',
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    'Sumatera Utara',
    'Sumatera Barat',
    'Bali',
    'Kalimantan Selatan',
  ].obs;

  final districts = <String>[
    'Jakarta Selatan',
    'Jakarta Pusat',
    'Jakarta Utara',
    'Jakarta Barat',
    'Jakarta Timur',
  ].obs;

  final subDistricts = <String>[
    'Senayan',
    'Menteng',
    'Setiabudi',
    'Pancoran',
    'Kemayoran',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize dengan data dummy
    nameController.value = 'John Doe';
    emailController.value = 'john.doe@example.com';
    phoneController.value = '+62 812-3456-7890';
    fullAddressController.value = 'Jl. Sudirman No. 123, Blok A';
    selectedCountry.value = 'Indonesia';
    selectedProvince.value = 'DKI Jakarta';
    selectedDistrict.value = 'Jakarta Selatan';
    selectedSubDistrict.value = 'Senayan';
    postalCodeController.value = '12190';
  }

  void toggleEdit() {
    if (!isProfileComplete.value) {
      isEditing.toggle();
    }
  }

  void saveProfile() {
    // Validasi form
    if (nameController.value.isEmpty ||
        emailController.value.isEmpty ||
        phoneController.value.isEmpty ||
        fullAddressController.value.isEmpty ||
        selectedCountry.value == null ||
        selectedProvince.value == null ||
        selectedDistrict.value == null ||
        selectedSubDistrict.value == null ||
        postalCodeController.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field harus diisi',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Simulasi save
    isEditing.value = false;
    isProfileComplete.value = true;
    Get.snackbar(
      'Success',
      'Profile berhasil disimpan',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void cancelEdit() {
    isEditing.value = false;
  }
}
