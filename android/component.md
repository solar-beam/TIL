# Android Fundamentals

> 다음 페이지와 관련사항을 발췌/요약한 것입니다 > [안드로이드 개발자문서 : 애플리케이션 기본 항목](https://developer.android.com/guide/components/fundamentals#DeclaringComponents)



안드로이드 앱은 Kotlin, Java, C/C++로 작성할 수 있으며, 컴파일한 코드와 함께 모든 데이터 및 리소스 파일을 합쳐 APK를 만듭니다.

- [Kotlin](https://developer.android.com/kotlin/get-started?hl=ko) : 코드가 간결하고 null safety를 보장하며 java와 100% 호환됩니다.
- [C/C++](https://developer.android.com/studio/projects/add-native-code?hl=ko) : 기기의 성능을 최대한 활용하는 게임/물리학 시뮬레이션 등 컴퓨팅 집약적인 작업에 활용할 수 있습니다. 아울러 C/C++ 라이브러리를 재사용할 수 있습니다.



안드로이드 앱은 각기 다른 보안 샌드박스에서 보호됩니다. 

- 안드로이드는 멀티유저 리눅스 시스템으로, 각 앱은 각기 다른 사용자와 같습니다. 앱은 고유한 리눅스ID를 가지며(시스템에서만 사용하며 앱에서는 인식하지 못함), 해당 앱에 할당된 ID로만 앱에 접근할 수 있습니다. 모든 앱은 앱 자체의 리눅스 프로세스에서 실행되며, 고유한 수명주기를 가집니다. 또한 각 프로세스는 자체적인 가상머신이 있고, 한 앱의 코드가 다른 앱과 격리된 상태로 실행됩니다. 
- 다만 개발자는 같은 인증서로 앱을 서명함으로써, 서로 다른 앱이 데이터를 공유하고 시스템 서비스에 접근하도록 할 수 있습니다. 아울러 연락처, SMS메시지 등 시스템 권한을 사용하기 위해서는 개발단계에서 명시적으로 권한을 요구하고, 사용자가 이를 명시적으로 허용해야 합니다

> NOTE : 안드로이드 가상머신 관련 세부내용은 다음 링크를 참조 [android.jlelse.eu](https://android.jlelse.eu/virtual-machine-in-android-everything-you-need-to-know-9ec695f7313b). 안드로이드는 JVM 대신 모바일 환경에 최적화된 Dalvik 가상머신을 사용했음. JIT(just-in-time)방식으로 컴파일된 코드를 실행시점에 기계어로 번역했으나 배터리/RAM 이슈가 있었음. ART는(android-run-time) AOT(at-on-time) 방식으로 설치시점에 기계어로 번역해두는 방식. 다만 AOT방식은 설치공간/속도 이슈가 있음. 안드로이드 7.0 이후로는 최초 설치시 JIT으로 설치 속도를 높이고, 차후 기기를 사용하지 않을때나 충전중에 컴파일하여 자주 사용되는 앱을 AOT방식으로 전환하고 있다. 일부 Dalvik/ART 호환성 문제 및 ART 자체의 성능검증 이슈가 있다.




이하 문서에서는 다음 개념을 개괄합니다.

- 앱 구성요소(component) : 앱을 정의하는 핵심 프레임워크 구성요소
- 매니페스트 파일(manifest) : 앱 구성요소와 필요한 디바이스 기능을 선언함
- 앱 리소스(res) : 앱 코드에서 분리된 리소스로, 다양한 기기 구성에 맞게 앱을 최적화할 수 있음




## Component

안드로이드 앱의 필수적인 구성요소에는 다음 네 가지 유형이 있습니다.

- Activity
- Service
- Broadcast Receiver
- Contents Provider

각 구성요소는 시스템이나 사용자가 앱과 상호작용하는 진입점입니다. 각 유형마다 각기 다른 뚜렷한 목적을 수행하며, 나름의 생성과 소멸 방식을 정의하는 수명주기(생애주기)를 가집니다.



### Activity

액티비티는 **앱 화면 하나하나**를 나타냅니다. 사용자 인터페이스를 담당하며, 사용자가 앱과 상호작용하는 진입점입니다. 예를 들어 이메일 앱이라면 새 이메일 목록을 표시하는 액티비티가 하나 있고, 이메일을 작성하는 액티비티가 또 하나, 그리고 이메일을 읽는 데 쓰는 액티비티가 또 하나 있을 수 있습니다. 여러 액티비티가 함께 작동하여 해당 이메일 앱에서 짜임새 있는 사용자 환경을 구성하는 것은 사실이지만, 각자 서로 독립되어 있습니다. 다른 앱이 이메일 앱의 허락을 받아 이런 액티비티 중 하나를 시작할 수도 있습니다. 이를테면 갤러리 앱에서 이메일 앱 안의 액티비티를 시작하여 사용자가 새 이메일을 작성하고 사진을 공유할 수 있습니다. 정리하면 액티비티는 다음과 같이 시스템과 앱의 주요 상호작용을 돕습니다.

- 실행 : 화면에 나오는 것, 사용자가 주시하는 것이 무엇인지 추적하고 시스템 프로세스가 액티비티를 계속 실행하도록 합니다.
- 유지 : 이미 중단된 액티비티 중 사용자가 다시 찾을만한 것을 알아두고, 그런 프로세스를 유지하는 데 우선순위를 둡니다.
- 종료 : 앱 프로세스를 종료하여 액티비티 실행 이전의 상태를 복원합니다.

- 앱간 상호작용 : 앱은 자신을 다른 앱에 개방하여 사용자가 앱을 오가며 필요한 것을 추려쓸 수 있도록 할 수 있는데, 가장 기본적인 예는 '공유하기' 기능입니다.

액티비티 하나를 `Activity` 클래스의 하위 클래스로 구현합니다. `Activity` 클래스에 대한 자세한 내용은 [Activities](https://developer.android.com/guide/components/activities) 개발자 가이드를 참조하세요.



### Service

서비스는 앱의 **백그라운드 작업을 위한 진입점**으로, 사용자 인터페이스는 제공하지 않습니다. 원격통신과 같이 백그라운드에서 오래 지속되는 작업을 구동하기 위한 구성요소입니다. 예를 들어, 사용자가 다른 앱을 사용하는 동안 백그라운드에서 음악을 재생한다거나, 사용자가 액티비티와 상호작용하는 것을 방해하지 않고 네트워크를 통해 데이터를 받아오는 일 등을 할 수 있습니다. 서비스는 기능에 따라 두 가지로 나눌 수 있습니다.

- 데이터 동기화류, 사용자가 의식하지 못하는 영역에서 작업하므로, 중단돼도 사용자가 불편해지지 않는다.
- 음악 재생류, 중단되면 사용자가 큰 불편을 느낀다.

또한, 다른 구성요소, 이를테면 액티비티가 서비스를 시작하거나 자신과 바인딩할 수 있습니다. 다시 말하면 서비스가 다른 구성요소에 API를 제공하는 것입니다. 이에 따라 시스템은 **바인딩된 구성요소간 종속관계**를 알고 있어야 하고, 이를테면 A가 실행되는 동안에는 종속된 서비스인 B를 계속 실행토록 해야합니다. 이런 특성을 이용하여, 라이브 배경화면, 알림 관리, 화면 보호기, 입력 메소드, 접근성 기능 등 주요한 시스템 기능이 서비스를 활용하여 구현되어 있습니다.

서비스는 `Service`의 하위 클래스이며, 자세한 내용은 [Services](https://developer.android.com/guide/components/services) 개발자 가이드를 참조.

> NOTE : Android 5.0(API LEVEl 21) 이상인 경우 `JobScheduler` 클래스와 [Doze](https://developer.android.com/training/monitoring-device-state/doze-standby) API를 사용해 배터리 효율을 높일 수 있다. 세부내용은 `JobScheduler` 레퍼런스 문서를 참조. 



### Broadcast Receiver

브로드캐스트 리시버로 **기기의 시스템 브로드캐스트 알림**을 받고, 답할 수 있습니다. 브로드캐스트 리시버도 앱의 진입점이므로, 현재 실행되고 있는 앱이 아니더라도 브로드캐스트 이벤트를 전달할 수 있습니다. 화면이 꺼지거나, 배터리 잔량이 낮거나, 사진이 촬영되는 등 기기에서 보내는 브로드캐스트 종류가 하나 있고. 데이터가 다운로드 됐다는 등 앱에서 보내는 브로드캐스트가 있습니다. 브로드캐스트 리시버는 사용자 인터페이스를 제공하지는 않지만, 이러한 이벤트가 발생했을 때 상태표시줄에 [알림](https://developer.android.com/guide/topics/ui/notifiers/notifications)을 띄워 사용자에게 알려줄 수 있습니다. 보통은 브로드캐스트 리시버는 다른 구성요소, 이를테면 서비스의 진입점(gateway) 역할을 수행합니다. 

브로드캐스트 리시버는 `BroadcastReceiver`의 하위클래스이며 각 브로드캐스트는 `Intent` 객체로서 전달됩니다. 자세한 내용은 `BroadcastReceiver` 클래스를 참조.



### Contents Provider

콘텐츠 제공자는 파일시스템, SQLite데이터베이스, 웹, 또는 앱이 접근권한을 가진 지속(↔단기) 저장영역의 앱 데이터를 관리하는 역할입니다. 이를테면 콘텐츠 제공자를 통해 사용자 연락처 정보를 `ContactsContract.Data`와 같은 쿼리문으로 읽고 쓸 수 있습니다. 데이터베이스의 추상화된 API로 보일 수도 있고, 일반적으로 그렇게 사용되기도 하지만 시스템 설계의 관점이 다릅니다.

콘텐츠 제공자는 앱의 진입점으로서, 데이터에 URI 이름을 지정합니다. 이를 통해 앱이 데이터를 URI에 매핑하는 방법을 정하면, 다른 앱에서도 진입점을 통해 전달받은 URI로 데이터에 접근할 수 있습니다. URI는 앱이 종료된 이후에도 유지되며, 앱은 데이터를 읽어들일 때만 실행하면 됩니다. 또한, 콘텐츠 제공자는 다른 앱에 대하여 URI권한을 임시로 부여하고, 그 외에는 다른 앱에서 데이터에 접근하지 못하도록 막는 보안기능도 있습니다.

콘텐츠 제공자는 `ContentProvider`의 하위클래스이고 다른 앱과 상호작용하기 위한 표준API를 구현해야 합니다. 자세한 내용은 [Content Providers](https://developer.android.com/guide/topics/providers/content-providers) 개발자 가이드를 참조.



### Activating components

안드로이드 시스템 디자인의 특별한 점은 앱이 다른 앱의 구성요소를 호출할 수 있다는 점입니다. 예를 들어 앱에서 사진촬영 기능이 필요해도 그 기능을 직접 개발하지 않아도 됩니다. 다른 앱에서 빌려올 수 있습니다. 다만, 이때 호출된 카메라 기능 프로세스는 호출한 앱의 프로세스가 아니라 카메라 기능 구성요소가 속한 앱의 프로세스 위에서 실행됩니다. 안드로이드 시스템은 각 앱이 별도의 프로세스에서 실행되며 다른 앱의 접근권한을 제한할 수 있습니다. 또한 단일한 진입지점(이를테면 `main()`)이 없고 구성요소 각각이 사용자와 시스템을 위한 진입점으로서 기능함으로써, 앱 보안이 강화되고 앱 개발은 유연해집니다.

앱은 서로의 구성요소를 호출할 수 있지만, 앱이 직접 호출하는 것은 아닙니다. 안드로이드 시스템이 그 역할을 맡습니다. 앱은 `Intent`라는 메시지를 통해, 원하는 구성요소를(액티비티, 서비스, 브로드캐스트) 특정합니다. 이를 받아 시스템에서 구성요소를 활성화합니다. 인텐트는 `Intent` 객체로 명시적으로 구성요소를 특정하는 경우와, 구성요소의 종류만 정하는 암시적인 종류로 나뉩니다. 콘텐츠 제공자는 인텐트로 활성화되지 않습니다. 대신 `ContentResolver`라는 요청으로 활성화됩니다. 콘텐츠제공자를 직접 호출할 필요가 없고 대신 `ContentResolver` 객체 메소드를 호출하면 됩니다.

- Activity/Service `Intent`, '역할'을 정의한다. 이를테면 '보내기'나 '읽기' 등.
- BroadcastReceiver `Intent`, '브로드캐스트 알림'을 정의한다. 이를테면 '배터리 부족' 등.

- ContentsProvider는 `ContentResolver` 메소드로 호출

자세한 내용은 [Intents and Intent Filters](https://developer.android.com/guide/components/intents-filters)를 참조.

- Activity : `startActivity()`나 `startActivityForResult()`(결과를 돌려받을 때)로 `Intent`를 전달
- Service : Android5.0 이상에서는 `JobScheduler` 사용, 이전 버전에서는 `startService()`로 `Intent`전달. 바인딩은 `bindService()`로 전달. 
- BroadcastReceiver : `sendBroadcast()`, `sendOrderedBroadcast()`, or `sendStickyBroadcast()`로 전달
- ContentsProvider : `ContentResolver`의 `query()` 메소드 호출



## 매니페스트 파일

안드로이드 시스템이 앱 구성요소를 시작하기 전에, 어떤 구성요소가 있는지 시스템이 먼저 알아야 합니다. 프로젝트 루트 디렉토리에 `AndroidManifest.xml`라는 매니페스트 파일을 만들고, 그 안에 구성요소를 선언해줍니다. 그외에도 다음과 같은 사항를 기재합니다.

- 인터넷 접속, 연락처 정보 등 앱이 요구하는 권한
- 최소 API LEVEL
- 앱이 요구하는 하드웨어/소프트웨어 기능, 이를테면 카메라/블루투스/멀티터치 스크린 등
- 앱에 링크할 API 라이브러리



### Declaring components

매니페스트의 주요 작업은 시스템에 앱의 구성 요소에 대해 알리는 것입니다. 예를 들어 매니페스트 파일은 액티비티를 다음과 같이 선언할 수 있습니다.

```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest ... >
    <application android:icon="@drawable/app_icon.png" ... >
        <activity android:name="com.example.project.ExampleActivity"
                  android:label="@string/example_label" ... >
        </activity>
        ...
    </application>
</manifest>
```

`<application>` 요소에서 `android:icon` 특성은 앱을 식별하는 아이콘에 대한 리소스를 가리킵니다.

`<activity>` 요소에서는 `android:name` 특성이 `Activity` 하위 클래스의 완전히 정규화된 클래스 이름을 나타내며 `android:label` 특성은 액티비티의 사용자에게 표시되는 레이블로 사용할 문자열을 나타냅니다.

다음 요소를 사용하여 모든 앱 구성 요소를 선언해야 합니다.

- 액티비티의 경우 `<activity>` 요소
- 서비스의 경우 `<service>` 요소
- Broadcast Receiver의 경우 `<receiver>` 요소
- 콘텐츠 제공자의 경우 `<provider>` 요소

소스에는 포함시키지만 매니페스트에서는 선언하지 않는 액티비티, 서비스, 콘텐츠 제공자는 시스템에 표시되지 않으며, 따라서 실행될 수 없습니다. 그러나 Broadcast Receiver는 매니페스트에서 선언해도 되고 코드를 사용해 (`BroadcastReceiver` 객체로) 동적으로 생성한 다음 시스템에 등록해도 됩니다. 이때 `registerReceiver()`를 호출하는 방법을 사용합니다.

앱에 맞는 매니페스트 파일을 구성하는 방법에 대한 자세한 내용은 [AndroidManifest.xml 파일](https://developer.android.com/guide/topics/manifest/manifest-intro)을 참조하세요.



### 구성 요소 기능 선언

위에서 설명한 바와 같이, [활성화 상태의 구성 요소](https://developer.android.com/guide/components/fundamentals#ActivatingComponents)에서는 `Intent`를 사용하여 액티비티, 서비스 및 Broadcast Receiver를 시작할 수 있습니다. 그렇게 하려면 `Intent`를 사용하여 대상 구성 요소를 인텐트 내에서 명시적으로 명명하면 됩니다(구성 요소 클래스 이름을 사용). 또한 암시적 인텐트를 사용할 수도 있습니다. 암시적 인텐트는 수행할 작업의 유형을 설명하고, 원한다면 작업을 수행할 대상인 데이터를 설명할 수도 있습니다. 암시적 인텐트를 사용하면 시스템이 작업을 수행할 수 있는 기기에서 구성 요소를 찾아서 작업을 시작할 수 있습니다. 인텐트가 설명한 작업을 수행할 수 있는 구성 요소가 여러 개인 경우, 어느 것을 사용할지는 사용자가 선택합니다.

> **주의:** 인텐트를 사용하여 `Service`에 바인딩할 경우에는 [명시적](https://developer.android.com/guide/components/intents-filters#Types) 인텐트를 사용하여 앱을 보호하세요. 암시적 인텐트를 사용하여 서비스를 시작하면 보안 위험을 초래합니다. 인텐트에 어느 서비스가 응답할 것인지 확신할 수 없고, 사용자는 어느 서비스가 시작되는지 볼 수 없기 때문입니다. Android 5.0(API 레벨 21)부터 시스템은 개발자가 암시적 인텐트로 `bindService()`를 호출하면 예외를 발생시킵니다. 서비스에 대해 인텐트 필터를 선언하지 마세요.

시스템은 기기에 설치된 다른 앱의 매니페스트 파일에 제공된 *인텐트 필터*와 수신된 인텐트를 비교하는 방법으로 인텐트에 응답할 수 있는 구성 요소를 식별합니다.

앱의 매니페스트에서 액티비티를 선언하는 경우, 선택적으로 해당 액티비티의 기능을 선언하는 인텐트 필터를 포함시켜서 다른 앱으로부터의 인텐트에 응답하게 할 수 있습니다. [``](https://developer.android.com/guide/topics/manifest/intent-filter-element) 요소를 해당 구성 요소의 선언 요소에 대한 하위 요소로 추가하면 구성 요소에 대한 인텐트 필터를 선언할 수 있습니다.

예를 들어 새 이메일을 작성하는 액티비티가 포함된 이메일 앱을 빌드한다고 가정해보겠습니다. 이때 (새 이메일을 전송하기 위해) "send" 인텐트에 응답하는 인텐트 필터를 선언하려면 다음과 같이 하면 됩니다.

```xml
<manifest ... >  ...  
<application ... >    
	<activity android:name="com.example.project.ComposeEmailActivity">      
		<intent-filter>        
			<action android:name="android.intent.action.SEND" />        
				<data android:type="*/*" />        
			<category android:name="android.intent.category.DEFAULT" />      
		</intent-filter>    
	</activity>  
</application>
</manifest>
```

다른 앱이 `ACTION_SEND` 작업이 포함된 인텐트를 생성하고 이를 `startActivity()`로 전달하면 사용자가 이메일 초안을 작성하고 이를 전송할 수 있는 액티비티를 시작할 수 있습니다.

인텐트 필터 생성에 관한 자세한 내용은 [인텐트 및 인텐트 필터](https://developer.android.com/guide/components/intents-filters) 문서를 참조하세요.



### 앱 요구사항 선언

Android로 구동되는 기기는 수없이 많지만 모두 특징이 같고, 똑같은 기능을 제공하는 것은 아닙니다. 앱에 필요한 기능이 없는 기기에 앱을 설치하는 불상사를 방지하려면, 앱이 지원하는 기기 유형에 대한 프로필을 명확하게 정의하는 것이 중요합니다. 그러려면 매니페스트 파일에 기기와 소프트웨어 요구사항을 선언하면 됩니다. 이와 같은 선언은 대부분 정보성일 뿐이며 시스템은 이를 읽지 않는 것이 일반적이지만, Google Play와 같은 외부 서비스는 사용자가 본인의 기기에서 앱을 검색할 때 필터링을 제공하기 위해 이와 같은 선언도 읽습니다.

예를 들어 앱에 카메라가 필요하고 Android 2.1([API 레벨](https://developer.android.com/guide/topics/manifest/uses-sdk-element#ApiLevels) 7)에 도입된 API를 사용하는 경우, 이와 같은 내용을 매니페스트 파일에 요구사항으로 선언하려면 다음과 같이 합니다.

```xml
<manifest ... >  
    <uses-feature android:name="android.hardware.camera.any" android:required="true" />
    <uses-sdk android:minSdkVersion="7" android:targetSdkVersion="19" />  ...
</manifest>
```

예시에서 보여준 선언을 한 다음에는, 카메라가 *없고* Android 버전이 2.1 *이하*인 기기는 Google Play에서 앱을 설치할 수 없습니다. 그러나 앱이 카메라를 사용하기는 하지만 *필수*는 아니라고 선언할 수도 있습니다. 이 경우에는 앱이 [`required`](https://developer.android.com/guide/topics/manifest/uses-feature-element#required) 특성을 `false`에 설정하고 런타임에 확인하여 해당 기기에 카메라가 있는지, 경우에 따라서는 모든 카메라 기능을 비활성화할 수 있는지 알아봅니다.

여러 가지 기기와 앱의 호환성을 관리하는 방법에 대한 자세한 내용은 [기기 호환성](https://developer.android.com/guide/practices/compatibility) 문서를 참조하세요.



## 앱 리소스

Android 앱은 코드만으로 이루어지지 않습니다. 소스 코드와 별도로 이미지, 오디오 파일, 그리고 앱의 시각적 표현과 관련된 것 등의 여러 리소스가 필요합니다. 예를 들어 액티비티 사용자 인터페이스의 애니메이션, 메뉴, 스타일, 색상, 레이아웃을 XML 파일로 정의해야 합니다. 앱 리소스를 사용하면 코드를 수정하지 않고 앱의 다양한 특성을 쉽게 업데이트할 수 있습니다. 일련의 대체 리소스를 제공함으로써 다양한 기기 구성에 맞게 앱을 최적화할 수도 있습니다(예: 여러 가지 언어 및 화면 크기).

Android 프로젝트에 포함하는 리소스마다 SDK 빌드 도구가 고유한 정수 ID를 정의하므로, 이를 사용하여 앱 코드에서의 리소스나 XML로 정의된 다른 리소스에서 참조할 수 있습니다. 예를 들어 앱에 `logo.png`라는 이름의 이미지 파일이 들어 있다면(`res/drawable/` 디렉토리에 저장), SDK 도구가 `R.drawable.logo`라는 리소스 ID를 생성합니다. 이것을 사용하여 이미지를 참조하고 사용자 인터페이스에 삽입할 수 있습니다. 이 ID는 각 앱의 정수로 매핑되며, 이것을 사용하여 이미지를 참조할 수도 있고 이것을 사용자 인터페이스에 삽입할 수도 있습니다.

소스 코드와는 별개로 리소스를 제공하는 것의 가장 중요한 측면 중 하나는 여러 가지 기기 구성에 맞게 대체 리소스를 제공할 능력을 갖추게 된다는 점입니다. 예를 들어 UI 문자열을 XML로 정의하면 이러한 문자열을 다른 언어로 번역한 뒤 해당 문자열을 별개의 파일에 저장할 수 있습니다. 그러면 Android가 리소스 디렉토리 이름에 추가하는 언어 *한정자*(예를 들어 프랑스어 문자열 값의 경우 `res/values-fr/`) 및 사용자의 언어 설정을 기반으로 적절한 언어 문자열을 UI에 적용합니다.

Android는 대체 리소스에 대해 다양한 *한정자*를 지원합니다. 한정자란 리소스 디렉토리의 이름에 포함하는 짧은 문자열로, 이를 사용해 해당 리소스를 사용할 기기 구성을 정의합니다. 예를 들어 기기의 화면 방향과 크기에 따라 액티비티에 여러 가지 레이아웃을 생성해야 할 때가 많습니다. 기기 화면이 세로 방향(세로로 긺)인 경우 버튼이 세로 방향으로 되어 있는 레이아웃을 사용하는 것이 좋지만, 화면이 가로 방향(가로로 넓음)인 경우 버튼이 가로 방향으로 정렬되어야 합니다. 방향에 따라 레이아웃을 변경하려면 서로 다른 두 가지 레이아웃을 정의하여 적절한 한정자를 각 레이아웃의 디렉토리 이름에 적용하면 됩니다. 그러면 시스템이 현재 기기 방향에 따라 적절한 레이아웃을 자동으로 적용합니다.

애플리케이션에 포함할 수 있는 여러 가지 종류의 리소스와 각기 다른 기기 구성에 따라 대체 리소스를 생성하는 방법에 대한 자세한 내용은 [리소스 제공](https://developer.android.com/guide/topics/resources/providing-resources)을 참조하세요. 모범 사례와 안정적인 프로덕션 품질의 앱을 설계하는 방법에 대한 자세한 내용은 [앱 아키텍처 가이드](https://developer.android.com/topic/libraries/architecture/guide)를 참조하세요.



## 더 알아보기

동영상 및 코드 튜토리얼로 학습하고 있다면 Udacity 과정 [Developing Android Apps with Kotlin](https://www.udacity.com/course/ud9012)을 확인하거나 온라인 가이드의 다른 페이지를 참조하세요.



### 계속 읽기:

- [인텐트 및 인텐트 필터](https://developer.android.com/guide/components/intents-filters)

  `Intent` API를 사용하여 앱 구성 요소(예: 액티비티, 서비스)를 활성화하는 방법, 앱 구성 요소를 다른 앱이 사용할 수 있도록 하는 방법 등에 대한 정보입니다.

- [액티비티](https://developer.android.com/guide/components/activities)

  `Activity` 클래스의 인스턴스를 생성하는 방법에 관한 정보로, 애플리케이션에 사용자 인터페이스가 있는 독특한 화면을 제공합니다.

- [리소스 제공](https://developer.android.com/guide/topics/resources/providing-resources)

  Android 앱이 앱 코드와는 별개의 앱 리소스에 대해 구조화된 방식에 관한 정보로, 특정 기기 구성에 맞게 대체 리소스를 제공하는 방법도 포함되어 있습니다.
  
  

### 혹시 다음과 같은 내용에도 흥미가 있으신가요?

- [기기 호환성](https://developer.android.com/guide/practices/compatibility)

  여러 가지 유형의 기기에서 Android의 작동 방식과 앱을 각 기기에 맞춰 최적화하는 방법, 또는 여러 가지 기기에 대해 앱의 가용성을 제한하는 방법 등에 관한 정보입니다.

- [시스템 권한](https://developer.android.com/guide/topics/permissions)

  Android가 특정 API에 대한 앱의 액세스를 제한하기 위해 권한 시스템을 사용하는 방법으로, 해당 API를 사용하려면 앱에 대해 사용자의 승인이 필요합니다.



### Android 자세히 알아보기

- [Android](https://www.android.com/)
- [Enterprise](https://www.android.com/enterprise/)[보안](https://www.android.com/security-center/)
- [소스](https://source.android.com/)지원
- [플랫폼 버그 신고](https://issuetracker.google.com/issues/new?component=190923&template=841312)
- [문서 버그 신고](https://issuetracker.google.com/issues/new?component=192697)
- [Google Play support](https://support.google.com/googleplay/android-developer)
- [연구 조사 참여](https://google.qualtrics.com/jfe/form/SV_ewWXIoEVLBcyp7f??reserved=1&utm_source=FooterLink&Q_Language=en&utm_medium=own_srch&utm_campaign=developer.android.com&utm_term=0&utm_content=0&productTag=reg&campaignDate=may19&pType=devel&referral_code=gV420370)
- [개발자 가이드](https://developer.android.com/guide)
- [디자인 가이드](https://developer.android.com/design)
- [API 참조](https://developer.android.com/reference)
- [샘플](https://developer.android.com/samples)
- [Android Studio](https://developer.android.com/studio/intro)
- [개인정보 보호](https://policies.google.com/privacy)
- [라이선스](https://developer.android.com/license)
- [브랜드 가이드라인](https://developer.android.com/distribute/marketing-tools/brand-guidelines)



*Portions of this page are modifications based on work created and* [shared by the Android Open Source Project](https://developers.google.com/terms/site-policies) *and used according to terms described in the* [Creative Commons 2.5 Attribution License](http://creativecommons.org/licenses/by/2.5/)*.*