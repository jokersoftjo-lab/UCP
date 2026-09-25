# UCP Core Protocol v1.0

## المواصفة الهندسية الأساسية

### 1. الهدف

UCP Core Protocol هو البروتوكول الموحد الذي يربط الأجهزة والتطبيقات والألعاب والأجهزة الوسيطة داخل منصة UCP.

النظام الأساسي:

```text
Controller
    ↓
Transport
    ↓
UCP Core Protocol
    ↓
Receiver / Adapter
    ↓
Target
```

مثال أساسي:

```text
Android 5.1 Phone
       ↓ Wi-Fi
UCP Protocol v1.0
       ↓
Windows 11 Receiver
       ↓
Gamepad / Keyboard / Mouse
       ↓
Game / Emulator / Application
```

---

# 2. مكونات Core Protocol

يتكون UCP Core Protocol v1.0 من الوحدات التالية:

```text
UCP Core
├── Protocol Version
├── Device Identity
├── Capability System
├── Discovery
├── Handshake
├── Session
├── Authentication
├── Transport
├── Message System
├── Input System
├── Output / Feedback
├── Device State
├── Error System
├── Heartbeat
├── Configuration
├── Profiles
└── Extension System
```

---

# 3. Protocol Version

الإصدار الأول:

```text
UCP/1.0
```

ويجب أن يحتوي كل اتصال على معلومات الإصدار.

مثال:

```text
protocol:
  name: UCP
  major: 1
  minor: 0
```

### قواعد التوافق

`major` يمثل تغييرات غير متوافقة.

`minor` يمثل إضافات متوافقة.

مثال:

```text
1.0
1.1
1.2
```

يمكن أن تضيف خصائص جديدة مع الحفاظ على التوافق.

أما:

```text
2.0
```

فقد يحتوي على تغييرات أساسية في البروتوكول.

---

# 4. Device Identity

كل جهاز UCP يجب أن يمتلك هوية منطقية.

```text
Device ID
Device Name
Device Type
Platform
OS Version
UCP Version
Capabilities
Connection Types
```

مثال:

```json
{
  "device_id": "device-xxxxxxxx",
  "name": "My Android Phone",
  "type": "controller",
  "platform": "android",
  "os_version": "5.1",
  "ucp_version": "1.0"
}
```

ولا يعتمد `Device ID` على عنوان IP لأن عنوان IP قد يتغير.

---

# 5. Device Types

الإصدار الأول يعرف أنواعًا عامة:

```text
controller
receiver
bridge
game
application
tv
computer
phone
tablet
hardware
reader
custom
```

ويمكن لجهاز واحد أن يمتلك أكثر من وظيفة.

مثال:

```text
Phone
├── controller
├── receiver
└── remote
```

---

# 6. Capability System

الجهاز يعلن عن قدراته.

مثال:

```text
GAMEPAD
KEYBOARD
MOUSE
TOUCHPAD
MOTION
USB
HID
READING
SMART_REMOTE
VIBRATION
AUDIO
CAMERA
MICROPHONE
CUSTOM
```

مثال:

```json
{
  "capabilities": [
    "gamepad",
    "keyboard",
    "mouse",
    "motion"
  ]
}
```

وهذا يسمح للجهاز المستقبل بمعرفة ما يستطيع الجهاز المرسل القيام به.

---

# 7. Capability Parameters

لا يكفي معرفة أن الجهاز يدعم Gamepad.

يجب معرفة التفاصيل.

مثال:

```text
Gamepad
├── Buttons
├── DPad
├── Left Stick
├── Right Stick
├── Left Trigger
├── Right Trigger
├── Vibration
└── Motion
```

مثال:

```json
{
  "capability": "gamepad",
  "sticks": 2,
  "buttons": 16,
  "triggers": 2,
  "vibration": true
}
```

وبذلك يستطيع UCP بناء Profile مناسب للجهاز.

---

# 8. Discovery

قبل إنشاء Session يجب أن يستطيع الجهازان اكتشاف بعضهما.

مثال:

```text
Android Phone
      ↓
UCP Discovery
      ↓
Windows 11
```

يمكن أن يستخدم Discovery:

