﻿--day1
```
diff / 호프만알고리즘?
* 애스트리크
topic branch
git log -p  #파일의 변경내역을 보여줌
git reset
git reflog  
git과 conflict : 깃이 3-way 머지를 사용하기 때문
기업용 gitlab

git rebase
master / rebasing master branch

git remote -v  #be verbose
git push origin master

git fork와 pull request
git pull
```

--day2
```
????????????????????  git-core-tutorial 번역해보자
????????????????????  merge, rebase, diff심화학습
????????????????????  CHUNK
next>> web-socket, test-driven-development
????????????????? 나는왜 wget과 bash가 안되는가
????????????????? git flow


git fetch  # origin 가져오기만
git pull   # origin 가져와서 merge

github의 release와 tag?

git push로는 tag가 함께 올라가지 않으므로, --tags 옵션을 붙여서 한번 더 해줘야 한다.

?????git option [-p|R]
  # p는 청크단위로
  # git apply -R 되돌린다는뜻,Reverse

markdown을 사용해보자
커밋메시지에 closed #이슈번호를 넣어주면 깃헙 이슈가 닫힌다.

(공동작업)여러 issue를 포함하는 milestone을 생성해 관리할 수 있다.
(개인작업)issue내 checkbox도 써보자.

자동merge
수동merge / 충돌나면 로컬에서 기여자의 브랜치를 병합해서 하나씩 충돌을 해결해준다.
PR머릿글자로 [WIP]를 넣으면 자동 병합이 안되게할 수 있다.

TRAVIS를 적용하기

github	flow
git	flow

wget -q -O - --no-check-certificate https://raw.github.com/petervanderdoes/gitflow-avh/develop/contrib/gitflow-installer.sh install stable | bash
```