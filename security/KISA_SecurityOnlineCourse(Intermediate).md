# KISA_SecurityOnlineCourse(Intermediate)

201020-201030 / 온라인 실전형 사이버훈련(중급)

  

## APT침투

표적에게 발각되지 않는 은밀성, 긴 시간 동안 가해지는 공격을 특징으로 한다.

- 침투시작 : 공격대상 시스템 혹은 네트워크 접근권한 획득, 스피어피싱 또는 워터링홀 등 사회공학기반 공격

- 거점확보 : 추가 공격에 필요한 SW/악성코드를 심어놓는 단계로, 터널링/정보수집/백도어와 같은 프로그램을 FTP/HTTP(S) 등 프로토콜을 이용하여 공격자 시스템에서 다운/설치

- 권한상승 : 접근 가능한 공격대상 시스템 관리자 혹은 그에 준하는 권한획득, 주로 UAC(User Access Control) 우회하거나 SW취약점을 익스플로잇함 (예시 : Win32K local privileges escalation(CVE-2015-1701, code injection to Explorer.exe(Bypass UAC)

- 내부정찰 : 공격 대상 네트워크 인프라스트럭쳐, 신뢰관계, 윈도우 도메인 구조정보 등 수집. 네트워크 연결, ARP캐시테이블, 라우팅 테이블, 포트/서비스, 액티브 디렉토리 그룹/사용자/공유자원 정보 등 수집

- 측면이동 : 공격 대상 네트워크의 다른 호스트 및 서버 시스템 정보를 수집/공격하여 접속 및 제어 가능한 범위를 확대, 내부조사 단계가 해당단계에 포함될 수 있으며, 윈도우 레지스트리 및 방화벽 조자, 로그인 정보 수집, 파일 업로드 및 실행, 익스플로잇 등을 수행함. 윈도우 기본명령을 사용하므로 시스템의 흔적을 추적하기 매우 어려움.

- 제어지속 : 이전 절차에서 획득한 접근권한을 지속하며 백도어를 레지스트리 자동실행 포인트에 등록하거나 스케쥴러.크론탭 등을 조작하여 악성명령이 지속 실행되도록함.

- 임무완료 : 정보탈취하여 전송/파괴, 서비스 정상가동 방해

  

사회공학 기반 네트워크침투란 사용자로 하여금 기밀 정보를 누설토록 유도하는 심리적 트릭으로, 사례를 들면 이메일을 이용하여 '안심하고 메일을 열어 악성파일을 실행'토록 유도하는 경우를 들 수 있습니다. 여기서 핵심은 메일을 이용한다는 점이 아니라 '사용자를 안심'시키고 '행동을 유도'한다는 점입니다.

- 바인드 원격쉘 : 공격자>희생자 시스템 포트로 원격쉘 접속
- 리버스 원격쉘 : 희생자>공격자 시스템 포트로 원격쉘 접속

  

터널링이란 데이터를 안전하게 이동하는 기술이다. 접근할 수 없는 네트워크에서 패킷 통신이 가능토록 하는 것으로서, 외부 시스템에서 내부 시스템 자원으로 패킷을 전송할 수 있음. 이를 이용해 데이터를 암호화하거나 방화벽을 우회할 수 있음. 공격자는 터널링 프로토콜 및 포트포워딩을 이용한다.

- SSH : 포트포워딩 또한 지원, 다른 시스템으로 전송되는 패킷의 페이로드를 우회, Local/Remote로 구분, HTTP/FTP/SMTP payload
- 터널링 프로토콜 : Carrier/Delivery, Passenser(페이로드) 프로토콜

  

라이브 호스트 스캐닝은 ping, nmap, arping과 같은 도구를 이용하여 로컬/원격 네트워크에 대하여 수행할 수 있다. APT공격 라이프사이클 중 내부정찰에 해당한다.

  

포트/서비스 정보 스캐닝은 역시 내부정찰 단계이다. 동일한 네트워크에서 동작중인 시스템의 포트/서비스를 확인한다. 

- 스캐닝 : 취약점스캔/모의해킹에 필요한 정보를 수집하는 기술, 타겟 네트워크에서 실행중인 Explorer 시스템 및 Explorer Active 운영체제/서비스 스캔
- 스캐닝방법 : Active Host Scanning(ping을 보내 동작상태 확인), Port Scanning(HTTP/DNS 운영중인 네트워크 포트 확인하며 nmap 도구로 TCP/UDP 스캐닝 수행), Vulnerability Scanning(컴퓨터시스템, 네트워크/어플리케이션 취약점평가로 open vas 등 활용)
- TCP스캐닝, UDP스캐닝 : 타겟 시스템에서 사용중인 포트 정보 수집
  - 21(FTP), 22(SSH), 23(Telnet), 25(SMTP), 53(DNS), 80(HTTP), 110(POP3), 139(NetBIOS), 143(IMAP), 443(HTTPS), 445(Microsoft-DS)
- TCP SYN스캐닝 : 3 way handshake가 완료되지 않았으므로 Half-Open-Scanning으로 부름. SYN패킷을 보내 SYN/ACK을 받으면 포트 개방여부를 확인할 수 있다. RST를 받으면 닫혀있는 것.
- UDP스캐닝 : UDP datagram을 보내 응답확인, 열려있다면 답이 오지 않고 닫혀있다면 응답메시지가옴
- 53(DNS), 67(DHCPS), 68(DHCPC), 69(TFTP), 123(NTP), 161(SNMP)

  

피봇팅(측면이동)

- CIFS : 마이크로소프트에서 개발한 프로토콜로 컴퓨터 사용자가 회사 인트라넷/인터넷에서 파일을 공유하는 표준 방식으로 TCP 445 포트를 사용한다.
- NetBIOS : 마이크로소프트/Sytek에서 개발한 것으로 LAN상 프로그램에서 사용할 수 있는 API로 여러 컴퓨터의 응용 프로그램을 LAN상에서 통신한다.













https://m.blog.naver.com/ster098/221970745465

**9. ssh리모트 터널링을 실습 후 IP정보를 캡처 후 제출을 하십시오. (해당 문제는 '팀과제제출' 게시판에 파일로 업로드하시면 됩니다.)**

**10. (APT 네트워크침투 리버스 원결쉘 실습) 공격자 PC에서 세션 연결을 하기 위해서 Reverse Handler을 실행을 합니다. 핸들러 잡기 위한 옵션 설정을 하고 설정장면을 제출하십시오, (해당 문제는 '팀과제제출' 게시판에 설정장면을 파일로 업로드하시면 됩니다.)**

내부시스템으로 방화벽을 우회하여 패킷을 캡슐화, 로컬 내트워크내 타겟 시스템에 전달

? rdp, win32k, payload

**10. 사용자 PC2 클라이언트 Command 권한을 얻고 IP주소를 확인하고, 확인 장면을 제출하시오. (해당 문제는 '팀과제제출' 게시판에 확인장면을 파일로 업로드하시면 됩니다.)**





## 악성코드 헌팅











## 로그분석










