// standalone_migration.dart
//
// Standalone Firestore Migration Script
// Run directly from PowerShell without modifying main.dart
//
// USAGE:
// dart run standalone_migration.dart
//

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// ══════════════════════════════════════════════════════════════════════════
// FIREBASE CONFIGURATION
// ══════════════════════════════════════════════════════════════════════════
// You need to fill in your Firebase config here
// Get it from: Firebase Console → Project Settings → Your apps → Web app

class FirebaseConfig {
  static const Map<String, String> config = {
    'apiKey': 'AIzaSyBlP3byoGvGsr12nyuugJw6u3ux8vPzlqc',
    'authDomain': 'dims-must.firebaseapp.com',
    'projectId': 'dims-must',
    'storageBucket': 'dims-must.firebasestorage.app',
    'messagingSenderId': '196272608738',
    'appId': '1:196272608738:web:85d1ec590723ba3ee0d5bb',
  };
}

// ══════════════════════════════════════════════════════════════════════════
// MAIN MIGRATION FUNCTION
// ══════════════════════════════════════════════════════════════════════════

Future<void> main(List<String> arguments) async {
  print('');
  print('╔════════════════════════════════════════════════════════════╗');
  print('║       DIMS Company Migration Script v1.0                  ║');
  print('╚════════════════════════════════════════════════════════════╝');
  print('');

  // Check if running in correct directory
  if (!await File('pubspec.yaml').exists()) {
    print('❌ Error: Please run this script from your project root directory');
    print('   Example: dart run lib/scripts/standalone_migration.dart');
    exit(1);
  }

  // Initialize Firebase
  print('🔥 Initializing Firebase...');
  try {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: FirebaseConfig.config['apiKey']!,
        authDomain: FirebaseConfig.config['authDomain']!,
        projectId: FirebaseConfig.config['projectId']!,
        storageBucket: FirebaseConfig.config['storageBucket']!,
        messagingSenderId: FirebaseConfig.config['messagingSenderId']!,
        appId: FirebaseConfig.config['appId']!,
      ),
    );
    print('✅ Firebase initialized successfully\n');
  } catch (e) {
    print('❌ Firebase initialization failed: $e');
    print('   Please check your Firebase configuration in this script.');
    exit(1);
  }

  // Confirm before proceeding
  print('⚠️  This will update ALL companies in your Firestore database.');
  print('   Make sure you have a backup before proceeding!');
  print('');
  stdout.write('   Continue? (yes/no): ');
  
  final confirmation = stdin.readLineSync()?.toLowerCase();
  if (confirmation != 'yes' && confirmation != 'y') {
    print('\n❌ Migration cancelled by user.');
    exit(0);
  }

  print('');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('🔄 Starting Migration...');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('');

  await migrateCompanies();

  print('');
  print('✨ Done! Press Enter to exit...');
  stdin.readLineSync();
  exit(0);
}

// ══════════════════════════════════════════════════════════════════════════
// MIGRATION LOGIC
// ══════════════════════════════════════════════════════════════════════════

Future<void> migrateCompanies() async {
  try {
    final firestore = FirebaseFirestore.instance;
    
    // Get all existing company documents
    print('📊 Fetching companies from Firestore...');
    final companiesSnapshot = await firestore.collection('companies').get();
    
    final totalCompanies = companiesSnapshot.docs.length;
    print('   Found $totalCompanies ${totalCompanies == 1 ? 'company' : 'companies'}');
    print('');
    
    if (totalCompanies == 0) {
      print('⚠️  No companies found in database. Nothing to migrate.');
      return;
    }

    int successCount = 0;
    int errorCount = 0;
    int currentIndex = 0;
    
    for (var doc in companiesSnapshot.docs) {
      currentIndex++;
      
      try {
        final existingData = doc.data();
        final companyName = existingData['name'] ?? 'Unknown';
        
        print('[$currentIndex/$totalCompanies] Migrating: $companyName');
        
        // Build the enhanced data structure
        final enhancedData = _buildEnhancedCompanyData(existingData, doc.id);
        
        // Update the document
        await doc.reference.update(enhancedData);
        
        successCount++;
        print('              ✅ Success');
        
      } catch (e) {
        errorCount++;
        print('              ❌ Error: $e');
      }
      
      print('');
    }
    
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('📊 Migration Summary:');
    print('   ✅ Successful: $successCount');
    if (errorCount > 0) {
      print('   ❌ Failed: $errorCount');
    }
    print('   📈 Total: $totalCompanies');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    
  } catch (e) {
    print('');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('❌ Migration Failed: $e');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  }
}

