# UCP
Universal Control Platform - Cross-platform controller, receiver, gaming, device control and SDK ecosystem.


# UCP — Universal Control Platform

هدف المشروع هو بناء منصة تحكم موحّدة تجعل الأجهزة المختلفة تعمل كأجهزة تحكم وإدخال واستقبال لبعضها عبر الشبكة، USB، Wi-Fi، وأي وسيلة اتصال مدعومة.

## مثال أساسي للنظام

**هاتف Android 5.1 → Windows 11**

يعمل الهاتف كجهاز Remote/Controller، بينما يعمل Windows 11 كجهاز Receiver.

يمكن للهاتف إرسال:

* أزرار Gamepad.
* عصي Analog.
* D-Pad.
* Keyboard.
* Mouse.
* Touchpad.
* Motion / Gyroscope / Accelerometer.
* أزرار مخصصة.
* اختصارات وأوامر خاصة.
* بيانات الألعاب والحالة عند دعمها.

ويقوم برنامج UCP على Windows 11 باستقبال هذه البيانات وتحويلها إلى إدخال مناسب للنظام أو اللعبة أو البرنامج.

## أنظمة التشغيل والأجهزة المستهدفة

### Mobile / Controller

* Android 5.1 وما بعده.
* Android 9 / 10 / 11 / 12 / 13 / 14 / 15 / 16 وما بعده.
* iPhone / iOS.
* iPad / iPadOS.

### Desktop / Receiver

* Windows 11.
* Windows 10.
* macOS.
* Linux.

### TV / Media Devices

* Android TV.
* Google TV.
* Android TV Box.
* Smart TV عند توفر طريقة اتصال مناسبة.
* أجهزة Media Player المدعومة.

### Gaming

يهدف UCP إلى دعم التحكم في:

* ألعاب الكمبيوتر.
* ألعاب Android.
* ألعاب Android TV.
* المحاكيات مثل PPSSPP وRetroArch وغيرها.
* الألعاب المبنية باستخدام Unity.
* الألعاب المبنية باستخدام Unreal Engine.
* الألعاب التي تستخدم SDK خاص بـ UCP.
* ألعاب وبرامج يمكن التحكم بها من خلال Keyboard / Mouse / Gamepad أو واجهات إدخال مدعومة.

## أنواع الاستخدام

### 1. Remote Control

مثال:

**Android 5.1 → Windows 11**

الهاتف يعمل كجهاز تحكم عن بعد للكمبيوتر.

### 2. Game Controller

الهاتف يتحول إلى:

* Gamepad.
* Joystick.
* Steering Controller.
* Touch Controller.
* Motion Controller.

### 3. Keyboard / Mouse

الهاتف يمكن أن يعمل كـ:

* Wireless Keyboard.
* Wireless Mouse.
* Touchpad.
* Macro Pad.

### 4. Smart TV Remote

الهاتف يتحول إلى جهاز تحكم للتلفزيون أو Android TV أو TV Box، حسب البروتوكول وطريقة الاتصال المتاحة.

### 5. Drawing / Pen Controller

يمكن استخدام شاشة الهاتف كلوحة تحكم للرسم، مع دعم اللمس والحركة والضغط المحاكى والاختصارات، حسب قدرات الجهاز والبرنامج المستقبل.

### 6. Game Feedback

لا يقتصر UCP على إرسال الأوامر فقط.

يمكن للنظام مستقبلاً استقبال بيانات من اللعبة أو البرنامج وإظهارها على الهاتف، مثل:

* Health.
* Ammo.
* Score.
* Player State.
* Map.
* Missions.
* Inventory.
* Game Status.
* Notifications.

### 7. Hardware Bridge

دعم أجهزة وسيطة مثل:

* ESP32.
* Arduino.
* USB Adapters.
* Sensors.
* Custom Controllers.
* أجهزة UCP Hardware مستقبلية.

بحيث يمكن تحويل بيانات الأجهزة والحساسات إلى أوامر UCP وإرسالها إلى الكمبيوتر أو التلفزيون أو اللعبة.

