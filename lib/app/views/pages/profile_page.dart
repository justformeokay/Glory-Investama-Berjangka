import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../../../constants/colors.dart';
import '../../controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.bgLight,
        appBar: AppBar(
          backgroundColor: AppColors.secondaryWhite,
          elevation: 0,
          title: const Text('Profile'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Iconsax.arrow_left_outline),
          ),
          actions: [
            Obx(
              () => controller.isEditing.value
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Center(
                        child: GestureDetector(
                          onTap: () => controller.toggleEdit(),
                          child: Text(
                            controller.isProfileComplete.value
                                ? 'Locked'
                                : 'Edit',
                            style:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: controller.isProfileComplete.value
                                          ? AppColors.errorRed
                                          : AppColors.primaryGold,
                                    ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                _buildProfileHeader(context, controller),
                const SizedBox(height: 24),

                // Status Badge
                _buildStatusBadge(context, controller),
                const SizedBox(height: 24),

                // Form Fields
                _buildFormFields(context, controller),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => controller.isEditing.value
              ? Container(
                  padding:
                      const EdgeInsets.all(16) +
                      EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryWhite,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondaryBlack.withOpacity(0.1),
                        blurRadius: 12,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.cancelEdit(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: AppColors.secondaryWhite,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.secondaryGrey.withOpacity(0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Cancel',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.textPrimary,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.saveProfile(),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGold,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryGold.withOpacity(0.3),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Save Changes',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondaryWhite,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileController controller) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryGold,
                  AppColors.primaryGold.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryGold.withOpacity(0.2),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  controller.nameController.value.isNotEmpty
                      ? controller.nameController.value.substring(0, 1).toUpperCase()
                      : 'U',
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryGold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Obx(
            () => Text(
              controller.nameController.value,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
            ),
          ),
          const SizedBox(height: 4),
          Obx(
            () => Text(
              controller.emailController.value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, ProfileController controller) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: controller.isProfileComplete.value
              ? AppColors.successGreen.withOpacity(0.15)
              : AppColors.errorRed.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: controller.isProfileComplete.value
                ? AppColors.successGreen.withOpacity(0.3)
                : AppColors.errorRed.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              controller.isProfileComplete.value
                  ? Iconsax.verify_outline
                  : Iconsax.close_circle_outline,
              color: controller.isProfileComplete.value
                  ? AppColors.successGreen
                  : AppColors.errorRed,
              size: 18,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.isProfileComplete.value
                        ? 'Profile Verified'
                        : 'Profile Incomplete',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: controller.isProfileComplete.value
                              ? AppColors.successGreen
                              : AppColors.errorRed,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    controller.isProfileComplete.value
                        ? 'Your profile is complete and verified'
                        : 'Complete your profile information',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: controller.isProfileComplete.value
                              ? AppColors.successGreen
                              : AppColors.errorRed,
                        ),
                  ),
                ],
              ),
            ),
            if (controller.isProfileComplete.value)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.successGreen,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Locked',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormFields(BuildContext context, ProfileController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Personal Information Section
        _buildSectionTitle(context, 'Personal Information'),
        const SizedBox(height: 16),

        // Name
        _buildTextField(
          context,
          label: 'Full Name',
          controller: controller.nameController,
          icon: Iconsax.user_outline,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 16),

        // Email
        _buildTextField(
          context,
          label: 'Email Address',
          controller: controller.emailController,
          icon: Iconsax.sms_outline,
          keyboardType: TextInputType.emailAddress,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 16),

        // Phone
        _buildTextField(
          context,
          label: 'Phone Number',
          controller: controller.phoneController,
          icon: Iconsax.call_outline,
          keyboardType: TextInputType.phone,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 24),

        // Address Information Section
        _buildSectionTitle(context, 'Address Information'),
        const SizedBox(height: 16),

        // Full Address
        _buildTextField(
          context,
          label: 'Full Address',
          controller: controller.fullAddressController,
          icon: Iconsax.location_outline,
          maxLines: 3,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 16),

        // Country Dropdown
        _buildDropdownField(
          context,
          label: 'Country',
          items: controller.countries,
          selectedValue: controller.selectedCountry,
          icon: Iconsax.flag_outline,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 16),

        // Province Dropdown
        _buildDropdownField(
          context,
          label: 'Province',
          items: controller.provinces,
          selectedValue: controller.selectedProvince,
          icon: Iconsax.map_outline,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 16),

        // District Dropdown
        _buildDropdownField(
          context,
          label: 'District',
          items: controller.districts,
          selectedValue: controller.selectedDistrict,
          icon: Iconsax.location_outline,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 16),

        // Sub-District Dropdown
        _buildDropdownField(
          context,
          label: 'Sub-District',
          items: controller.subDistricts,
          selectedValue: controller.selectedSubDistrict,
          icon: Iconsax.location_add_outline,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 16),

        // Postal Code
        _buildTextField(
          context,
          label: 'Postal Code',
          controller: controller.postalCodeController,
          icon: Iconsax.code_outline,
          keyboardType: TextInputType.number,
          isReadOnly: controller.isProfileComplete.value,
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required Rx<String> controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool isReadOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isReadOnly ? AppColors.bgLight : AppColors.secondaryWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.secondaryGrey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextFormField(
        initialValue: controller.value,
        onChanged: (value) => controller.value = value,
        readOnly: isReadOnly,
        keyboardType: keyboardType,
        maxLines: maxLines,
        minLines: maxLines == 1 ? 1 : 3,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          prefixIcon: Icon(
            icon,
            color: isReadOnly
                ? AppColors.textSecondary.withOpacity(0.5)
                : AppColors.primaryGold,
            size: 18,
          ),
          hintText: label,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
          labelText: label,
          labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isReadOnly
                    ? AppColors.textSecondary.withOpacity(0.5)
                    : AppColors.primaryGold,
              ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isReadOnly
                  ? AppColors.textSecondary.withOpacity(0.6)
                  : AppColors.textPrimary,
            ),
      ),
    );
  }

  Widget _buildDropdownField(
    BuildContext context, {
    required String label,
    required RxList<String> items,
    required Rxn<String> selectedValue,
    required IconData icon,
    bool isReadOnly = false,
  }) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: isReadOnly ? AppColors.bgLight : AppColors.secondaryWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.secondaryGrey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: DropdownButtonFormField<String>(
          value: selectedValue.value,
          onChanged: isReadOnly
              ? null
              : (value) {
                  selectedValue.value = value;
                },
          items: items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ),
              )
              .toList(),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            prefixIcon: Icon(
              icon,
              color: isReadOnly
                  ? AppColors.textSecondary.withOpacity(0.5)
                  : AppColors.primaryGold,
              size: 18,
            ),
            hintText: label,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
            labelText: label,
            labelStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isReadOnly
                      ? AppColors.textSecondary.withOpacity(0.5)
                      : AppColors.primaryGold,
                ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          isExpanded: true,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isReadOnly
                    ? AppColors.textSecondary.withOpacity(0.6)
                    : AppColors.textPrimary,
              ),
          icon: Icon(
            Iconsax.arrow_down_outline,
            color: isReadOnly
                ? AppColors.textSecondary.withOpacity(0.5)
                : AppColors.primaryGold,
            size: 18,
          ),
        ),
      ),
    );
  }
}
