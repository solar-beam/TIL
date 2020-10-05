# git-flow
- [https://ujuc.github.io/2015/12/16/git-flow-github-flow-gitlab-flow/](https://ujuc.github.io/2015/12/16/git-flow-github-flow-gitlab-flow/)

## git-flow
![](../img/git-model@2x.png)
- Vincent Driessen, A succesful Git branching model [https://nvie.com/posts/a-successful-git-branching-model/](https://nvie.com/posts/a-successful-git-branching-model/)
- Daniel Kummer, git-flow cheatsheet [https://danielkummer.github.io/git-flow-cheatsheet/index.ko_KR.html](https://danielkummer.github.io/git-flow-cheatsheet/index.ko_KR.html)
- 브랜치별 기능
  - master : release, stable
  - develop : pre-release
  - feature : 특정기능을 위한
    - develop 브랜치에서 가져오고, develop 브랜치로 머지
    - develop 브랜치 외 브랜치와는 머지하지 않음
    - 개발자 로컬에서만 유지하고 origin에는 푸시하지 않음
    - develop 브랜치에 머지하면 feature 브랜치는 삭제
  - release : 릴리즈 점검
    - develop 브랜치에서 가져와, develop과 master 브랜치로 머지
    - release-[version-num] 형태로 이름을 짓는다
    - 브랜치 생성후 소스코드내 버전과 관련값을 수정하고 커밋
    - 개발이 최종 완료되었다고 판단하는 시점에서 브랜치 생성
    - 릴리즈 대상 feature는 미리 develop에 머지되어 있어야 한다
    - release 브랜치 생성 이후 버그픽스는 release 브랜치 내에서
    - 릴리즈 준비가 완료되면 master로 머지
    - master에서 해당 버전으로 태그 생성
    - release브랜치에서 버그픽스한것 develop 브랜치로 머지
    - release 종료되면 브랜치 삭제
  - hotfix
    - master에서 가져오며 master와 develop으로 머지
    - hotfix-[num]으로 이름짓고, 활용방법 release와 동일하다
- 주의사항
  - 브랜치 머지할 때 `--no-ff`옵션을 쓴다. fast foward관계라도 머지 커밋을 만든다. 기본은 `--ff`옵션인데, 토픽 브랜치가 로그에 남지 않는다. `--squash`는 브랜치도 커밋로그도 남기지 않고 정보만 받아온다.
  - 가능하다면 버전 정보는 소스코드내 직접 작성하지 않고, 버전과 관련된 정보를 찾아 현재 버전으로 업데이트 하는 스크립트를 작성해두자.
- 머지 기본옵션을 `--no-ff`로 바꾸는 방법
  - 전역설정, `$ git config --global alias.nffmerge "merge --no-ff"`
  - 브랜치 머지옵션, `$ git config branch.<name>.mergeoptions "--no-ff"`
    - 위와 같이 수행하면, 리모트 변경사항을 pull할 때도 머지 커밋이 생기므로 아래와 같이 [rebase](https://git-scm.com/book/ko/v2/Git-%EB%B8%8C%EB%9E%9C%EC%B9%98-Rebase-%ED%95%98%EA%B8%B0)옵션을 바꿔주자.
    - `$ git config branch.<name>.rebase true`
    - `$ git config branch.autosetuprebase always`

## github-flow
![](../img/20151104223339.png)
- scott chacon, issues with git-flow [http://scottchacon.com/2011/08/31/github-flow.html](http://scottchacon.com/2011/08/31/github-flow.html)
- park changwoo, github flow [https://dogfeet.github.io/articles/2011/github-flow.html](https://dogfeet.github.io/articles/2011/github-flow.html)
- master브랜치에만 정해진 규칙이 있다
  - 이미 deploy했거나 곧 deploy한다는 의미다
  - master=stable, 머지하기전 충분히 검증한다
  - 테스트는 로컬이 아니라, 브랜치를 푸시하고 Jenkins로 한다
- 브랜치는 항상 master브랜치에서 만든다
- 이름에 역할이 잘 드러나도록 짓는다 예) new-oauth2-scopes, redis2-transition
- named브랜치는 자주 push한다
- 언제든지 pull request한다
- pull request로 리뷰하고 머지한다
- master에 머지하면 바로 배포한다(hubot으로 한다.)