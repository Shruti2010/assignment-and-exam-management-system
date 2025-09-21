# 📘 ASSIGNMENT & EXAM MANAGEMENT SYSTEM
### Phase 4: Process Automation (Admin) – Completion Report

*Project:* Student Course Enrollment & Attendance Tracker  
*Institute:* Prof. Ram Meghe Institute of Technology & Research  

---

## ✅ 1. Validation Rules  
Validation rules were implemented across objects to enforce data integrity and consistency:  

- *Student / Guardian*: Validate email formats, require guardian phone, prevent self-references.  
- *Assignment*: Ensure due date not before creation, max marks positive, and valid course linkage.  
- *Exam*: Enforce positive duration, end date after start date, and course requirement.  
- *Grade*: Prevent negative marks, restrict marks within maximum allowed, require valid submission.  
- *Submissions*: Submission date must not precede assignment creation.  

---

## ✅ 2. Workflow Rule  
- *Send_Welcome_Email*: Automatically sends a welcome email to new students upon enrollment.  

---

## ✅ 3. Flow Builder Automations  
Record-triggered flows were designed to enhance automation and communication:  

- *Assignment_Graded_Notification* – Notifies students when assignments are graded.  
- *Assignment_Reminder_Before_DueDate_Flow* – Sends reminders before due dates.  
- *Exam_tt_Notification* – Sends exam timetable notifications.  
- *Late_Submission_Notification_Flow* – Alerts students and guardians on late submissions.  

---

## ✅ 4. Email Alerts  
Email alerts were configured and linked to flows and workflow rules:  

- Assignment graded notifications  
- Assignment due date reminders  
- Exam timetable notifications  
- Late submission alerts  

---

## 📂 OUTCOMES OF PHASE 4  
✔ Validation rules established for strong data integrity  
✔ Workflow rule implemented for automated student communication  
✔ Flow Builder used to handle key assignment and exam processes  
✔ Email alerts integrated with workflows and flows  
✔ Phase 4 deliverables completed and ready for testing and future enhancements  

---

> End of Phase 4 Completion Report – Assignment & Exam Management System