```text
Wi-Fi LAN
UDP
mDNS
Broadcast
Multicast
Manual IP
QR / Pairing Code
```

ويجب ألا يعتمد البروتوكول على طريقة Discovery واحدة.

---

# 9. Device Advertisement

الجهاز المستقبل يعلن:

```text
UCP Receiver
Windows 11
Device Name
Device ID
Protocol Version
Supported Capabilities
Connection Port
Security State
```

مثال:

```text
UCP Receiver
Windows-PC
192.168.x.x
UCP/1.0
GAMEPAD
KEYBOARD
MOUSE
READING
```

---

# 10. Handshake

بعد Discovery تبدأ عملية Handshake.

```text
Controller
    ↓ HELLO
Receiver
    ↓ HELLO_ACK
Controller
    ↓ CAPABILITIES
Receiver
    ↓ CAPABILITIES_ACK
Controller
    ↓ SESSION_REQUEST
Receiver
    ↓ SESSION_ACCEPT
```

بعدها تصبح Session جاهزة.

---

# 11. Session

كل اتصال فعال يحصل على Session.

```text
Session ID
Controller ID
Receiver ID
Protocol Version
Created Time
State
Capabilities
Security State
```

حالات Session:

```text
DISCONNECTED
DISCOVERING
CONNECTING
AUTHENTICATING
NEGOTIATING
CONNECTED
PAUSED
CLOSING
CLOSED
ERROR
```

---

# 12. Session ID

يجب ألا تعتمد الرسائل على IP فقط.

كل Session تمتلك:

```text
Session ID
```

مثال:

```text
session-xxxxxxxx
```

وتستخدم الرسائل:

```text
Device ID
Session ID
Message ID
Timestamp
```

---

# 13. Message System

كل رسالة UCP يجب أن تحتوي على Header موحد.

المفهوم الأساسي:

```text
UCP Message
├── Version
├── Message ID
├── Message Type
├── Source
├── Destination
├── Session
├── Timestamp
├── Flags
└── Payload
```

مثال منطقي:

```json
{
  "version": "1.0",
  "message_id": "msg-001",
  "type": "input.gamepad",
  "source": "phone-001",
  "destination": "pc-001",
  "session": "session-001",
  "timestamp": 123456789,
  "payload": {}
}
```

---

# 14. Message Types

الإصدار الأول يعرّف مجموعات الرسائل:

```text
system.*
device.*
discovery.*
session.*
auth.*
input.*
output.*
feedback.*
state.*
config.*
profile.*
reading.*
remote.*
usb.*
error.*
```

---

# 15. Input Messages

نظام الإدخال هو أحد أهم أجزاء UCP.

### Button

```text
input.button
```

بياناته:

```text
button
state
timestamp
```

### Axis

```text
input.axis
```

مثل:

```text
left_x
left_y
right_x
right_y
```

القيم تكون موحدة في Core.

مثلاً:

```text
-1.0 → 1.0
```

### Trigger

```text
input.trigger
```

النطاق:

```text
0.0 → 1.0
```

### D-Pad

```text
input.dpad
```

### Motion

```text
input.motion
```

يمكن أن يحتوي:

```text
accelerometer
gyroscope
rotation
orientation
```

---

# 16. Keyboard

رسائل:

```text
input.keyboard.down
input.keyboard.up
input.keyboard.text
```

ويجب استخدام معرفات مفاتيح موحدة داخل Core بدل إرسال أسماء خاصة بنظام Windows أو Android.

ثم يقوم Receiver بتحويلها إلى النظام المحلي.

---

# 17. Mouse

يدعم:

```text
mouse.move
mouse.button.down
mouse.button.up
mouse.wheel
mouse.absolute
mouse.relative
```

مثال:

```text
Phone Touchpad
      ↓
UCP Mouse Message
      ↓
Windows Mouse Input
```

---

# 18. Touchpad

يدعم:

```text
touch.down
touch.move
touch.up
touch.cancel
```

مع:

```text
pointer_id
x
y
pressure
timestamp
```

ويمكن استخدامه كـ:

```text
Touchpad
Drawing Controller
Remote Pointer
Game Touch Controller
```

---

# 19. Feedback

UCP ليس اتجاهًا واحدًا فقط.