## نظام الاتصال

يجب أن يكون هناك بروتوكول UCP موحّد بين:

**Controller → UCP Protocol → Receiver → Target**

ويمكن أن يكون الاتصال عبر:

* Wi-Fi.
* LAN.
* USB.
* Bluetooth عند الحاجة والدعم.
* بروتوكولات الأجهزة الخاصة.
* Hardware Bridges.

ويجب أن يكون النظام قابلاً للتوسعة بحيث يمكن إضافة جهاز أو نظام تشغيل أو لعبة جديدة بدون إعادة بناء المنصة بالكامل.

## الهدف النهائي

UCP ليس مجرد تطبيق Remote واحد.

الهدف هو بناء **منصة تحكم متعددة الأجهزة والأنظمة** يستطيع فيها المستخدم اختيار الجهاز الذي سيرسل منه التحكم، والجهاز الذي سيستقبل التحكم، ونوع التحكم المطلوب، والبرنامج أو اللعبة المستهدفة.

مثال:

**Android 5.1 Phone**
→ Wi-Fi
→ **UCP Receiver on Windows 11**
→ Gamepad / Keyboard / Mouse
→ **Game / Emulator / Application**

ومثال آخر:

**Android Phone**
→ Wi-Fi
→ **Android TV 9**
→ Game Controller
→ **PPSSPP**

ومثال آخر:

**iPhone**
→ Wi-Fi
→ **Windows 11**
→ Mouse / Keyboard / Gamepad

ومثال آخر:

**Phone**
→ Wi-Fi
→ **ESP32 UCP Bridge**
→ USB / Hardware
→ **Computer / Game / Device**

## 8. Reading Control Mode — وضع التحكم بالقراءة

يدعم UCP وضعًا خاصًا للتحكم بجهاز آخر أثناء قراءة وتشغيل الكتب والمستندات والمحتوى التعليمي.

مثال:

**Android 5.1 Phone**
→ Wi-Fi
→ **UCP Receiver على Windows 11**
→ **UCP Reading Engine**
→ الكتاب / المستند

أو:

**Phone**
→ Wi-Fi
→ **Android TV / Tablet / PC**
→ **Reading Engine**
→ الكتاب

### وظائف وضع القراءة

يمكن للهاتف التحكم في:

* فتح كتاب.
* إغلاق الكتاب.
* الصفحة التالية.
* الصفحة السابقة.
* الانتقال إلى صفحة محددة.
* البحث داخل الكتاب.
* تكبير وتصغير الصفحة.
* تغيير اتجاه العرض.
* تغيير حجم الخط.
* تغيير نوع الخط.
* تغيير لون الخلفية.
* الوضع الليلي.
* التمرير.
* الانتقال إلى فصل محدد.
* الفهرس.
* العلامات المرجعية.
* حفظ مكان القراءة.
* استكمال القراءة من آخر موضع.
* تشغيل وإيقاف المحتوى الصوتي عند توفره.
* التحكم بسرعة القراءة الصوتية.
* التحكم في الكتب التعليمية التفاعلية.

## UCP Reading Engine

يكون محرك القراءة جزءًا مستقلًا من UCP، بحيث لا يعتمد النظام على نوع واحد من الكتب.

الهدف أن يدعم المحرك أنواعًا متعددة من المحتوى، مثل:

* PDF.
* EPUB.
* TXT.
* HTML.
* كتب مصورة.
* كتب تعليمية تفاعلية.
* مستندات.
* كتب رقمية خاصة.
* صيغ كتب مستقبلية يضيفها المطورون.
* صيغ خاصة يتم تعريفها بواسطة UCP.

ويتم تصميم **Reading Engine API** بحيث يمكن إضافة صيغة جديدة دون تغيير نظام التحكم الأساسي.

## التحكم بجهاز آخر

يمكن أن يعمل جهاز UCP كجهاز تحكم لجهاز آخر أثناء القراءة.

مثال:

**Android 5.1**
→ يتحول إلى Reading Remote

