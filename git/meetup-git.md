# meetup-git
- 다음시간에는 web-socket과 test-driven-development를 스터디
- diff / 호프만알고리즘
- 주요 명령어
```
git log -p  #파일의 변경내역을 보여줌
git reset
git reflog  
git rebase
master / rebasing master branch
git remote -v  #be verbose
git push origin master
git fetch  # origin 가져오기만
git pull   # origin 가져와서 merge
           # git push로는 tag가 함께 올라가지 않으므로, --tags 옵션을 붙여서 한번 더 해줘야 한다.
```
- git option [-p|R]
  - p는 청크단위로
  - git apply -R 되돌린다는뜻,Reverse
- 커밋 메시지에서 md사용할 수 있다. 커밋메시지에 closed #이슈번호를 넣어주면 깃헙 이슈가 닫힌다.
- 작업관리 이점
  - (공동작업)여러 issue를 포함하는 milestone을 생성해 관리할 수 있다.
  - (개인작업)issue내 checkbox도 써보자.
- 자동merge, 수동merge : 충돌나면 로컬에서 기여자의 브랜치를 병합해서 하나씩 충돌을 해결해준다.
- PR머릿글자로 [WIP]를 넣으면 자동 병합이 안되게할 수 있다.
- 작업흐름에 대한 이해 : [ujuc : git flow, gitlab flow, gitlab flow](https://ujuc.github.io/2015/12/16/git-flow-github-flow-gitlab-flow/)
  - github	flow
  - git	flow