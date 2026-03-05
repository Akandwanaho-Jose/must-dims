// lib/scripts/migrate_companies.dart
//
// This script migrates existing company documents to the new enhanced schema
//

import 'package:cloud_firestore/cloud_firestore.dart';

/// Migration script to update existing companies to new schema
Future<void> migrateCompanies() async {
  print('');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('🔄 Starting Company Migration...');
  print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
  print('');
  
  try {
    final firestore = FirebaseFirestore.instance;
    
    // Get all existing company documents
    print('📊 Fetching companies from Firestore...');
    final companiesSnapshot = await firestore.collection('companies').get();
    
    print('   Found ${companiesSnapshot.docs.length} companies to migrate');
    print('');
    
    int successCount = 0;
    int errorCount = 0;
    
    for (var doc in companiesSnapshot.docs) {
      try {
        final existingData = doc.data();
        final companyId = doc.id;
        
        print('⚙️  Migrating: ${existingData['name'] ?? companyId}');
        
        // Build the enhanced data structure
        final enhancedData = _buildEnhancedCompanyData(existingData, companyId);
        
        // Update the document
        await doc.reference.update(enhancedData);
        
        successCount++;
        print('   ✅ Success');
        
      } catch (e) {
        errorCount++;
        print('   ❌ Error: $e');
      }
      
      print('');
    }
    
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('✨ Migration Complete!');
    print('   ✅ Successful: $successCount');
    if (errorCount > 0) {
      print('   ❌ Failed: $errorCount');
    }
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    
  } catch (e) {
    print('');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
    print('❌ Migration Failed: $e');
    print('━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━');
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
    'companySize': 'medium', // Default to medium, admins can update
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
    'maxInterns': 5,  // Conservative default
    'currentInterns': 0,  // Assume none currently
    'isAcceptingInterns': true,  // Default to open
    'acceptedPrograms': ['BIT', 'CS', 'SE'],  // Accept all by default
    'preferredSkills': <String>[],
    'internshipBenefits': null,
    'internshipRequirements': null,
    
    // Supervisor Info (initially same as contact)
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