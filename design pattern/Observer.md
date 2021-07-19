# Observer

> HeadFirst DesignPattern, 옵저버 패턴

- 옵저버 패턴이란

  - 객체들간 일대다 관계를 정의한 것으로, 한 객체의 상태가 변경되면 의존하는 모든 객체에 연락을 한다.

  - Subject 또는 Observable 객체는 동일한 인터페이스를 써서 옵저버에 연락을 한다. Observable은 옵저버들이 Observer 인터페이스를 구현한다는 것을 제외하면 옵저버에 대해 전혀 모르기 때문에, 이들 사이의 결합은 느슨한 결합이다. 옵저버 패턴을 이용하면 Subject 객체에서 데이터를 보내거나(푸시), 옵저버가 데이터를 가져오는(풀) 방식을 쓸 수 있다. 옵저버들에게 연락을 돌리는 순서에 의존하는 것은 좋지 않다. Observable 패턴은 여러곳에 쓰인다.

  - 【**예시1**】 아래 코드의 이벤트 리스너(Observer, 구독자)는 swing 버튼(Subject, 구독)에 이벤트가 발생하면(변경되면) 문자열을 출력한다.

    ```java
    package com.github.solarbeam.swingObserver;
    
    import javax.swing.*;
    import java.awt.*;
    import java.awt.event.ActionEvent;
    import java.awt.event.ActionListener;
    
    public class SwringObserverExample {
        JFrame frame;
    
        public static void main(String[] args) {
            SwringObserverExample example = new SwringObserverExample();
            example.go();
        }
    
        public void go() {
            frame = new JFrame();
            JButton button = new JButton("정말 해도 될까?");
            button.addActionListener(new AngelListener());
            button.addActionListener(new DevilListener());
            frame.getContentPane().add(BorderLayout.CENTER, button);
    
            frame.setSize(200,200);
            frame.setVisible(true);
        }
    
        class AngelListener implements ActionListener {
            public void actionPerformed(ActionEvent event){
                System.out.println("안 돼. 분명 나중에 후회할 거야.");
            }
        }
    
        class DevilListener implements ActionListener {
            public void actionPerformed(ActionEvent event){
                System.out.println("당연하지. 그냥 저질러 버려!");
            }
        }
    }
    ```

  - 【**예시2**】 기상정보를 스크래핑하는 `기상스테이션` 클래스, `기상스테이션`으로부터 기상정보를 수신받는 `기상데이터` Subject 클래스, 생성시점에 `기상데이터`로 자신의 인스턴스 정보를 넘겨 기상정보가 변경되면 알림을 받는 `기상 디스플레이` 클래스.

    ```java
    //기상스테이션
    package com.github.solarbeam.observer;
    
    import com.github.solarbeam.observer.*;
    
    public class WeatherStation {
    
        public static void main(String[] args){
    
            WeatherData weatherData = new WeatherData();
    
            //기상 디스플레이는, 생성시점에 기상데이터 인스턴스를 인자로 받아 해당 인스턴스에 자신을 등록한다.
            //인자로 받은 기상데이터 인스턴스는 차후 등록을 삭제 요청할 때 레퍼런스로 사용한다.
            CurrentConditionsDisplay currentConditionsDisplay = new CurrentConditionsDisplay(weatherData);
            StatisticsDisplay statisticsDisplay = new StatisticsDisplay(weatherData);
            ForecastDisplay forecastDisplay = new ForecastDisplay(weatherData);
            HealthIndexDisplay healthIndexDisplay = new HealthIndexDisplay(weatherData);
    
            weatherData.setMeasurements(80, 65, 40.4f);
            weatherData.setMeasurements(82, 70, 29.2f);
            weatherData.setMeasurements(78, 90, 29.2f);
    
        }
    }
    ```

    ```java
    //기상데이터
    package com.github.solarbeam.observer;
    
    import java.util.ArrayList;
    
    public class WeatherData implements Subject{
        private ArrayList observers;
        private float temperature;
        private float humidity;
        private float pressure;
    
        public WeatherData() {
            observers = new ArrayList();
        }
    
        //옵저버 인터페이스를 구현했다면 등록/삭제할 수 있다
        @Override
        public void registerObserver(Observer o) { 
            observers.add(o);
        }
    
        @Override
        public void removeObserver(Observer o) {
            int i = observers.indexOf(o);
            if(i >= 0) observers.remove(i);
        }
        
        //변경사항이 발생하면 메소드를 호출해 알림을 보낸다, PUSH 방식
        public void measurementsChanged() {
            notifyObserver();
        }
    
        @Override
        public void notifyObserver() {
            for(int i=0; i<observers.size(); i++){
                Observer observer = (Observer) observers.get(i);
                observer.update(temperature, humidity, pressure);
            }
        }
    
        public void setMeasurements(float temperature, float humidity, float pressure){
            //TODO 웹에서 데이터 가져오기
            this.temperature = temperature;
            this.humidity = humidity;
            this.pressure = pressure;
            measurementsChanged();
        }
    
        //TODO PULL 방식 
        public void getter() {}
        public void setter() {}
    }
    ```

    ```java
    //기상정보 디스플레이
    package com.github.solarbeam.observer;
    
    public class CurrentConditionsDisplay implements Observer, DisplayElement{
    
        private float temperature;
        private float humidity;
        private Subject weatherData;
    
        public CurrentConditionsDisplay(Subject weatherData) {
            this.weatherData = weatherData;
            weatherData.registerObserver(this);
        }
    
        @Override
        public void update(float temperature, float humidity, float pressure) {
            this.temperature = temperature;
            this.humidity = humidity;
            display();
        }
    
        @Override
        public void display() {
            System.out.println("Current conditions: " + temperature +
                    "F degrees and " + humidity + "% humidity");
        }
    }
    
    ```

- Java Observable은 폐기됐다. 용도에 따라 다음과 같은 라이브러리를 활용하라.

  - `java.beans` : 풍부한 이벤트 모델
  - `java.util.concurrent` : 신뢰할 수 있고, 순서를 정하고 싶거나, 쓰레드와 동시성 데이터 구조를 활용하는 경우
  - `java.util.concurrent.Flow` : 반응형 스트림 스타일

- 객체지향 디자인 원칙이 옵저버 패턴에 어떻게 적용되었는가
  - 애플리케이션에서 바뀌는 부분을 찾아 바뀌지 않는 부분으로부터 분리한다: 옵저버 패턴에서 변하는 것은 주제의 상태와 옵저버의 개수, 형식이다. 옵저버 패턴에서는 주제를 바꾸지 않고도 주제의 상태에 의존하는 객체들을 바꿀 수 있다.
  - 특정 구현이 아닌, 인터페이스에 맞춰서 프로그래밍한다: Subject와 Observer에서 모두 인터페이스를 사용했다. Subject는 Subject 인터페이스를 통해 Observer 인터페이스를 구현한 객체들의 등록/탈퇴를 관리하고, 그런 객체들에게 연락을 돌렸다. 이렇게 함으로써 결합을 느슨하게 만들 수 있다.
  - 상속보다는 구성을 활용하다: 옵저버 패턴에서는 구성을 활용하여 옵저버를 관리한다. 주제와 옵저버 사이의 관계는 상속이 아니라 구성에 의해 이뤄지기 때문이다. 게다가 실행중 구성되는 방식을 사용하니 더 좋다.



