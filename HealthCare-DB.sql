----------------------------------------------------------------
------------ ����� ���� ------------ 
----------------------------------------------------------------
/* ########  ID : SYSTEM ######## */

ALTER session set "_ORACLE_SCRIPT"=true;
DROP USER health CASCADE; -- ���� ����� ����(���� ���ӵǾ� ������ ���� �� ��)
	-- CASCADE option : ���� ��Ű�� ��ü�鵵 �Բ� ����.  Default�� No Action
CREATE USER health IDENTIFIED BY 1234  -- ����� ID : health, ��й�ȣ : 1234
    DEFAULT TABLESPACE USERS
    TEMPORARY TABLESPACE TEMP;
GRANT connect, resource, dba TO health; -- ���� �ο�

-----------------------------------------------
----------------- ���̺� ���� ------------------
-----------------------------------------------
/*############ ID : health #############*/

CREATE TABLE ȸ��(
    ID NUMBER(10) PRIMARY KEY,
    PW VARCHAR(20) NOT NULL,
	�̸�	NCHAR(5) NOT NULL,
	�ֹε�Ϲ�ȣ NCHAR(20) NOT NULL,
	����	NCHAR(3) NOT NULL
);

CREATE TABLE ��ȯ(
    �����׸� NCHAR(20) NOT NULL,
    ��ȯ�� NCHAR(20) NOT NULL,
    �����׸� NCHAR(20) NOT NULL,
    ������ NCHAR(3) NOT NULL,
    �ּ����� NUMBER(10),
    �ְ����� NUMBER(10),
    CONSTRAINT ��ȯ_PK PRIMARY KEY(�����׸�,������)
);

CREATE TABLE ȸ����ġ(
    �˻糯¥ DATE,
    ID NUMBER(10),
    �����׸� NCHAR(20),
    ������ NCHAR(3),
    ��ġ�� NUMBER(10),
    �̻����� CHAR(1) CHECK(�̻����� IN ('0','1')),  --����Ŭ���� BOOLEAN�� ���� 0�� 1�� ǥ��
    FOREIGN KEY (ID) REFERENCES ȸ��(ID),
    FOREIGN KEY (�����׸�,������) REFERENCES ��ȯ(�����׸�,������),
    CONSTRAINT ȸ����ġ_PK PRIMARY KEY(�˻糯¥,ID,�����׸�,������)
);

-----------------------------------------------
----------------- ������ �Է� ------------------
-----------------------------------------------

-- ȸ��(ID, PW, �̸�, �ֹε�Ϲ�ȣ, ����)
INSERT INTO ȸ�� VALUES(1,'1111','������','011029-1111111','��');
INSERT INTO ȸ�� VALUES(2,'2222','����ȣ','222222-2222222','��');
INSERT INTO ȸ�� VALUES(3,'3333','����ȣ','333333-3333333','��');


