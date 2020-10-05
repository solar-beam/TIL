# meet-up docker
- ������ �ʼ�����
  - git/linux/vim/regex
  - �������ÿ��� git, �� �������� JavaScript�� ���͵�
- �Բ��� �ڷ�
  - [nacyot : docker cheatsheet](https://gist.github.com/nacyot/8366310)
  - [devh : docker quick start](http://www.devh.kr/2018/Docker-Quick-Start/)

## docker command
�ֿ��ɾ� : rm, rmi, docker, file, id, ls, ps, top, jobs, fg, kill
```
rm �����̳� ����
rmi �̹��� ���� / �̹���:�±�(default:latest)
docker start|attach �����̳�id / #�������� $�Ϲݻ����
file /etc/shadow
id
ls -l  #������� �� ����, ��(�� ���Ե�) �׷�, �׿� ��� ����ڿ� ���Ͽ� ������ ������ ǥ��. rwx(�б�,����,����)�̸�, �� �����ڿ� ���Ͽ� �������� ǥ����
ps  #���� �������� ���μ����� ǥ��
top  #�������� �۾������ڿ� ����� ������, �ǽð����� �޸�/CPU�������� Ȯ���� ���� �ִ�
[command] &  #��׶��忡�� ������
jobs  #��׶��� �۾�����
fg [id]  #���׶���� ������
kill [pid]  #���μ��� ���̱�
/etc/profile �α��� �� ���ǿ� ��������
```
sudoers�����ؼ� �Ϲݻ���ڿ����� sudo����� �� �ֵ��� �ϱ�, �Ϲݻ���� �������� �߰�����
```
vi .bashrc # shift+g, shift+a, enter �ǳ���, �ش����Ǿ�, �� �Ʒ�
```
�Ʒ����� ���Ͽ� �ٿ��ְ� ����
```
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
source .bashrc #�����ϱ�
```

## Linux command
- man source : Execute commands from a file in the current shell. 
Read and execute commands from FILENAME in the current shell. The entries in $PATH are used to find the directory containing FILENAME. If any ARGUMENTS are supplied, they become the positional parameters when FILENAME is executed. (Exit Status: Returns the status of the last command executed in FILENAME; fails if FILENAME cannot be read.)
- kill [option]  #�����,��ξ��ֱ� ��
- chgrp [���] #�Ҽ� �׷��� �ٲٱ�
- [ctrl]+d | exit | logout  #�������� �͹̳� ����
- vi  #����� yy, �ٿ��ֱ�� p, �Ϻμ���x, ������ i, ������������ [esc]:qw!
- sudo apt update  #�������� ���α׷� ��ġ�� ��������ҿ��� �������� ���̹Ƿ�, ��ġ���� �� ����� �ּҸ� ������ �ʿ䰡 �ִ�.
```
[VI CHEATSHEET]
vi�� ��ɾ���:: [esc]Ű�� ����������
vi�� ������� ::  i�� ����Ű�� ����������
ĳ�� ^ ������ó��
�޷� $ �����ೡ
gg ������ó������
[shift]+g ������ ������
u �ǵ�����
dd
x
yy ����
p �ٿ��ֱ�
/ �˻��ϱ�(�������δ� n)
f[ã������ ������ ���ڸ�]
:n ������
:N �ڷ�
:e 
:r �о�ͼ� �������Ͽ� �Է�
:w
```
- $PS1 ������Ʈ ��� ����
- ��Ű������ : ����Ȱ迭ubuntu, �����ް迭Fedora
```
apt search [keyword]  #���� ����ҿ� Ű���尡 �� ��Ű���� �ִ��� Ǯ�ؽ�Ʈ �˻�
apt-cache search [keyword] 
apt�� �������� ����ϳ�, dpkg�� �׷��� �ʴ�.
```
- fsck /file system check
- mkfs /make file system
- ssh
- traceroute
- netstat -ie
- ping
- traceroute
- netstat
- ftp
- wget
- ssh
- scp
- lcd ~  #ȣ��Ʈ ���丮 ����
- ftp  #filezillar������ �ᵵ �Ǵµ�,(��������)
- wget  #ũ�Ѹ����Ҷ�
- sftp  #secure ftp
- tar #������ �ƴ϶� ��ī�̺�, tar tvf [�����̸�]�ϸ� ���θ� �鿩�ٺ� �� ����
- rsync  #���ݿ� �ִ� ������ ���ͼ� ����ȭ�� ���� �־�
- ���ϵ�ī��
```
? 0-n
* 0-unlimited
+ 1-unlimited
```
- ����ǥ���� : regex101 ���������� �����غ� �� �ִ�.