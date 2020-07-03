# meet-up docker

강의자: 한성일
```
git/linux/vim/regex
/bootstrap
next> git
next> JavaScript
```

--ready
rm 컨테이너 삭제
rmi 이미지 삭제
이미지:태그(default:latest)
도커 커밋으로 이미지생성(
스티키비트(파일종류), 나/그외/모두(파일모드)
rws
ugo
setuid, setgid, sticky
?????????특수퍼미션

--go
docker사용법: devh블로그 docker quick start참조(경량화 해제된 devh/ubuntu 이미지를 사용) / docker start|attach 컨테이너id / #슈퍼유저 $일반사용자

  file /etc/shadow
  id
  ls -l  #순서대로 내 계정, 내(가 포함된) 그룹, 그외 모든 사용자에 대하여 소유한 권한을 표시. rwx(읽기,쓰기,실행)이며, 각 소유자에 대하여 이진수로 표현함

  ps  #현재 실행중인 프로세스를 표시
  top  #윈도우의 작업관리자와 비슷한 역할임, 실시간으로 메모리/CPU점유율을 확인할 수가 있다

  [command] &  #백그라운드에서 돌리기
  jobs  #백그라운드 작업보기
  fg [id]  #포그라운드로 돌리기

  kill [pid]  #프로세스 죽이기

/etc/profile 로그인 쉘 세션용 시작파일
sudoers수정해서 일반사용자에서도 sudo사용할 수 있도록 하기, 일반사용자 계정명을 추가하자

  vi .bashrc # shift+g, shift+a, enter 맨끝줄, 해당줄의앞, 그 아래
~~아래내용 파일에 붙여넣기
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
  source .bashrc #실행하기
~~man source
Execute commands from a file in the current shell. 
Read and execute commands from FILENAME in the current shell. The entries in $PATH are used to find the directory containing FILENAME. If any ARGUMENTS are supplied, they become the positional parameters when FILENAME is executed.
Exit Status:
Returns the status of the last command executed in FILENAME; fails if FILENAME cannot be read.
~~

~/etc
  cat
  less

  kill [option]  #재실행,모두없애기 등
  chgrp [대상] #소속 그룹을 바꾸기

  [ctrl]+d | exit | logout  #실행중인 터미널 종료

  vi  #복사는 yy, 붙여넣기는 p, 일부수정x, 편집은 i, 나가기및종료는 [esc]:qw!
  sudo apt update  #리눅스의 프로그램 설치는 원격저장소에서 가져오는 것이므로, 설치전에 그 저장소 주소를 갱신할 필요가 있다.
vi의 명령어모드:: [esc]키를 눌러서진입
vi의 편집모드 ::  i등 단축키를 눌러서진입
캐럿 ^ 현재행처음
달러 $ 현재행끝
gg 파일의처음으로
[shift]+g 파일의 끝으로
u 되돌리기
dd
x
yy 복사
p 붙여넣기
/ 검색하기(다음으로는 n)
f[찾으려는 문자의 앞자리]
:n 앞으로
:N 뒤로
:e 
:r 읽어와서 현재파일에 입력
:w
???????????????????????익스텐션을 넣기??

프롬프트 고정하기
$PS1
프롬프트를 상단에 고정할 수도 있다.

패키지관리하기
-데비안계열ubuntu
-레드햇계열Fedora
패키지의존성:
  apt search [keyword]  #원격 저장소에 키워드가 들어간 패키지가 있는지 풀텍스트 검색
  apt-cache search [keyword] 

apt는 의존성을 고려하나, dpkg는 그렇지 않다.
????????????????????? apt|apt-get??

fsck /file system check
mkfs /make file system

?????????????????????? ssh?????

  traceroute
  netstat -ie

?????????????
ping
traceroute
netstat
ftp
wget
ssh
scp

  lcd ~  #호스트 디렉토리 변경
  ftp  #filezillar같은거 써도 되는데,(원격파일)
  wget  #크롤링등할때
  sftp  #secure ftp

  tar #압축이 아니라 아카이빙, tar tvf [파일이름]하면 내부를 들여다볼 수 있음

******************************
  rsync  #원격에 있는 파일을 따와서 동기화할 수가 있어

? 0-n
* 0-unlimited
+ 1-unlimited
regex101사이트를 참조하자. 

)))))))))))))))))ftp와 aws프리티어
)))))))))))))))))정규표현식 시험

cut쓸때는 탭구분된 것만..!!!

??????????????????????????????????
configure
makefile




















