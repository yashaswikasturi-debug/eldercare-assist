# 🏥 ElderCare – Emergency Assist

**Safety that listens, so help is never far.**

ElderCare – Emergency Assist is a web-based elderly care and safety management platform designed to help senior citizens during medical emergencies. It provides voice-based emergency detection, GPS location tracking, medication reminders, medical record management, and caregiver monitoring through a single user-friendly dashboard.

The main goal is to make emergency assistance faster, easier, and more accessible for elderly people, especially those who may not be able to operate a phone during critical situations.

## 🌟 Key Features

### 1. Voice-Activated Emergency Detection
- Detects emergency phrases through voice recognition.
- Supports multiple languages, including English, Hindi, Tamil, Telugu, Bengali, and Marathi.
- Identifies potential emergency situations using a phrase-based detection system.
- Provides a 3-second cancellation window to prevent false alarms.

### 2. SOS Emergency Assistance
- Dedicated SOS emergency button.
- Automatically initiates a call to the first-priority emergency contact after confirmation.
- Prepares emergency messages containing relevant medical information.
- Supports emergency contact notifications through phone, SMS, and email applications.

### 3. Live GPS Location Tracking
- Retrieves the elderly user's current location.
- Displays GPS coordinates.
- Provides a Google Maps location link.
- Allows location sharing with caregivers and emergency contacts.

### 4. Medical Records Management
- Stores important medical information.
- Blood group and allergies.
- Existing medical conditions.
- Previous medical history.
- Doctor information and emergency notes.

### 5. Medication Management
- Add and manage prescribed medicines.
- Set medication schedules.
- Receive medication reminders.
- Track remaining medicine quantities.
- Get low-stock notifications.
- Prepare medicine refill requests.

### 6. Caregiver Dashboard
- Separate login for elderly users and caregivers.
- View patient medical information.
- Monitor medication adherence.
- Receive emergency alerts.
- Send check-in messages.
- Track appointments and care activities.

### 7. Additional Features
- Emergency history and activity logs.
- Appointment scheduling.
- Care journal.
- Government emergency helpline contacts.
- Dark and light themes.
- Demo mode and emergency detection testing.
- Offline status indication.

## 🛠️ Technologies Used

| Technology | Purpose |
|---|---|
| HTML5 | Website structure |
| CSS3 | Styling and responsive design |
| JavaScript | Application logic and functionality |
| Web Speech API | Voice recognition and speech output |
| Geolocation API | GPS location tracking |
| LocalStorage | Local data storage |
| Web Crypto API | Password hashing |
| Google Maps | Location sharing |

## 📂 Project Structure

```text
ElderCare-Emergency-Assist/
│
├── index.html
└── README.md
```

The current implementation is contained in a single HTML file with embedded CSS and JavaScript.

## 🚀 How to Run the Project

1. Clone the repository:

```bash
git clone https://github.com/your-username/ElderCare-Emergency-Assist.git
```

2. Open the project folder:

```bash
cd ElderCare-Emergency-Assist
```

3. Open `index.html` in Google Chrome or Microsoft Edge.

4. Register as an elderly user or caregiver.

5. Allow microphone and location permissions when prompted.

6. Explore the dashboard and test the available features.

**Note:** Microphone and GPS features require browser permissions. Use HTTPS or localhost where required by browser security rules.

## 🧪 Testing Features

The project includes a testing module to evaluate emergency phrase detection.

- Tests 12 predefined English and Hindi phrases.
- Calculates detection accuracy.
- Identifies false positives and false negatives.
- Measures average detection time.
- Tracks GPS and notification-related session metrics.

A separate demo mode allows users to simulate emergency situations without making real emergency calls.

## 🔮 Future Enhancements

The following improvements are planned for future versions:

- Python-based backend using Flask or Django.
- Secure cloud database integration.
- Real-time communication between elderly users and caregivers across different devices.
- AI/ML-based emergency detection with improved accuracy.
- Automatic SMS and email delivery through reliable backend services.
- Integration with wearable health monitoring devices.
- Real-time heart rate, blood pressure, and oxygen-level monitoring.
- Medicine ordering integration with pharmacy platforms.
- Multilingual voice assistance with improved regional-language support.
- Push notifications for caregivers.

## 🔐 Security and Privacy

The current prototype includes:
- Role-based access for elderly users and caregivers.
- SHA-256 password hashing.
- HTML input escaping.
- Automatic logout after inactivity.
- Activity and audit logs.

**Important:** This is a prototype, not a production-ready medical emergency service. Data is currently stored in browser LocalStorage, and notifications use device applications rather than a fully integrated backend. Production deployment requires stronger authentication, encrypted server-side storage, secure communication, and extensive real-world testing.

## 🎯 Project Objective

To develop an accessible elderly assistance platform that combines voice recognition, emergency response, location tracking, medication management, and caregiver communication to improve the safety and independence of senior citizens.

## 👩‍💻 Developed By

**Kasturi Yashaswi**
**Hanne Gabrilla Hanne**
**Ashicka Muthu**
**Padma sri**

SRM Institute of Science and Technology, Trichy

---

⭐ If you find this project useful, consider giving the repository a star!

**ElderCare – Because every second matters, and every life matters.**
