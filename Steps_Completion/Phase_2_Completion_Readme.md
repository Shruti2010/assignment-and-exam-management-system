# 📘 ASSIGNMENT & EXAM MANAGEMENT SYSTEM
### Phase 2: Org Setup & Configuration

---

## 🟠 OVERVIEW
In Phase 2, the Salesforce environment was set up and configured to support the academic workflows for assignment and exam management. This phase focused on setting up organizational structures, user roles, permissions, and data-sharing rules to ensure secure, efficient, and streamlined operations.

---

## ✅ 1. SALESFORCE EDITIONS – DEVELOPER ORG
- Set up the Salesforce Developer Org to build and test functionalities tailored for academic workflows.

---

## ✅ 2. COMPANY PROFILE SETUP
The organization profile was configured with the following details:

- **Organization Name:** Prof. Ram Meghe Institute of Technology & Research  
- **Default Locale:** English (India)  
- **Default Currency:** INR  
- **Default Time Zone:** (GMT+05:30) India Standard Time

---

## ✅ 3. BUSINESS HOURS & HOLIDAYS
- Created a Business Hours setting named **School Hours**.  
- All days are available 7:00 AM to 05:00 PM to support academic activities at any time.

---

## ✅ 4. FISCAL YEAR SETTINGS
- Defined the fiscal year from **April 1, 2025, to March 31, 2026** to align financial tracking and reporting with academic schedules.

---

## ✅ 5. USER SETUP & LICENSES
User roles, profiles, and licenses were configured as follows:

### Teacher User
- **License:** Salesforce  
- **Profile:** Teacher_Profile  
- **Role:** Teacher

### Student User
- **License:** Salesforce  
- **Profile:** Student_Profile  
- **Role:** Student

### Guardian User
- **License:** Salesforce  
- **Profile:** Guardian_Profile  
- **Role:** Guardian

**Role Hierarchy:**  
Academic_Admin → Teacher → Student  
Guardian role placed under Admin.

---

## ✅ 6. PERMISSION SETS
Permission sets were created to manage access and rights:

- **PS_Grade_Manager:** Extra edit rights on `Grade__c`.
- **PS_Submission_Reviewer:** Manage rights on `Submission__c` (assigned to Teacher user Anita).
- **PS_Assignment:** Manage rights on `Assignment__c` (assigned to Teacher user Anita).

---

## ✅ 7. ORGANIZATION-WIDE DEFAULTS (OWD)
Configured the sharing model to ensure privacy and controlled access:

- `Student__c` = Private  
- `Guardian__c` = Private  
- `Assignment__c` = Private  
- `Submission__c` = Private  
- `Grade__c` = Private  
- `Course__c` = Public Read Only

---

## ✅ 8. SHARING RULES
Sharing rules were implemented to enhance collaboration while maintaining appropriate access:

- **Grades (`Grade__c`):** Shared with the Guardian role to view children’s records.
- **Submissions (`Submission__c`):** Shared with the Teacher role for management.
- **Assignments:** Configured according to the role hierarchy to ensure proper access.

---

## 📂 OUTCOMES OF PHASE 2
This phase successfully established the Salesforce environment with:

✔ Proper configurations for users, roles, profiles, and permissions  
✔ Secure, role-based access to sensitive academic data  
✔ Data-sharing policies that promote collaboration while ensuring privacy  
✔ Seamless workflows, timely communication, and transparent management of student records

The setup lays a strong foundation for further development and efficient academic processes.

---

> _End of Phase 2 Report – Assignment & Exam Management System_