ويتحكم في:

**Windows 11**
→ الكتاب مفتوح على الشاشة

ويستطيع المستخدم من الهاتف تنفيذ:

**Next Page / Previous Page / Zoom / Search / Chapters / Bookmark / Reading Position**

كما يمكن عكس الفكرة:

**Windows 11**
→ يتحكم في قارئ الكتب على Android.

## الكتب الخاصة

يدعم UCP نظامًا للكتب الخاصة يمكن من خلاله تعريف:

* صيغة كتاب خاصة.
* Metadata خاصة.
* فهرس خاص.
* صفحات أو مشاهد خاصة.
* عناصر تفاعلية.
* ملفات صوتية مرتبطة بالكتاب.
* فيديوهات مرتبطة بالمحتوى.
* اختبارات وتمارين.
* روابط داخلية.
* بيانات تعليمية إضافية.

ويكون لكل نوع محتوى **Reader Plugin / Engine Adapter** خاص به.

## وضع القراءة عن بعد

يجب فصل:

**Reading Engine**

عن:

**UCP Controller**

بحيث يمكن تشغيل محرك القراءة على جهاز، والتحكم به من جهاز آخر.

مثال:

**Phone**
→ UCP Controller
→ Wi-Fi
→ UCP Receiver
→ Reading Engine
→ Book

وبذلك لا يحتاج الهاتف بالضرورة إلى تشغيل الكتاب نفسه؛ يمكن أن يكون مجرد جهاز تحكم.

## المحرك الموحد

يُفضّل أن يكون النظام:

**UCP Core**
→ **UCP Protocol**
→ **Device Receiver**
→ **Reading Engine**
→ **Book Format Engine**

بحيث يمكن لاحقًا إضافة محركات أخرى بجانب محرك القراءة، مثل:

* Game Engine Adapter.
* Video Engine.
* Audio Engine.
* Education Engine.
* Document Engine.
* 3D/Model Viewer.
* Presentation Engine.

وبذلك يصبح UCP منصة للتحكم والتشغيل وليس مجرد برنامجRemote.


ويجب أن يتم تصميم UCP من البداية بحيث يمكن إضافة أجهزة وأنظمة تشغيل واستخدامات جديدة مستقبلاً دون تغيير أس
اس البروتوكول.



# UCP — Universal USB & Device Support

## دعم الأجهزة التي لا تدعم Bluetooth

يجب أن يدعم UCP الأجهزة التي لا تحتوي على Bluetooth أو التي لا يمكن التحكم بها لاسلكيًا مباشرة.

يتم ذلك باستخدام:

* USB.
* USB OTG.
* USB Host.
* USB HID.
* UCP USB Adapter.
* ESP32/Hardware Bridge.
* أجهزة تحويل مستقبلية خاصة بـ UCP.

مثال:

**USB Gamepad**
→ USB
→ **UCP Receiver / Adapter**
→ Wi-Fi
→ **Phone / PC / TV**

## دعم أجهزة الألعاب

يهدف UCP إلى دعم أكبر عدد ممكن من أجهزة التحكم، حسب البروتوكول الذي يوفره الجهاز ونظام التشغيل.

أمثلة:

* PlayStation 4 Controllers.
* PlayStation Controllers الأصلية.
* PlayStation Controllers غير الأصلية.
* USB Gamepads.
* Generic HID Controllers.
* Joysticks.
* Arcade Controllers.
* Steering Wheels.
* Flight Controllers.
* Pedals.
* Fight Sticks.
* أجهزة تحكم مخصصة.

ولا يشترط أن يكون الجهاز Bluetooth حتى يستطيع UCP استخدامه.

## تحويل USB إلى UCP

يمكن استخدام UCP كطبقة تحويل:

**USB Device**
→ **UCP USB Adapter**
→ **UCP Protocol**
→ **Target Device**

مثال:

**PS4 Controller**
→ USB
→ UCP
→ Wi-Fi
→ Android Phone

أو:

**PS4 Controller**
→ USB
→ UCP
→ Windows 11

