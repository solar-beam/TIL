# Hello Kotlin at Android

> Android에서 Kotlin시작하기 : https://developer.android.com/kotlin/get-started?hl=ko

- [Kotlin언어 배우기](https://developer.android.com/kotlin/learn?hl=ko) :  Kotlin 기본사항에 관한 30분 단기 집중 과정
- [Kotlin 샘플](https://developer.android.com/samples?language=kotlin&hl=ko) : Kotlin으로 작성된 샘플 Android 앱의 대규모 라이브러리
- [Kotlin 리소스](https://developer.android.com/kotlin/resources?hl=ko) : 샘플, Codelab, 동영상, 도서 등 Kotlin의 모든 것에 관한 선별된 리소스 세트

- 기존 앱에 Kotlin추가하기 가이드 :  안드로이드 스튜디오에는 Java-Kotlin 코드 변환기가 포함됨
  1. Kotlin으로 테스트 코드를 작성하고, 회귀 테스팅을 수행. 테스트는 패키징 중 앱에 번들로 묶이지 않으므로 테스트로 Kotlin을 코드에 추가하는 좋은 시작점.
  2. Kotlin으로 새 코드를 작성. 작은 클래스 또는 toplevel utility 기능으로 시작하고 관련 주석을 추가하여 적절한 상호운용성을 보장하자.
  3. 기존 코드를 Kotlin으로 업데이트. 익숙해지면 기존 자바 코드를 변환. 일부 기능을 추출하여 변환해보자.

> software regression : 휘귀 테스팅은, 이전에 발생한 버그를 누적하여 테스트하는 것을 가리킨다. 코드 리팩토링이나, 잦은 코드수정으로 이전에 고쳤던 버그가 재발하는 경우를 막기 위해서다. 너무 많은 테스트케이스가 누적되지 않도록 우선순위를 골라 수행하기도 한다.

- 코드 최소화보다 가독성이 중요하며, 불필요한 kotlin코드를 과도하게 사용하지 않도록 주의
- 팀작업에 가장 적합한 코딩규칙과 관용구를 확립하는 것이 좋다

*예시) [Android KTX](https://blog.yena.io/studynote/2019/12/26/Android-Kotlin-ClickListener.html)를 이용해 뷰 중복 클릭 방지하기*