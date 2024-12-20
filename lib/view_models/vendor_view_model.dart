import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/admin_service.dart';

class Vendor {
  String id;
  String businessName;
  String email;
  String phone;

  Vendor({
    required this.id,
    required this.businessName,
    required this.email,
    required this.phone,
  });
}

class VendorNotifier extends StateNotifier<List<Vendor>> {
  final AdminService _adminService = AdminService();

  VendorNotifier() : super([]) {
    _loadVendors();
  }

  Future<void> _loadVendors() async {
    try {
      final vendors = await _adminService.fetchVendors();
      state = vendors.map((vendor) {
        return Vendor(
          id: vendor['_id'] ?? '',
          businessName: vendor['business_name'] ?? 'Unknown',
          email: vendor['email'] ?? '',
          phone: vendor['phone'] ?? 'N/A',
        );
      }).toList();
    } catch (e) {
      print("Failed to load vendors: $e");
    }
  }

  Future<void> updateVendor(String id, String businessName, String email, String phone) async {
    // Update locally
    state = state.map((vendor) {
      if (vendor.id == id) {
        return Vendor(id: id, businessName: businessName, email: email, phone: phone);
      }
      return vendor;
    }).toList();

    // Add API call to update the vendor in the backend
    // TODO: Implement API logic for updating a vendor
  }

  Future<void> deleteVendor(String id) async {
    // Update locally
    state = state.where((vendor) => vendor.id != id).toList();

    // Add API call to delete the vendor in the backend
    // TODO: Implement API logic for deleting a vendor
  }
}

final vendorProvider = StateNotifierProvider<VendorNotifier, List<Vendor>>((ref) => VendorNotifier());
