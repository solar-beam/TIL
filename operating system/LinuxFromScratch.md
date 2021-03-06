# Linux From Scratch

일반 리눅스배포판이 치킨패티와 양배추가 정량대로 들어가는 맘스터치라면, LFS는 빵과 치즈부터 야채종류와 양까지 스스로 정하는 서브웨이라고 할 수 있다. 시스템 전체를 코드 단계부터 컴파일하여 구성하는데, 필수적인 패키지만 설치함으로써 경량 이미지를 만들 수 있다. 일반적으로 100MB 정도가 필요하며, 아파치 웹서버 용도로 8MB 시스템을 구축할 수도 있다. `strip`을 사용해 5MB나 그 이하로 줄일 수도 있다. 스스로 리눅스 시스템을 구축해보며, "understanding arises through making(Giambattista Vico, 1668-1744)"이란 격언을 되새겨 보자.

  

## BACKGROUND

학교에서 안드로이드앱을 만들다가, 네트워크/컴퓨터시스템을 잘 몰라 API문서도 제대로 이해하지 못해 좌절하며 KLDP에 남긴 글과 프로그래밍 선배들의 애정어린 조언.

  

[From Power Up To Bash Prompt](http://users.cecs.anu.edu.au/~okeefe/p2b/power2bash/power2bash.html) 말그대로 전원이 들어올 때부터 배시 프롬프트가 뜰 때까지 과정을 설명해주는 문서. KLDP 위키에도 이미 번역되어 있음.

[How To Build a Minimal Linux System from Source Code](http://users.cecs.anu.edu.au/~okeefe/p2b/buildMin/buildMin.html) 최소 규모의 리눅스 시스템을 직접 소스코드 단계부터 구성하도록 돕는 문서. 역시나 이미 번역되어 있음.

[Linux From Scratch](http://www.linuxfromscratch.org/lfs/view/stable/) 2번 문서보다는 조금더 실용적인 용도로 리눅스 시스템을 직접 빌드하도록 돕는 문서. 지금까지도 활발하게 활동하고 있는 커뮤니티이고, 6개월에 한번씩 가이드가 갱신. 위키에는 2013년 7.2버전이 번역되어 있음.

  


- 영어를 공부하세요. 구글 검색을 할 때 컴퓨터 치나 computer 치나 마찬가지일까요? 영어가 부담스럽다면 10년된 번역문서 보는 것도 괜찮습니다. 바뀐 내용도 많겠지만 기본적은 것은 바뀌지 않은 것도 많으니까요. 책을 좋아하시면 대형 서점 들러보시는 것도 좋겠고요.
- 글을 아주 보기 좋게 잘 정리하시네요. 꼼꼼하고 신중한 성격이 보입니다. 지금 하시는 방향이 다 맞습니다. 원리를 깨닫고 + 영어 공부 하시고. 핵심적인 부분은 10년전과 크게 다르지 않으니 당연히 저걸로 시작하셔도 좋습니다. 좋은 개발자가 되실 것 같네요.
- 전공자라도 운영체제 다 이해 못하는 경우도 많고, 리눅스 내부를 이해하는 것과 서버 프로그래밍에 필요한 API 수준을 이해하는 것은 거리가 좀 있습니다. 비전공자라서 리눅스에 대해서 더 공부하고 싶으신 마음은 알겠습니다만, 목표지향적인 접근방식이 더 도움이 될 거라는 말씀을 드리고 싶습니다. 물론 운영체제 이론 공부 해두면 좋지만, 주관심사가 아니라면 공룡책을 보기에는 시간 투자가 과다할 것으로 보이네요. 마음에 드는 오픈소스를 하나 파서 메인테이너, 커미터 활동을 하셔도 좋구요. 알고리즘 트레이닝을 꾸준히 하는 것이 좋습니다.
- 혹시나 아직도 Linux에 관심있다면 debian이나 gentoo같은 것을 설치해보는게 재밌지 않을까요? 재미있는 이유는 하드웨어도 알아야하고 설치하는 소프트웨어가 어떤것인지도
알아야 하니까요. code를 분석해서 OS의 내부구조를 분석하는 것도 재미있긴하지만 일단 외형을 둘더싼 것이들 무슨일을 하는지를 찾아보는 것도 재미있거든요. 참고로 Linux를 설치하면서 현재 설치되는 프로그램이 무슨역할을 하는지 검색해 보는 것도 좋은 공부가 될거라고 생각합니다. 글쓴이와는 다르게 저는 조금 산만한 성격이라 글도 대충썼네요. 뭐 핵심만 보세요. :-)
- 15년도 넘은 것 같은데 저도 LFS를 따라해보고 젠투 배포본을 사용해 보면서 운영체제(배포본)이 어떻게 만들어지는지에 대해서 많이 배웠습니다. 이후 타 배포본을 사용해도 그 때 습득했던 지식은 많은 도움이 되고 있습니다. 추가로 아치(Arch) 리눅스도 사용해 보시길 추천 합니다.

  

## LET'S GO









































