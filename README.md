

**Efficient Identity-Based Distributed Decryption Scheme for Electronic Personal Health Record Sharing System** 


System Overview

This project is a secure and efficient system designed for electronic personal health record sharing. It provides identity-based distributed decryption, ensuring robust security and controlled access to sensitive health records.

**User Roles**
Doctor
Patient
Superintendent
Admin
KGC (Key Generation Center)

**Features**
1. Registration and Login Pages
Doctor Registration and Login
Patient Registration and Login
Superintendent Registration and Login
KGC Login
Admin Login

**Registration and Login Flow**
Doctor Registration
Sends a confirmation email and a private key upon successful registration.
Sets the doctor's status to inactive.
Patient Registration
Sends a confirmation email upon successful registration.
Sets the patient's status to active (if required).
Superintendent Registration
Sends a confirmation email and a private key upon successful registration.
Sets the superintendent’s status to inactive.
Login Process
Users (Doctors, Patients, Superintendents) log in using their registered credentials and private key.

**Role-Based Functionalities**

**Doctor Functionality**
View the patient list.
Request access to specific patient files.
View a list of requested files.

**Patient Functionality**
Upload health record files.
View a list of uploaded files.

**Superintendent Functionality**
Superintendents are activated by KGC after registration.

**Admin Functionality**
Approve file access requests.

**KGC Responsibilities**
Activate Doctors and Superintendents.

**Email Notifications**
Sends registration confirmations.
Transmits private keys securely via email.

**Security Considerations**
Private Key Security: Ensure secure transmission of private keys.
Authentication & Authorization: Robust checks for all actions.
Data Integrity: Implement encryption and access control mechanisms.
