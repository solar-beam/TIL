# meet-up docker

������: �Ѽ���
```
git/linux/vim/regex
/bootstrap
next> git
next> JavaScript
```

--ready
rm �����̳� ����
rmi �̹��� ����
�̹���:�±�(default:latest)
��Ŀ Ŀ������ �̹�������(
��ƼŰ��Ʈ(��������), ��/�׿�/���(���ϸ��)
rws
ugo
setuid, setgid, sticky
?????????Ư���۹̼�

--go
docker����: devh��α� docker quick start����(�淮ȭ ������ devh/ubuntu �̹����� ���) / docker start|attach �����̳�id / #�������� $�Ϲݻ����

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
sudoers�����ؼ� �Ϲݻ���ڿ����� sudo����� �� �ֵ��� �ϱ�, �Ϲݻ���� �������� �߰�����

  vi .bashrc # shift+g, shift+a, enter �ǳ���, �ش����Ǿ�, �� �Ʒ�
~~�Ʒ����� ���Ͽ� �ٿ��ֱ�
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
  source .bashrc #�����ϱ�
~~man source
Execute commands from a file in the current shell. 
Read and execute commands from FILENAME in the current shell. The entries in $PATH are used to find the directory containing FILENAME. If any ARGUMENTS are supplied, they become the positional parameters when FILENAME is executed.
Exit Status:
Returns the status of the last command executed in FILENAME; fails if FILENAME cannot be read.
~~

~/etc
  cat
  less

  kill [option]  #�����,��ξ��ֱ� ��
  chgrp [���] #�Ҽ� �׷��� �ٲٱ�

  [ctrl]+d | exit | logout  #�������� �͹̳� ����

  vi  #����� yy, �ٿ��ֱ�� p, �Ϻμ���x, ������ i, ������������ [esc]:qw!
  sudo apt update  #�������� ���α׷� ��ġ�� ��������ҿ��� �������� ���̹Ƿ�, ��ġ���� �� ����� �ּҸ� ������ �ʿ䰡 �ִ�.
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
???????????????????????�ͽ��ټ��� �ֱ�??

������Ʈ �����ϱ�
$PS1
������Ʈ�� ��ܿ� ������ ���� �ִ�.

��Ű�������ϱ�
-����Ȱ迭ubuntu
-�����ް迭Fedora
��Ű��������:
  apt search [keyword]  #���� ����ҿ� Ű���尡 �� ��Ű���� �ִ��� Ǯ�ؽ�Ʈ �˻�
  apt-cache search [keyword] 

apt�� �������� ����ϳ�, dpkg�� �׷��� �ʴ�.
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

  lcd ~  #ȣ��Ʈ ���丮 ����
  ftp  #filezillar������ �ᵵ �Ǵµ�,(��������)
  wget  #ũ�Ѹ����Ҷ�
  sftp  #secure ftp

  tar #������ �ƴ϶� ��ī�̺�, tar tvf [�����̸�]�ϸ� ���θ� �鿩�ٺ� �� ����

******************************
  rsync  #���ݿ� �ִ� ������ ���ͼ� ����ȭ�� ���� �־�

? 0-n
* 0-unlimited
+ 1-unlimited
regex101����Ʈ�� ��������. 

)))))))))))))))))ftp�� aws����Ƽ��
)))))))))))))))))����ǥ���� ����

cut������ �Ǳ��е� �͸�..!!!

??????????????????????????????????
configure
makefile




