يمكن للـ Receiver إرسال:

```text
feedback.vibration
feedback.audio
feedback.notification
feedback.status
feedback.game
```

مثال:

```text
Windows Game
    ↓
UCP Receiver
    ↓
Wi-Fi
    ↓
Phone
    ↓
Vibration
```

---

# 20. Game State

عند استخدام UCP SDK يمكن للعبة إرسال:

```text
health
ammo
score
map
player
mission
inventory
game_state
```

مثال:

```json
{
  "type": "state.game",
  "health": 85,
  "ammo": 24,
  "score": 1200
}
```

---

# 21. Reading Protocol

يدعم Core مستقبلًا محرك القراءة.

الرسائل الأساسية:

```text
reading.open
reading.close
reading.next
reading.previous
reading.goto
reading.search
reading.bookmark
reading.position
reading.chapter
reading.zoom
reading.settings
```

مثال:

```text
Android 5.1
    ↓
reading.next
    ↓
Windows 11
    ↓
Reading Engine
    ↓
Next Page
```

---

# 22. USB / HID Protocol

UCP Core يجب أن يكون قادرًا على وصف جهاز USB.

مثال:

```text
USB Device
├── Vendor ID
├── Product ID
├── Interface
├── HID
├── Buttons
├── Axes
├── Triggers
└── Features
```

ثم:

```text
USB
 ↓
UDA
 ↓
UCP Device Model
 ↓
UCP Protocol
```

UDA تعني:

**Universal Device Adapter**

وهي طبقة تحويل الأجهزة الفيزيائية إلى نموذج UCP موحد.

---

# 23. Profiles

كل جهاز أو لعبة يمكن أن يمتلك Profile.

مثال:

```text
PPSSPP
├── Button Mapping
├── Analog Mapping
├── Trigger Mapping
└── Motion Mapping
```

أو:

```text
Windows Mouse
├── Sensitivity
├── Buttons
└── Wheel
```

أو:

```text
Reading
├── Next Page
├── Previous Page
├── Zoom
└── Search
```

---

# 24. Target System

الجهاز المرسل لا يحتاج إلى معرفة تفاصيل الجهاز المستهدف.

مثال:

```text
Phone
 ↓
UCP
 ↓
Windows Adapter
 ↓
Gamepad API
```

أو:

```text
Phone
 ↓
UCP
 ↓
Android TV Adapter
 ↓
Android Input
```

أو:

```text
Phone
 ↓
UCP
 ↓
ESP32 Adapter
 ↓
USB HID
```

---

# 25. Transport Layer

UCP Core لا يجب أن يرتبط بطبقة نقل واحدة.

يجب تعريف:

```text
UCP Transport Interface
```

وتنفيذ عدة Transports:

```text
Wi-Fi
LAN
USB
Bluetooth
USB OTG
ESP32 Bridge
```

البروتوكول نفسه يبقى موحدًا.

---

# 26. Reliability

يجب أن تعرف الرسائل هل تحتاج إلى ضمان وصول أم لا.

مثال:

```text
RELIABLE
UNRELIABLE
ORDERED
UNORDERED
```

مثلاً:

Gamepad axis:

```text
UNRELIABLE / LATEST
```

بينما:

```text
profile.save
```

يحتاج:

```text
RELIABLE
```

---

# 27. Sequence Numbers

رسائل الإدخال المهمة يمكن أن تحتوي:

```text
sequence_number
```

لمنع مشاكل ترتيب الرسائل.

مثال:

```text
100
101
102
103
```

إذا وصل:

```text
100
102
101
```

يستطيع المستقبل معرفة الترتيب.

---

# 28. Timestamp

كل رسالة يجب أن تحتوي على وقت منطقي:

```text
timestamp
```

ويستخدم للتعامل مع:

* تأخير الشبكة.
* Motion.
* Input.
* Game State.
* Synchronization.

---

# 29. Heartbeat

الاتصال المستمر يحتاج إلى Heartbeat.

```text
PING
 ↓
PONG
```

إذا انقطع الاتصال:

```text
CONNECTED
 ↓
TIMEOUT
 ↓
DISCONNECTED
```