/// Builds enhanced company data while preserving existing fields
Map<String, dynamic> _buildEnhancedCompanyData(
  Map<String, dynamic> existing,
  String companyId,
) {
  final now = FieldValue.serverTimestamp();
  
  return {
    // ══════════════════════════════════════════════════════════════════════
    // PRESERVED EXISTING FIELDS (renamed to new format)
    // ══════════════════════════════════════════════════════════════════════
    'name': existing['name'] ?? 'Unknown Company',
    'location': existing['location'] ?? 'Unknown',
    'contactPerson': existing['contactPerson'] ?? 'Unknown',
    
    // Rename old fields to new format
    'contactEmail': existing['email'] ?? existing['contactEmail'] ?? 'no-email@company.com',
    'contactPhone': existing['phone'] ?? existing['contactPhone'] ?? 'No phone',
    
    'website': existing['website'],
    'industry': existing['industry'] ?? 'Other',
    'description': existing['description'],
    
    // Keep original creation info
    'createdAt': existing['createdAt'] ?? now,
    'createdByPath': existing['createdByPath'] ?? '',
    
    // ══════════════════════════════════════════════════════════════════════
    // NEW FIELDS WITH SENSIBLE DEFAULTS
    // ══════════════════════════════════════════════════════════════════════
    
    // Company Details
    'industrySector': _inferIndustrySector(existing['industry']),
    'companySize': 'medium',
    'mission': null,
    'logoUrl': null,
    
    // Location Details
    'district': null,
    'country': 'Uganda',
    'physicalAddress': null,
    'postalAddress': null,
    
    // Contact Enhancement
    'alternativePhone': null,
    'contactJobTitle': null,
    
    // Internship Program
    'maxInterns': 5,
    'currentInterns': 0,
    'isAcceptingInterns': true,
    'acceptedPrograms': ['BIT', 'CS', 'SE'],
    'preferredSkills': <String>[],
    'internshipBenefits': null,
    'internshipRequirements': null,
    
    // Supervisor Info
    'supervisorName': existing['contactPerson'],
    'supervisorEmail': existing['email'] ?? existing['contactEmail'],
    'supervisorPhone': existing['phone'] ?? existing['contactPhone'],
    'supervisorJobTitle': null,
    'supervisorDepartment': null,
    
    // Legal/Verification
    'registrationNumber': null,
    'tinNumber': null,
    'yearEstablished': null,
    'certificateUrl': null,
    
    // Status & Approval
    'status': existing['isApproved'] == true ? 'approved' : 'pending',
    'isVerified': existing['isApproved'] ?? false,
    'verifiedBy': null,
    'verifiedAt': existing['isApproved'] == true ? existing['createdAt'] : null,
    'rejectionReason': null,
    
    // Ownership
    'createdBy': null,
    'createdByRole': null,
    
    // Statistics
    'totalInternsHosted': 0,
    'successfulPlacements': 0,
    'averageRating': 0.0,
    'totalReviews': 0,
    
    // Timestamps
    'updatedAt': now,
    'lastActivityAt': existing['createdAt'] ?? now,
    
    // Metadata
    'tags': <String>[],
    'customFields': <String, dynamic>{},
    'notes': 'Migrated from old schema on ${DateTime.now().toIso8601String()}',
  };
}

/// Infer industry sector from industry string
String _inferIndustrySector(dynamic industry) {
  if (industry == null) return 'other';
  
  final industryLower = industry.toString().toLowerCase();
  
  if (industryLower.contains('tech') || 
      industryLower.contains('software') || 
      industryLower.contains('it')) {
    return 'technology';
  }
  if (industryLower.contains('financ') || 
      industryLower.contains('bank')) {
    return 'finance';
  }
  if (industryLower.contains('health') || 
      industryLower.contains('medical')) {
    return 'healthcare';
  }
  if (industryLower.contains('educat') || 
      industryLower.contains('school')) {
    return 'education';
  }
  if (industryLower.contains('retail') || 
      industryLower.contains('shop')) {
    return 'retail';
  }
  if (industryLower.contains('hotel') || 
      industryLower.contains('tourism')) {
    return 'hospitality';
  }
  if (industryLower.contains('construct') || 
      industryLower.contains('build')) {
    return 'construction';
  }
  if (industryLower.contains('telecom') || 
      industryLower.contains('mobile')) {
    return 'telecommunications';
  }
  if (industryLower.contains('energy') || 
      industryLower.contains('power')) {
    return 'energy';
  }
  if (industryLower.contains('transport')) {
    return 'transportation';
  }
  if (industryLower.contains('media') || 
      industryLower.contains('broadcast')) {
    return 'media';
  }
  if (industryLower.contains('government') || 
      industryLower.contains('public')) {
    return 'government';
  }
  if (industryLower.contains('ngo') || 
      industryLower.contains('nonprofit')) {
    return 'nonprofit';
  }
  if (industryLower.contains('manufactur')) {
    return 'manufacturing';
  }
  if (industryLower.contains('agricult') || 
      industryLower.contains('farm')) {
    return 'agriculture';
  }
  
  return 'other';
}