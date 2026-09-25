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

ويجب أن يتم تصميم UCP من البداية بحيث يمكن إضافة أجهزة وأنظمة تشغيل واستخدامات جديدة مستقبلاً دون تغيير أساس البروتوكول.

