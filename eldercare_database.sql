PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS users (
    user_id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE COLLATE NOCASE,
    phone TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL CHECK (role IN ('elder', 'caregiver')),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_active INTEGER NOT NULL DEFAULT 1 CHECK (is_active IN (0,1))
);

CREATE TABLE IF NOT EXISTS elder_profiles (
    elder_id INTEGER PRIMARY KEY,
    age INTEGER,
    blood_group TEXT,
    allergies TEXT,
    medical_conditions TEXT,
    medical_history TEXT,
    doctor_information TEXT,
    emergency_notes TEXT,
    FOREIGN KEY (elder_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS caregiver_links (
    link_id INTEGER PRIMARY KEY AUTOINCREMENT,
    caregiver_id INTEGER NOT NULL,
    elder_id INTEGER NOT NULL,
    relationship TEXT,
    linked_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (caregiver_id, elder_id),
    FOREIGN KEY (caregiver_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS emergency_contacts (
    contact_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    contact_name TEXT NOT NULL,
    relationship TEXT,
    phone TEXT NOT NULL,
    email TEXT,
    priority INTEGER NOT NULL DEFAULT 1,
    notification_preference TEXT DEFAULT 'Call + SMS',
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS medications (
    medication_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    medicine_name TEXT NOT NULL,
    dosage TEXT,
    quantity INTEGER NOT NULL DEFAULT 0,
    remaining_quantity INTEGER NOT NULL DEFAULT 0,
    start_date TEXT,
    end_date TEXT,
    refill_status TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE,
    CHECK (quantity >= 0),
    CHECK (remaining_quantity >= 0)
);

CREATE TABLE IF NOT EXISTS medication_schedules (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    medication_id INTEGER NOT NULL,
    period TEXT NOT NULL CHECK (period IN ('Morning','Afternoon','Night')),
    reminder_time TEXT NOT NULL,
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS medication_logs (
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    medication_id INTEGER NOT NULL,
    elder_id INTEGER NOT NULL,
    dose_status TEXT NOT NULL DEFAULT 'Taken',
    logged_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id) ON DELETE CASCADE,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS refill_orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    medication_id INTEGER,
    medicine_name TEXT NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 1,
    status TEXT NOT NULL DEFAULT 'Requested',
    ordered_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE,
    FOREIGN KEY (medication_id) REFERENCES medications(medication_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS appointments (
    appointment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    doctor_or_hospital TEXT,
    place TEXT,
    appointment_date TEXT NOT NULL,
    appointment_time TEXT,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    latitude REAL NOT NULL,
    longitude REAL NOT NULL,
    accuracy_m REAL,
    recorded_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    source TEXT DEFAULT 'Browser GPS',
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS emergency_events (
    event_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    detected_phrase TEXT NOT NULL,
    detected_language TEXT,
    confidence INTEGER,
    event_date TEXT NOT NULL,
    event_time TEXT NOT NULL,
    location_id INTEGER,
    notification_status TEXT DEFAULT 'Ready to send',
    call_status TEXT DEFAULT 'Ready',
    response_status TEXT DEFAULT 'Pending',
    is_resolved INTEGER NOT NULL DEFAULT 0 CHECK (is_resolved IN (0,1)),
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS emergency_event_timeline (
    timeline_id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_id INTEGER NOT NULL,
    event_message TEXT NOT NULL,
    logged_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES emergency_events(event_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS emergency_contact_actions (
    action_id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_id INTEGER NOT NULL,
    contact_id INTEGER,
    action_type TEXT NOT NULL CHECK (action_type IN ('Call','SMS','Email')),
    action_status TEXT DEFAULT 'Prepared',
    action_time TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES emergency_events(event_id) ON DELETE CASCADE,
    FOREIGN KEY (contact_id) REFERENCES emergency_contacts(contact_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS notifications (
    notification_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    category TEXT NOT NULL,
    message TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_read INTEGER NOT NULL DEFAULT 0 CHECK (is_read IN (0,1)),
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS check_ins (
    checkin_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    caregiver_id INTEGER,
    prompt_text TEXT NOT NULL,
    reply_text TEXT,
    sent_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    replied_at TEXT,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE,
    FOREIGN KEY (caregiver_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS care_journal (
    note_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    caregiver_id INTEGER,
    category TEXT NOT NULL,
    note_text TEXT NOT NULL,
    recorded_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE,
    FOREIGN KEY (caregiver_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS audit_logs (
    audit_id INTEGER PRIMARY KEY AUTOINCREMENT,
    elder_id INTEGER NOT NULL,
    actor_user_id INTEGER,
    action TEXT NOT NULL,
    created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (elder_id) REFERENCES elder_profiles(elder_id) ON DELETE CASCADE,
    FOREIGN KEY (actor_user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS emergency_services (
    service_id INTEGER PRIMARY KEY AUTOINCREMENT,
    service_name TEXT NOT NULL,
    service_type TEXT,
    phone_number TEXT NOT NULL UNIQUE
);

CREATE INDEX IF NOT EXISTS idx_contacts_elder ON emergency_contacts(elder_id);
CREATE INDEX IF NOT EXISTS idx_meds_elder ON medications(elder_id);
CREATE INDEX IF NOT EXISTS idx_appointments_elder_date ON appointments(elder_id, appointment_date);
CREATE INDEX IF NOT EXISTS idx_events_elder_date ON emergency_events(elder_id, event_date);
CREATE INDEX IF NOT EXISTS idx_locations_elder_time ON locations(elder_id, recorded_at);
CREATE INDEX IF NOT EXISTS idx_notifications_elder_time ON notifications(elder_id, created_at);

INSERT OR IGNORE INTO emergency_services(service_name, service_type, phone_number) VALUES
('National Emergency Number (ERSS)', 'Government helpline', '112'),
('Ambulance', 'Government helpline', '108'),
('Elderline - Senior Citizens', 'Government helpline', '14567'),
('National Health Helpline', 'Government helpline', '104'),
('Tele-MANAS Mental Health', 'Government helpline', '14416'),
('Ayushman Bharat (PM-JAY)', 'Government helpline', '14555'),
('Maternal & Child Ambulance', 'Government helpline', '102');