ويجب ألا يؤدي انقطاع الشبكة إلى تجميد النظام.

---

# 30. Safety State

في حالة فقدان الاتصال يجب أن يستطيع Receiver تنفيذ:

```text
Fail-Safe
```

مثلاً Gamepad:

```text
Disconnect
 ↓
Release Buttons
 ↓
Reset Axes
 ↓
Stop Input
```

وهذا مهم جدًا حتى لا يبقى زر مضغوطًا بسبب انقطاع الشبكة.

---

# 31. Authentication

يجب أن يحتوي UCP على طبقة Authentication مستقلة عن Transport.

الإصدار الأول يمكن أن يدعم:

```text
Pairing Code
Device Trust
Session Token
Secure Authentication
```

مع إمكانية إضافة تشفير قوي لاحقًا دون تغيير نموذج الرسائل.

---

# 32. Permissions

الجهاز لا يحصل تلقائيًا على كل الصلاحيات.

مثلاً:

```text
Phone
 ↓
Request
 ↓
Windows
 ↓
Permission:
   GAMEPAD
   KEYBOARD
```

ولا يستطيع إرسال:

```text
USB
SYSTEM_CONTROL
```

إلا إذا سمح المستقبل بذلك.

---

# 33. Error System

الأخطاء يجب أن تكون موحدة.

مثال:

```text
UCP_ERR_PROTOCOL_VERSION
UCP_ERR_INVALID_MESSAGE
UCP_ERR_AUTH_FAILED
UCP_ERR_SESSION_NOT_FOUND
UCP_ERR_CAPABILITY_NOT_SUPPORTED
UCP_ERR_PERMISSION_DENIED
UCP_ERR_DEVICE_NOT_FOUND
UCP_ERR_TRANSPORT
UCP_ERR_TIMEOUT
```

---

# 34. Extension System

UCP يجب ألا يتوقف عند v1.0.

يجب السماح برسائل خاصة:

```text
extension.<vendor>.<feature>
```

مثال لشركة تستخدم UCP:

```text
extension.company.game_special
```

ولا يجب أن تكسر هذه الإضافات Core Protocol.

---

# 35. Company / Game SDK

الألعاب والشركات تستطيع استخدام UCP SDK.

مثال:

```text
Game
 ↓
UCP SDK
 ↓
UCP Core
 ↓
Phone
```

يمكن للعبة تعريف أوامر خاصة بها.

مثال:

```text
GAME_SPECIAL_01
GAME_SPECIAL_02
OPEN_MAP
SHOW_INVENTORY
PLAYER_STATUS
```

مع صلاحيات محددة.

---

# 36. Device State

كل جهاز يستطيع الإعلان عن حالته:

```text
online
offline
busy
available
paired
connected
locked
```

ويستطيع تحديث قدراته أثناء Session عند الحاجة.

---

# 37. Configuration

إعدادات UCP يجب ألا تكون مرتبطة بالتطبيق نفسه.

مثال:

```text
UCP Configuration
├── Network
├── Security
├── Device
├── Input
├── Profiles
├── Permissions
└── Plugins
```

---

# 38. Localisation

Core يجب أن يبقى مستقلًا عن اللغة.

الرسائل الداخلية تكون IDs ثابتة:

```text
GAMEPAD
KEYBOARD
MOUSE
READING
```

أما النصوص التي تظهر للمستخدم فتتم ترجمتها في التطبيق.

وبذلك يمكن دعم:

```text
Arabic
English
French
...
```

دون تغيير البروتوكول.

---

# 39. Platform Independence

UCP Core لا يعتمد على:

```text
Windows API
Android API
Flutter UI
Unity
Unreal
```

بل يكون Core مستقلًا.

ثم يتم بناء Adapters:

```text
Android Adapter
Windows Adapter
iOS Adapter
Linux Adapter
macOS Adapter
Android TV Adapter
ESP32 Adapter
Unity Adapter
Unreal Adapter
```

---

# 40. البنية النهائية

