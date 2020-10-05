# meetup-git-plus

## diff의 내부구현
- 최장부분수열찾기 알고리즘을 이용한다(메모이제이션)
- ??[diff알고리즘](http://www.cis.upenn.edu/~bcpierce/papers/diff3-short.pdf)

## Git의 내부
- git은 commit, tree, blob, tag 네 가지 객체로 구성되어 있다.
- 커밋할때마다 커밋트리가 생성되는 방식이며, reset시 커밋객체는 삭제되지 않고 링크만 삭제된다.
  그래서 reflog 명령어를 사용하면 삭제된 링크를 확인하여 hard reset의 경우에도 복구가 가능하다.
- [참고링크](http://sjh836.tistory.com/74?category=695128)
- [미디엄 - Git내부구조를 알아보자](https://medium.com/happyprogrammer-in-jeju/git-%EB%82%B4%EB%B6%80-%EA%B5%AC%EC%A1%B0%EB%A5%BC-%EC%95%8C%EC%95%84%EB%B3%B4%EC%9E%90-1-%EA%B8%B0%EB%B3%B8-%EC%98%A4%EB%B8%8C%EC%A0%9D%ED%8A%B8-81b34f85fe53)
- [scm - git object](https://git-scm.com/book/ko/v1/Git%EC%9D%98-%EB%82%B4%EB%B6%80-Git-%EA%B0%9C%EC%B2%B4)
- Jgit 소스코드

## 애스터리크
- 별표, 백설표시 등
- asterik(라틴어로 별이라는 뜻)

## 3-way 머지
- [생활코딩, 3way merge](https://opentutorials.org/course/2708/15307)
- Origin,수정A,수정B가 있다고 가정한다. A에 B를 머지하는 시나리오다.
  - 2way머지는 수정A와 B만을 비교하므로 각각 브랜치에서 수정사항이 발생하면 모두 충돌이 발생한다.
  - 3way머지는 기존코드와 비교해서 A의 수정사항을 지키면서, B의 수정사항만을 반영해준다.
  수정A | Origin | 수정B | 2-way | 3-way
  ------------------------------------
       | A      | A   | ?      | 
  B    | B      | B   | B      | B
  1    | C      | 2   | ?      | ?
  D    | D      |     | ?      | 
- [3way merge알고리즘](https://blog.npcode.com/2012/09/29/3-way-merge-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98%EC%97%90-%EB%8C%80%ED%95%B4/)

## 리베이스(효과와 사용법)
- 효과 : 리베이스를 하면 언제나 fast-forward가 가능한 상태가 된다.
- 기능 : diff의 base를 다시 잡아준다.
- 이미 remote/origin에 반영된 커밋을 rebase하면 역적이다.

## git diff chunk tuning
가능한가??

## git core tutorial(git man page번역)
[번역본](translate/git-core-tutorial.txt)

## git flow
????

## 추가자료
- 그래픽
https://learngitbranching.js.org/