أو:

**USB Gamepad**
→ USB
→ UCP
→ Android TV

## دعم الهاتف

يمكن للهاتف أن يكون:

### Controller

**Phone → Wi-Fi → PC / TV / Phone**

### Receiver

**USB Controller → Phone**

### Bridge

**USB Device → Phone → Wi-Fi → Computer / TV**

### Remote

**Phone → Wi-Fi → Smart TV / Android TV / PC**

## دعم الكمبيوتر

يمكن للكمبيوتر أن يعمل كـ:

* UCP Receiver.
* UCP Controller.
* USB Device Bridge.
* Gamepad Receiver.
* Keyboard/Mouse Receiver.
* Smart Device Gateway.
* Reading Engine Host.
* Game Engine Host.

مثال:

**USB Gamepad**
→ Windows 11
→ UCP Receiver
→ Game / Emulator

## دعم التلفزيون

يجب تصميم UCP لدعم:

* Android TV.
* Google TV.
* Android TV Box.
* Smart TV المدعوم.
* Media Players المدعومة.

مثال:

**USB Gamepad**
→ Android TV
→ UCP
→ Game / Emulator

أو:

**Phone**
→ Wi-Fi
→ Android TV
→ UCP Receiver
→ Game Controller

## Universal Device Adapter

يجب أن يحتوي UCP على طبقة تسمى:

**Universal Device Adapter — UDA**

وظيفتها اكتشاف الجهاز وتحويله إلى نموذج UCP موحد.

```text
Physical Device
      ↓
USB / Bluetooth / Wi-Fi / OTG / HID
      ↓
Universal Device Adapter
      ↓
UCP Protocol
      ↓
Target Device
```

وبذلك لا يحتاج كل برنامج إلى معرفة تفاصيل كل جهاز.

## التعرف على الجهاز

عند توصيل جهاز جديد، يحاول UCP اكتشاف:

* Vendor ID.
* Product ID.
* Device Type.
* HID Reports.
* Buttons.
* Axes.
* Triggers.
* D-Pad.
* Sensors.
* Vibration.
* LEDs.
* Battery Status عند توفرها.

ثم ينشئ UCP Device Profile مناسبًا للجهاز.

## الأجهزة الأصلية وغير الأصلية

يجب ألا يعتمد UCP على اسم الشركة فقط.

إذا كان الجهاز متوافقًا مع معيار USB HID أو يوفر بروتوكولًا يمكن الوصول إليه، يستطيع UCP التعامل معه حتى لو كان:

* أصليًا.
* تجاريًا.
* Generic.
* Compatible.
* Controller مخصصًا.

ويتم تحديد القدرات الفعلية للجهاز من خلال الـ Device Profile.

## الهدف

الهدف هو أن يكون UCP قادرًا على الربط بين:

**Gamepad**
**Phone**
**Computer**
**TV**
**Android TV**
**Smart TV**
**ESP32**
**USB Devices**
**Games**
**Emulators**
**Applications**

من خلال طبقة UCP موحدة.

مثال كامل:

**PS4 Controller**
→ USB
→ **UCP Universal Device Adapter**
→ Wi-Fi
→ **Android Phone**
→ UCP Controller/Receiver
→ **Windows 11**
→ Game / Emulator

ومثال آخر:

**USB Gamepad**
→ **Android TV**
→ UCP
→ **PPSSPP**

ومثال آخر:

**Phone**
→ Wi-Fi
→ **UCP Receiver**
→ Smart TV / Android TV
→ Remote / Gamepad / Keyboard / Mouse

## مبدأ مهم

UCP لا يفترض أن كل جهاز يدعم Bluetooth.

**Bluetooth خيار اتصال فقط، وليس شرطًا لعمل UCP.**

الاتصالات الممكنة تشمل:

**USB + USB OTG + HID + Wi-Fi + LAN + Bluetooth + Hardware Bridge**

مع إضافة طرق اتصال جديدة مستقبلًا دون تغيير أساس بروتوكول UCP.