```text
                    UCP CORE
                       │
              ┌────────┴────────┐
              │                 │
          Protocol          Device Model
              │                 │
        ┌─────┴─────┐      Capabilities
        │           │
    Messages      Sessions
        │
   ┌────┼────────┬────────┐
   │    │        │        │
Input Feedback Reading Remote
   │
   ▼
Transport Layer
   │
┌──┼────┬──────┬──────┐
│  │    │      │      │
WiFi USB Bluetooth LAN HID
│
▼
Platform / Hardware Adapters
│
├── Windows
├── Android
├── iOS
├── Linux
├── macOS
├── Android TV
├── ESP32
└── Game/Engine SDK
```

# 41. ترتيب التنفيذ

لن ننفذ كل شيء دفعة واحدة.

الترتيب الرسمي:

### المرحلة A — Core Model

```text
Protocol
Device
Capability
Message
```

### المرحلة B — Session

```text
Discovery
Handshake
Session
Heartbeat
Disconnect
```

### المرحلة C — Transport

نبدأ:

```text
Wi-Fi / LAN
```

ثم:

```text
USB
```

ثم:

```text
Bluetooth
```

ثم:

```text
Hardware Bridge
```

### المرحلة D — Input

```text
Gamepad
Analog
DPad
Keyboard
Mouse
Touchpad
Motion
```

### المرحلة E — Windows Receiver

```text
UCP Receiver
↓
Windows Input Adapter
```

### المرحلة F — Android Controller

يستهدف:

```text
Android 5.1+
```

مع مراعاة قيود النظام القديم.

### المرحلة G — Profiles

```text
Game Profiles
Application Profiles
Reading Profiles
Remote Profiles
```

### المرحلة H — USB / HID

```text
USB Device
↓
UDA
↓
UCP
```

### المرحلة I — SDK

```text
Unity
Unreal
Native
```

### المرحلة J — Advanced Systems

```text
Reading Engine
Smart Remote
Game Feedback
Save Hub
ESP32
Advanced Hardware
```

---

# 42. معيار نجاح UCP Core Protocol v1.0

لا نعتبر Core v1.0 مكتملًا لمجرد أن الكود يعمل.

يجب أن يحقق:

* تعريف ثابت للأجهزة.
* تعريف ثابت للقدرات.
* رسائل موحدة.
* Sessions واضحة.
* Discovery.
* Handshake.
* Heartbeat.
* Timeout.
* Fail-Safe.
* Error Codes.
* Versioning.
* Extensibility.
* Transport abstraction.
* Platform independence.
* Unit Tests.
* Protocol Tests.
* Serialization Tests.
* Compatibility Tests.
* Documentation.

والأهم:

**أي تطبيق جديد يجب أن يستطيع استخدام UCP Core بدون معرفة تفاصيل التطبيق الآخر.**

---

# 43. أول مسار رسمي للتنفيذ

بعد اعتماد هذه المواصفة، يكون أول مسار برمجي:

```text
core/
└── lib/
    ├── core.dart
    │
    └── src/
        ├── protocol/
        │   ├── ucp_protocol.dart
        │   ├── ucp_message.dart
        │   ├── ucp_message_type.dart
        │   └── ucp_flags.dart
        │
        ├── device/
        │   ├── ucp_device.dart
        │   ├── ucp_device_type.dart
        │   ├── ucp_capability.dart
        │   └── ucp_device_state.dart
        │
        ├── session/
        │   ├── ucp_session.dart
        │   ├── ucp_session_state.dart
        │   └── ucp_session_manager.dart
        │
        ├── transport/
        │   ├── ucp_transport.dart
        │   └── ucp_transport_state.dart
        │
        ├── messages/
        │   ├── discovery_message.dart
        │   ├── handshake_message.dart
        │   ├── input_message.dart
        │   ├── feedback_message.dart
        │   └── error_message.dart
        │
        └── errors/
            └── ucp_error.dart
```

ثم نبدأ كتابة **الاختبارات أولًا** لكل جزء، وبعدها التنفيذ.

**الهدف الأول القابل للتحقق:**

```text
Android Controller
        ↓
UCP Discovery
        ↓
Windows Receiver
        ↓
Handshake
        ↓
Session
        ↓
Heartbeat
        ↓
Gamepad Input
```

وهذا سيكون أول خط أساس حقيقي لـ **UCP Core Protocol v1.0** قبل إضافة الوظائف الكبيرة الأخرى.