-- ��ȯ(�����׸�, ��ȯ��, �����׸�, ������, �ּ�����, �ְ�����)
-- ���� �������� ������ ������ ���� '��'/'��' �̿� '����'
INSERT INTO ��ȯ VALUES('���� �˻�','��','����','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���� �˻�','��','ü��','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���� �˻�','��','�㸮�ѷ�','��',NULL,90);
INSERT INTO ��ȯ VALUES('���� �˻�','��','�㸮�ѷ�','��',NULL,85);
INSERT INTO ��ȯ VALUES('���� �˻�','��','ü��������','����',18.5,24.9);
INSERT INTO ��ȯ VALUES('���� �˻�','�ð� �̻�','�÷�(��)','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���� �˻�','�ð� �̻�','�÷�(��)','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���� �˻�','û�� �̻�','û��(��)','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���� �˻�','û�� �̻�','û��(��)','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���� �˻�','������','����','����',80,120);
INSERT INTO ��ȯ VALUES('��˻�','������ȯ','��ܹ�','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���װ˻�','����','������','��',13,16.5);
INSERT INTO ��ȯ VALUES('���װ˻�','����','������','��',12,15.5);
INSERT INTO ��ȯ VALUES('���װ˻�','�索��','��������','����',NULL,100);
INSERT INTO ��ȯ VALUES('���װ˻�','�������̻������������ư�ȭ','���ݷ����׷�','����',NULL,200);
INSERT INTO ��ȯ VALUES('���װ˻�','�������̻������������ư�ȭ','HDL-�ݷ����׷�','����',60,NULL);
INSERT INTO ��ȯ VALUES('���װ˻�','�������̻������������ư�ȭ','Ʈ���۸������̵�','����',100,150);
INSERT INTO ��ȯ VALUES('���װ˻�','�������̻������������ư�ȭ','LDL-�ݷ����׷�','����',NULL,100);
INSERT INTO ��ȯ VALUES('���װ˻�','����������ȯ','��ûũ����Ƽ��','����',NULL,1.5);
INSERT INTO ��ȯ VALUES('���װ˻�','������ȯ','AST(SGOT)','����',NULL,40);
INSERT INTO ��ȯ VALUES('���װ˻�','������ȯ','ALT(SGPT)','����',NULL,35);
INSERT INTO ��ȯ VALUES('���װ˻�','������ȯ','������Ƽ��(y-GTP)','��',11,63);
INSERT INTO ��ȯ VALUES('���װ˻�','������ȯ','������Ƽ��(y-GTP)','��',8,35);
INSERT INTO ��ȯ VALUES('���װ˻�','������ȯ','B�������׿�','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���װ˻�','������ȯ','B��������ü','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('���װ˻�','������ȯ','�����˻���','����',NULL,NULL);
INSERT INTO ��ȯ VALUES('����˻�','����������ȯ','��ι�缱�˻�','����',NULL,NULL);


-- ȸ����ġ(�˻糯¥, ID, �����׸�, ������, ��ġ��, �̻�����)
-- ��ȯ�� (�����׸�, ������) ���� �־�� ��
-- �̻������� '0' : �̻�X(����) '1' : �̻�
ALTER session set NLS_DATE_FORMAT = 'YYYY/MM/DD'; --��¥�� �ֵ��� DATE ���� ����
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'����','����',170,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'ü��','����',52,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'�㸮�ѷ�','��',70,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'ü��������','����',20,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'�÷�(��)','����',0.8,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'�÷�(��)','����',0.8,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'û��(��)','����',80,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'û��(��)','����',100,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'����','����',75,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'��ܹ�','����',50,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'������','��',10,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'��������','����',90,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'���ݷ����׷�','����',150,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'HDL-�ݷ����׷�','����',80,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'Ʈ���۸������̵�','����',140,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'LDL-�ݷ����׷�','����',100,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'��ûũ����Ƽ��','����',1.2,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'AST(SGOT)','����',50,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'ALT(SGPT)','����',40,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'������Ƽ��(y-GTP)','��',30,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'B�������׿�','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'B��������ü','����',2.1,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'�����˻���','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',1,'��ι�缱�˻�','����',1,'0');

INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'����','����',170,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'ü��','����',58,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'�㸮�ѷ�','��',77,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'ü��������','����',23,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'�÷�(��)','����',0.8,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'�÷�(��)','����',0.8,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'û��(��)','����',85,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'û��(��)','����',100,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'����','����',70,'1');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'��ܹ�','����',45,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'������','��',9.5,'1');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'��������','����',95,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'���ݷ����׷�','����',155,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'HDL-�ݷ����׷�','����',83,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'Ʈ���۸������̵�','����',135,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'LDL-�ݷ����׷�','����',105,'1');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'��ûũ����Ƽ��','����',1.2,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'AST(SGOT)','����',40,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'ALT(SGPT)','����',35,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'������Ƽ��(y-GTP)','��',30,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'B�������׿�','����',1.3,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'B��������ü','����',2.5,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'�����˻���','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2023/10/25',1,'��ι�缱�˻�','����',1.5,'0');

INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'����','����',170,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'ü��','����',55,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'�㸮�ѷ�','��',75,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'ü��������','����',22,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'�÷�(��)','����',0.7,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'�÷�(��)','����',0.7,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'û��(��)','����',90,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'û��(��)','����',95,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'����','����',75,'1');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'��ܹ�','����',48,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'������','��',12,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'��������','����',87,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'���ݷ����׷�','����',132,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'HDL-�ݷ����׷�','����',73,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'Ʈ���۸������̵�','����',111,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'LDL-�ݷ����׷�','����',115,'1');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'��ûũ����Ƽ��','����',1.5,'1');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'AST(SGOT)','����',40,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'ALT(SGPT)','����',35,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'������Ƽ��(y-GTP)','��',30,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'B�������׿�','����',1.4,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'B��������ü','����',2.6,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'�����˻���','����',1.3,'0');
INSERT INTO ȸ����ġ VALUES('2024/12/25',1,'��ι�缱�˻�','����',1.0,'0');


INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'����','����',170,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'ü��','����',69,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'�㸮�ѷ�','��',76,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'ü��������','����',20.2,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'�÷�(��)','����',0.7,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'�÷�(��)','����',0.7,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'û��(��)','����',93,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'û��(��)','����',91,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'����','����',85,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'��ܹ�','����',49,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'������','��',12,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'��������','����',102,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'���ݷ����׷�','����',189,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'HDL-�ݷ����׷�','����',61,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'Ʈ���۸������̵�','����',153,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'LDL-�ݷ����׷�','����',95,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'��ûũ����Ƽ��','����',1.5,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'AST(SGOT)','����',35,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'ALT(SGPT)','����',32,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'������Ƽ��(y-GTP)','��',37,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'B�������׿�','����',1.2,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'B��������ü','����',2.6,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'�����˻���','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/12',1,'��ι�缱�˻�','����',1.1,'0');

INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'����','����',171,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'ü��','����',73,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'�㸮�ѷ�','��',86,'1');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'ü��������','����',25,'1');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'�÷�(��)','����',0.7,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'�÷�(��)','����',0.7,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'û��(��)','����',93,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'û��(��)','����',93,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'����','����',88,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'��ܹ�','����',43,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'������','��',13,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'��������','����',105,'1');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'���ݷ����׷�','����',202,'1');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'HDL-�ݷ����׷�','����',67,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'Ʈ���۸������̵�','����',153,'1');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'LDL-�ݷ����׷�','����',102,'1');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'��ûũ����Ƽ��','����',1.5,'1');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'AST(SGOT)','����',32,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'ALT(SGPT)','����',28,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'������Ƽ��(y-GTP)','��',29,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'B�������׿�','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'B��������ü','����',2.6,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'�����˻���','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2026/10/12',1,'��ι�缱�˻�','����',1.1,'0');



INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'����','����',178,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'ü��','����',75,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'�㸮�ѷ�','��',80,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'ü��������','����',20,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'�÷�(��)','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'�÷�(��)','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'û��(��)','����',100,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'û��(��)','����',100,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'����','����',125,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'��ܹ�','����',60,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'������','��',16,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'��������','����',90,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'���ݷ����׷�','����',155,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'HDL-�ݷ����׷�','����',90,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'Ʈ���۸������̵�','����',142,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'LDL-�ݷ����׷�','����',50,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'��ûũ����Ƽ��','����',1.8,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'AST(SGOT)','����',30,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'ALT(SGPT)','����',40,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'������Ƽ��(y-GTP)','��',34,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'B�������׿�','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'B��������ü','����',2.6,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'�����˻���','����',1.1,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',2,'��ι�缱�˻�','����',2.3,'0');

INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'����','����',178,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'ü��','����',70,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'�㸮�ѷ�','��',77,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'ü��������','����',18,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'�÷�(��)','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'�÷�(��)','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'û��(��)','����',110,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'û��(��)','����',103,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'����','����',115,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'��ܹ�','����',62,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'������','��',16.9,'1');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'��������','����',85,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'���ݷ����׷�','����',132,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'HDL-�ݷ����׷�','����',100,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'Ʈ���۸������̵�','����',121,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'LDL-�ݷ����׷�','����',95,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'��ûũ����Ƽ��','����',2.3,'1');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'AST(SGOT)','����',21,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'ALT(SGPT)','����',40,'1');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'������Ƽ��(y-GTP)','��',45,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'B�������׿�','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'B��������ü','����',3.9,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'�����˻���','����',3.5,'0');
INSERT INTO ȸ����ġ VALUES('2023/11/23',2,'��ι�缱�˻�','����',2.2,'0');


INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'����','����',178,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'ü��','����',82,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'�㸮�ѷ�','��',88,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'ü��������','����',25,'1');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'�÷�(��)','����',1.1,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'�÷�(��)','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'û��(��)','����',110,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'û��(��)','����',103,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'����','����',121,'1');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'��ܹ�','����',60,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'������','��',18,'1');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'��������','����',99,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'���ݷ����׷�','����',132,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'HDL-�ݷ����׷�','����',100,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'Ʈ���۸������̵�','����',146,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'LDL-�ݷ����׷�','����',98,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'��ûũ����Ƽ��','����',2.3,'1');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'AST(SGOT)','����',35,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'ALT(SGPT)','����',40,'1');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'������Ƽ��(y-GTP)','��',40,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'B�������׿�','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'B��������ü','����',3.2,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'�����˻���','����',3.5,'0');
INSERT INTO ȸ����ġ VALUES('2024/10/23',2,'��ι�缱�˻�','����',2.3,'0');


INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'����','����',178,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'ü��','����',80,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'�㸮�ѷ�','��',86,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'ü��������','����',23,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'�÷�(��)','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'�÷�(��)','����',1.0,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'û��(��)','����',105,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'û��(��)','����',106,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'����','����',111,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'��ܹ�','����',60,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'������','��',18,'1');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'��������','����',95,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'���ݷ����׷�','����',165,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'HDL-�ݷ����׷�','����',123,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'Ʈ���۸������̵�','����',140,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'LDL-�ݷ����׷�','����',87,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'��ûũ����Ƽ��','����',2.5,'1');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'AST(SGOT)','����',32,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'ALT(SGPT)','����',43,'1');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'������Ƽ��(y-GTP)','��',65,'1');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'B�������׿�','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'B��������ü','����',3.5,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'�����˻���','����',3.5,'0');
INSERT INTO ȸ����ġ VALUES('2025/10/10',2,'��ι�缱�˻�','����',3.9,'0');


INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'����','����',178,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'ü��','����',87,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'�㸮�ѷ�','��',95,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'ü��������','����',28,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'�÷�(��)','����',0.9,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'�÷�(��)','����',1.1,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'û��(��)','����',110,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'û��(��)','����',110,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'����','����',135,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'��ܹ�','����',60,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'������','��',18,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'��������','����',123,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'���ݷ����׷�','����',232,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'HDL-�ݷ����׷�','����',123,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'Ʈ���۸������̵�','����',153,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'LDL-�ݷ����׷�','����',101,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'��ûũ����Ƽ��','����',2.5,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'AST(SGOT)','����',32,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'ALT(SGPT)','����',48,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'������Ƽ��(y-GTP)','��',65,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'B�������׿�','����',3.0,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'B��������ü','����',3.5,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'�����˻���','����',3.1,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/10',2,'��ι�缱�˻�','����',4.5,'0');


INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'����','����',175,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'ü��','����',65,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'�㸮�ѷ�','��',70,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'ü��������','����',21.5,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'�÷�(��)','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'�÷�(��)','����',1.6,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'û��(��)','����',120,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'û��(��)','����',110,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'����','����',140,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'��ܹ�','����',30,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'������','��',16.3,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'��������','����',80,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'���ݷ����׷�','����',155,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'HDL-�ݷ����׷�','����',62,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'Ʈ���۸������̵�','����',111,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'LDL-�ݷ����׷�','����',32,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'��ûũ����Ƽ��','����',1.3,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'AST(SGOT)','����',45,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'ALT(SGPT)','����',40,'1');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'������Ƽ��(y-GTP)','��',34,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'B�������׿�','����',5,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'B��������ü','����',4.2,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'�����˻���','����',3.5,'0');
INSERT INTO ȸ����ġ VALUES('2022/11/25',3,'��ι�缱�˻�','����',2.3,'0');


INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'����','����',175,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'ü��','����',68,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'�㸮�ѷ�','��',72,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'ü��������','����',21.6,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'�÷�(��)','����',1.6,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'�÷�(��)','����',1.6,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'û��(��)','����',125,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'û��(��)','����',112,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'����','����',145,'1');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'��ܹ�','����',60,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'������','��',20,'1');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'��������','����',120,'1');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'���ݷ����׷�','����',112,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'HDL-�ݷ����׷�','����',62,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'Ʈ���۸������̵�','����',111,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'LDL-�ݷ����׷�','����',32,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'��ûũ����Ƽ��','����',1.9,'1');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'AST(SGOT)','����',80,'1');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'ALT(SGPT)','����',20,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'������Ƽ��(y-GTP)','��',63,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'B�������׿�','����',9,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'B��������ü','����',2.1,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'�����˻���','����',8.5,'0');
INSERT INTO ȸ����ġ VALUES('2023/09/25',3,'��ι�缱�˻�','����',2.1,'0');


INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'����','����',175,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'ü��','����',63,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'�㸮�ѷ�','��',68,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'ü��������','����',17,'1');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'�÷�(��)','����',1.6,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'�÷�(��)','����',1.6,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'û��(��)','����',133,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'û��(��)','����',118,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'����','����',110,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'��ܹ�','����',30,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'������','��',13,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'��������','����',81,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'���ݷ����׷�','����',89,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'HDL-�ݷ����׷�','����',62,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'Ʈ���۸������̵�','����',111,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'LDL-�ݷ����׷�','����',91,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'��ûũ����Ƽ��','����',0.5,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'AST(SGOT)','����',29,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'ALT(SGPT)','����',20,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'������Ƽ��(y-GTP)','��',63,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'B�������׿�','����',3,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'B��������ü','����',5,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'�����˻���','����',3.2,'0');
INSERT INTO ȸ����ġ VALUES('2024/09/15',3,'��ι�缱�˻�','����',5.3,'0');


INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'����','����',175,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'ü��','����',70,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'�㸮�ѷ�','��',75,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'ü��������','����',20.3,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'�÷�(��)','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'�÷�(��)','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'û��(��)','����',140,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'û��(��)','����',120,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'����','����',113,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'��ܹ�','����',90,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'������','��',18,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'��������','����',132,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'���ݷ����׷�','����',165,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'HDL-�ݷ����׷�','����',92,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'Ʈ���۸������̵�','����',161,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'LDL-�ݷ����׷�','����',132,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'��ûũ����Ƽ��','����',0.5,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'AST(SGOT)','����',39,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'ALT(SGPT)','����',35,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'������Ƽ��(y-GTP)','��',76,'1');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'B�������׿�','����',3,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'B��������ü','����',5.3,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'�����˻���','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2025/12/15',3,'��ι�缱�˻�','����',6.3,'0');


INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'����','����',175,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'ü��','����',64,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'�㸮�ѷ�','��',71,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'ü��������','����',18.6,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'�÷�(��)','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'�÷�(��)','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'û��(��)','����',116,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'û��(��)','����',150,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'����','����',131,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'��ܹ�','����',95,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'������','��',14.2,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'��������','����',80,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'���ݷ����׷�','����',135,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'HDL-�ݷ����׷�','����',132,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'Ʈ���۸������̵�','����',123,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'LDL-�ݷ����׷�','����',45,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'��ûũ����Ƽ��','����',0.6,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'AST(SGOT)','����',50,'1');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'ALT(SGPT)','����',35,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'������Ƽ��(y-GTP)','��',32,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'B�������׿�','����',3.3,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'B��������ü','����',2.3,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'�����˻���','����',1.5,'0');
INSERT INTO ȸ����ġ VALUES('2026/12/23',3,'��ι�缱�˻�','����',6.3,'0');




COMMIT;

