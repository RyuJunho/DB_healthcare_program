SELECT DISTINCT ��ȯ.��ȯ��
FROM ��ȯ, ȸ����ġ
WHERE ��ȯ.�����׸� = ȸ����ġ.�����׸� AND
      ȸ����ġ.ID = '1' AND
      ȸ����ġ.�̻����� = '1' AND
      ȸ����ġ.�˻糯¥ = '2022/11/25';

-- User_suspected_disease ���ν��� : �̻� ��ġ�� ���� �ǽɵǴ� ������ �˷��ִ� ���ν���
-- ���� �̿Ϸ�
create or replace NONEDITIONABLE PROCEDURE USER_suspected_disease(
    Pi_�����׸� IN ��ȯ.�����׸�%TYPE,
    Po_�ǽ���ȯ OUT ��ȯ.��ȯ��%TYPE)
AS
BEGIN
    select ��ȯ�� INTO Po_�ǽ���ȯ
    from ��ȯ
    where �����׸� = Pi_�����׸�
    group by ��ȯ��;
END;


-- User_avg ���ν��� : ȸ�� ��ġ�� ����� ����ϴ� ���ν���
-- �����׸� ��ġ���� ���
CREATE OR REPLACE PROCEDURE User_avg (
    Pi_ID IN NUMBER,
    Pi_�����׸� IN NCHAR,
    Po_��հ� OUT NUMBER )
AS
BEGIN
    SELECT AVG(��ġ��) INTO Po_��հ�
    FROM (  SELECT ��ġ��
            FROM ȸ����ġ
            WHERE ID = Pi_ID AND
                  �����׸� = Pi_�����׸� );
END;

-- User_normal ���ν��� : ȸ�� ��ġ�� ���� ����(�ּ�����~�ְ�����)�� ���� 
--                       �������� �̻����� Ȯ���ϴ� ����� �����ϴ� ���ν���

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE User_normal(
    Pi_�����׸� IN NCHAR,
    Pi_������ IN NCHAR,
    Pi_��ġ�� IN NUMBER,
    Po_�̻����� OUT CHAR )
AS
    V_�ּ����� NUMBER(10);
    V_�ְ����� NUMBER(10);
BEGIN
    SELECT �ּ����� INTO V_�ּ�����
    FROM ��ȯ
    WHERE �����׸� = Pi_�����׸� AND
          ������ = Pi_������;
    SELECT �ְ����� INTO V_�ְ�����
    FROM ��ȯ
    WHERE �����׸� = Pi_�����׸� AND
          ������ = Pi_������;
    IF V_�ּ����� IS NULL THEN -- �ּ�/�ְ� ������ NULL�� ���
        BEGIN
            V_�ּ����� := 0;
        END;
    END IF;
    IF V_�ְ����� IS NULL THEN
        BEGIN
            V_�ְ����� := 1000;
        END;
    END IF;
    IF Pi_��ġ�� >= V_�ּ����� AND Pi_��ġ�� <= V_�ְ����� THEN -- �����ġ
        BEGIN
            Po_�̻����� := '0';
        END;
    ELSE    -- �̻��ġ
        BEGIN
            Po_�̻����� := '1';
        END;
    END IF;
END;

-- User_data_insert Ʈ���� : ȸ����ġ ���̺� �����Ͱ� INSERT ���� �� 
--                          User_normal ���ν����� ȣ���ϴ� Ʈ����
CREATE OR REPLACE TRIGGER User_data_insert
    BEFORE INSERT
    ON ȸ����ġ
    FOR EACH ROW
DECLARE
    V_�̻����� CHAR(1);
BEGIN
    User_normal(:NEW.�����׸�, :NEW.������, :NEW.��ġ��, V_�̻�����);
    :NEW.�̻����� := V_�̻�����;
END;


-- User_delete Ʈ���� : ȸ�� ���̺� �����Ͱ� DELETE �Ǹ� ȸ����ġ ���̺��� �����͵� ����
CREATE OR REPLACE TRIGGER User_delete
    AFTER DELETE
    ON ȸ��
    FOR EACH ROW
DECLARE
    --���� �����
BEGIN
    DELETE FROM ȸ����ġ WHERE ID = :OLD.ID;
END;
















