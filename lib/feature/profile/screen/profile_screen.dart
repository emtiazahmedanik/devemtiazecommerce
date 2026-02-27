import 'package:devemtiazecom/feature/profile/controller/profile_controller.dart';
import 'package:devemtiazecom/feature/profile/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: Obx(() {
        if (profileController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (profileController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.circleExclamation,
                  color: Colors.red.shade400,
                  size: 60,
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    profileController.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => profileController.fetchUserProfile(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (profileController.profile.value == null) {
          return const Center(
            child: Text('No profile data available'),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),
              _buildContactSection(),
              const SizedBox(height: 16),
              _buildAddressSection(),
              const SizedBox(height: 16),
              _buildAccountSection(),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProfileHeader() {
    final profile = profileController.profile.value;
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFE8E8E8)),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade400,
                  Colors.blue.shade700,
                ],
              ),
            ),
            child: Center(
              child: Text(
                _getInitials(profile),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            profile?.name?.fullName ?? 'Unknown User',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '@${profile?.username ?? 'N/A'}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection() {
    final profile = profileController.profile.value;
    return _buildSection(
      icon: FontAwesomeIcons.contactCard,
      title: 'Contact Information',
      children: [
        _buildInfoRow(
          icon: FontAwesomeIcons.envelope,
          label: 'Email',
          value: profile?.email ?? 'N/A',
        ),
        const Divider(height: 16),
        _buildInfoRow(
          icon: FontAwesomeIcons.phone,
          label: 'Phone',
          value: profile?.phone ?? 'N/A',
        ),
      ],
    );
  }

  Widget _buildAddressSection() {
    final profile = profileController.profile.value;
    final address = profile?.address;
    if (address == null) {
      return const SizedBox.shrink();
    }

    return _buildSection(
      icon: FontAwesomeIcons.locationDot,
      title: 'Address',
      children: [
        _buildInfoRow(
          icon: FontAwesomeIcons.houseFlag,
          label: 'Street',
          value: '${address.number ?? ''} ${address.street ?? 'N/A'}',
        ),
        const Divider(height: 16),
        _buildInfoRow(
          icon: FontAwesomeIcons.city,
          label: 'City',
          value: address.city ?? 'N/A',
        ),
        const Divider(height: 16),
        _buildInfoRow(
          icon: FontAwesomeIcons.map,
          label: 'Zip Code',
          value: address.zipcode ?? 'N/A',
        ),
        if (address.geolocation != null) ...[
          const Divider(height: 16),
          _buildInfoRow(
            icon: FontAwesomeIcons.satellite,
            label: 'Coordinates',
            value:
                '${address.geolocation?.latitude ?? 'N/A'}, ${address.geolocation?.longitude ?? 'N/A'}',
          ),
        ],
      ],
    );
  }

  Widget _buildAccountSection() {
    final profile = profileController.profile.value;
    return _buildSection(
      icon: FontAwesomeIcons.user,
      title: 'Account',
      children: [
        _buildInfoRow(
          icon: FontAwesomeIcons.hashtag,
          label: 'User ID',
          value: profile?.id?.toString() ?? 'N/A',
        ),
        const Divider(height: 16),
        _buildInfoRow(
          icon: FontAwesomeIcons.key,
          label: 'Username',
          value: profile?.username ?? 'N/A',
        ),
      ],
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Color(0xFFE8E8E8)),
              ),
            ),
            child: Row(
              children: [
                FaIcon(
                  icon,
                  color: Colors.blue.shade700,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        FaIcon(
          icon,
          color: Colors.grey.shade600,
          size: 16,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getInitials(ProfileModel? profile) {
    final firstname = profile?.name?.firstname ?? '';
    final lastname = profile?.name?.lastname ?? '';
    final firstInitial = firstname.isNotEmpty ? firstname[0].toUpperCase() : '';
    final lastInitial = lastname.isNotEmpty ? lastname[0].toUpperCase() : '';
    return '$firstInitial$lastInitial';
  }
}
