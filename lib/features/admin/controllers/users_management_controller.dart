// lib/features/admin/controllers/users_management_controller.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dims/features/auth/controllers/auth_controller.dart';
import 'package:dims/features/auth/data/models/user_model.dart';

// Provider to get approved users by role
final approvedUsersProvider = StreamProvider.family<List<UserModel>, UserRole>((ref, role) {
  final firestore = ref.watch(firestoreProvider);
  
  return firestore
      .collection('users')
      .where('role', isEqualTo: role.name)
      .where('isApproved', isEqualTo: true)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .asyncMap((snapshot) async {
    final futures = snapshot.docs.map((doc) async {
      try {
        return UserModel.fromFirestore(doc, null);
      } catch (e) {
        return null;
      }
    }).toList();
    
    final users = await Future.wait(futures);
    return users.whereType<UserModel>().toList();
  });
});

// Controller for user management operations
final usersManagementControllerProvider = Provider((ref) {
  return UsersManagementController(ref);
});

class UsersManagementController {
  final Ref _ref;
  
  UsersManagementController(this._ref);
  
  FirebaseFirestore get _db => _ref.read(firestoreProvider);

  Future<Map<String, dynamic>> getRoleDetails(UserModel user) async {
    try {
      switch (user.role) {
        case UserRole.student:
          final doc = await _db.collection('students').doc(user.uid).get();
          return doc.data() ?? <String, dynamic>{};
        case UserRole.supervisor:
          final doc =
              await _db.collection('supervisorProfiles').doc(user.uid).get();
          return doc.data() ?? <String, dynamic>{};
        default:
          return <String, dynamic>{};
      }
    } catch (e) {
      throw Exception('Failed to load user details: $e');
    }
  }
  
  /// Deactivate a user account
  Future<void> deactivateUser(String uid) async {
    try {
      await _db.collection('users').doc(uid).update({
        'isApproved': false,
        'deactivatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to deactivate user: $e');
    }
  }
  
  /// Reactivate a user account
  Future<void> reactivateUser(String uid) async {
    try {
      await _db.collection('users').doc(uid).update({
        'isApproved': true,
        'reactivatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to reactivate user: $e');
    }
  }
  
  /// Update user information
  Future<void> updateUser(String uid, Map<String, dynamic> updates) async {
    try {
      await _db.collection('users').doc(uid).update(updates);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Future<void> updateManagedUserProfile({
    required UserModel user,
    required String displayName,
    required String? phoneNumber,
    String? registrationNumber,
    String? program,
    int? academicYear,
    String? currentLevel,
    String? department,
  }) async {
    final batch = _db.batch();
    final trimmedPhone = phoneNumber?.trim();

    batch.update(_db.collection('users').doc(user.uid), {
      'displayName': displayName.trim(),
      'phoneNumber':
          trimmedPhone == null || trimmedPhone.isEmpty ? null : trimmedPhone,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    if (user.role == UserRole.student) {
      batch.set(
        _db.collection('students').doc(user.uid),
        {
          'fullName': displayName.trim(),
          'registrationNumber': registrationNumber?.trim(),
          'program': program,
          'academicYear': academicYear,
          'currentLevel': currentLevel,
          'updatedAt': FieldValue.serverTimestamp(),
        }..removeWhere((key, value) => value == null),
        SetOptions(merge: true),
      );
    }

    if (user.role == UserRole.supervisor) {
      batch.set(
        _db.collection('supervisorProfiles').doc(user.uid),
        {
          'fullName': displayName.trim(),
          'email': user.email,
          'phoneNumber':
              trimmedPhone == null || trimmedPhone.isEmpty ? null : trimmedPhone,
          'department': department?.trim(),
          'updatedAt': FieldValue.serverTimestamp(),
        }..removeWhere((key, value) => value == null),
        SetOptions(merge: true),
      );
    }

    await batch.commit();
  }
  
  /// Delete user permanently
  Future<void> deleteUser(String uid) async {
    try {
      // Delete user document
      await _db.collection('users').doc(uid).delete();
      
      // TODO: Delete related data (student profiles, assignments, etc.)
      // You might want to use Cloud Functions for this to ensure consistency
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
