CREATE OR REPLACE PROCEDURE REPORT.EAST_DATECHK
AS
--���EAST�в��Ϲ���ֶΣ���ͳ����Ϣ���EAST_VERIF_RESULT����ϸ��Ϣ�����Ӧ����ʱ����������г��ֵĴ������EAST_PROCESS_LOG
   EAST_TABLE    EAST_JGBB.EAST_TABLE%TYPE;
   V_SQL         VARCHAR2 (500 CHAR);
   V_CNT_SQL     VARCHAR2 (500 CHAR);
   v_cnt          NUMBER;
   V_TBNAME      EAST_RULES.TABLE_NAME1%TYPE;
   V_ERRMSG      EAST_VERIF_RESULT.ERRORMSG%TYPE;
   --����У������־��¼ start
   V_WORK_DATE   EAST_PROCESS_LOG.WORK_DATE%TYPE;
   V_START_TM    EAST_PROCESS_LOG.START_TM%TYPE;
   V_END_TM      EAST_PROCESS_LOG.END_TM%TYPE;
   V_EXCEMSG     EAST_PROCESS_LOG.EXCEMSG%TYPE;
   --����У������־��¼ end
   V_TB_TMP      VARCHAR2 (50 CHAR);

   CURSOR CUR_JGBB
   IS
      SELECT * FROM EAST_JGBB;

   CURSOR CUR_CHECKLEN
   IS
      SELECT *
        FROM EAST_RULES
       WHERE TABLE_NAME1 = EAST_TABLE AND CHECK_LENGTH = 'Y';

   CURSOR CUR_CHECKENUM
   IS
      SELECT *
        FROM EAST_RULES
       WHERE TABLE_NAME1 = EAST_TABLE AND ISENUM = 'Y';

   CURSOR CUR_CHECKINT
   IS
      SELECT *
        FROM EAST_RULES
       WHERE TABLE_NAME1 = east_table AND ISINT = 'Y';
       
     CURSOR CUR_CHECKDATE
   IS
      SELECT *
        FROM EAST_RULES
       WHERE TABLE_NAME1 = east_table AND ISDATE = 'Y'; 
       
   CURSOR CUR_CHECKTIME
   IS
      SELECT *
        FROM EAST_RULES
       WHERE TABLE_NAME1 = east_table AND ISTIME = 'Y';  
        

BEGIN
   --У��ǰ���������ʱ�����־��
   DELETE FROM EAST_VERIF_RESULT;
   DELETE FROM EAST_CZXX_TMP;

   DELETE FROM EAST_DBGX_TMP;

   DELETE FROM EAST_DGBWSXYW_TMP;

   DELETE FROM EAST_DGDQCKFHZMXJL_TMP;

   DELETE FROM EAST_DGDQCKFHZ_TMP;

   DELETE FROM EAST_DGHQCKFHZMXJL_TMP;

   DELETE FROM EAST_DGHQCKFHZ_TMP;

   DELETE FROM EAST_DGKH_TMP;

   DELETE FROM EAST_DGXDFHZMXJL_TMP;

   DELETE FROM EAST_DGXDFHZ_TMP;

   DELETE FROM EAST_DGXDYWJJ_TMP;

   DELETE FROM EAST_DKHX_TMP;

   DELETE FROM EAST_DKWJXTBD_TMP;

   DELETE FROM EAST_DKZQ_TMP;

   DELETE FROM EAST_GDXX_TMP;

   DELETE FROM EAST_GLGX_TMP;

   DELETE FROM EAST_GRDQCKFHZMXJL_TMP;

   DELETE FROM EAST_GRDQCKFHZ_TMP;

   DELETE FROM EAST_GRHQCKFHZMXJL_TMP;

   DELETE FROM EAST_GRHQCKFHZ_TMP;

   DELETE FROM EAST_GRJCXX_TMP;

   DELETE FROM EAST_GRKHGXXX_TMP;

   DELETE FROM EAST_GRXDFHZMXJL_TMP;

   DELETE FROM EAST_GRXDFHZ_TMP;

   DELETE FROM EAST_GRXDYWJJ_TMP;

   DELETE FROM EAST_GWXXB_TMP;

   DELETE FROM EAST_GYB_TMP;

   DELETE FROM EAST_HLXXB_TMP;

   DELETE FROM EAST_JGGXB_TMP;

   DELETE FROM EAST_JGXXB_TMP;

   DELETE FROM EAST_JJKXX_TMP;

   DELETE FROM EAST_JRGJXXB_TMP;

   DELETE FROM EAST_JYLS_TMP;

   DELETE FROM EAST_KHLCZHXXB_TMP;

   DELETE FROM EAST_LCCPXSMX_TMP;

   DELETE FROM EAST_LCCPXXB_TMP;

   DELETE FROM EAST_LCCPZTB_TMP;

   DELETE FROM EAST_MYRZYWXXB_TMP;

   DELETE FROM EAST_NBFHZMXJL_TMP;

   DELETE FROM EAST_NBFHZ_TMP;

   DELETE FROM EAST_NBKMDZB_TMP;

   DELETE FROM EAST_PJPMXXB_TMP;

   DELETE FROM EAST_SNTJB_TMP;

   DELETE FROM EAST_SXXX_TMP;

   DELETE FROM EAST_WTDK_TMP;

   DELETE FROM EAST_XDHTB_TMP;

   DELETE FROM EAST_XDYWDBHT_TMP;

   DELETE FROM EAST_XDYWZHDYW_TMP;

   DELETE FROM EAST_XDZCZR_TMP;

   DELETE FROM EAST_XMDKXXB_TMP;

   DELETE FROM EAST_XYKXX_TMP;

   DELETE FROM EAST_XYKZHJYMXB_TMP;

   DELETE FROM EAST_YGB_TMP;

   DELETE FROM EAST_YTDK_TMP;

   DELETE FROM EAST_ZCFZKMTJB_TMP;

   DELETE FROM EAST_ZCZRGXB_TMP;

   DELETE FROM EAST_ZJJYXXB_TMP;

   DELETE FROM EAST_ZZHJQKMB_TMP;

   DELETE FROM EAST_PROCESS_LOG;

   ---��Ӵ�����־��Ϣ
   V_EXCEMSG := '';                                                    --��ʼ��Ϊ��

   --��У���ڣ���ʼʱ��
   SELECT TO_CHAR (SYSDATE, 'YYYYMMDD'),
          TO_CHAR (SYSDATE, 'HH24MISS')
     INTO V_WORK_DATE, V_START_TM
     FROM DUAL;

   INSERT INTO EAST_PROCESS_LOG (PRO_ID,
                                 WORK_DATE,
                                 START_TM,
                                 STATUS)
        VALUES ('EAST',
                V_WORK_DATE,
                V_START_TM,
                '0:������');

   COMMIT;

   FOR V_JGBB IN CUR_JGBB
   LOOP
      EAST_TABLE := V_JGBB.EAST_TABLE;

  
      DBMS_OUTPUT.PUT_LINE ('��ʼ�ֶγ��ȼ��');
      FOR V_CUR_CHECKLEN IN CUR_CHECKLEN
      LOOP

         V_TBNAME := V_CUR_CHECKLEN.TABLE_NAME1;
         V_SQL :=
               'SELECT * FROM '
            || V_CUR_CHECKLEN.TABLE_NAME1
            || ' WHERE '
            || V_CUR_CHECKLEN.COLUMN_NAME1
            || ' IS NOT NULL AND '
            || 'LENGTH('
            || V_CUR_CHECKLEN.COLUMN_NAME1
            || ')'
            || V_CUR_CHECKLEN.LENGTH;
           V_CNT_SQL :=
               'SELECT COUNT(*) FROM '
            || V_CUR_CHECKLEN.TABLE_NAME1
            || ' WHERE '
            || V_CUR_CHECKLEN.COLUMN_NAME1
            || ' IS NOT NULL AND '
            || 'LENGTH('
            || V_CUR_CHECKLEN.COLUMN_NAME1
            || ')'
            || V_CUR_CHECKLEN.LENGTH;  
         DBMS_OUTPUT.PUT_LINE ('�ֶγ���V_SQL==' || V_SQL);
         V_ERRMSG := V_CUR_CHECKLEN.COLUMN_NAME1 || '�ֶγ��Ȳ��Ϲ�';
         EAST_MXCL (V_TBNAME, V_SQL, V_ERRMSG);
         -----ͳ�ƻ������--------
         EXECUTE IMMEDIATE V_CNT_SQL INTO v_cnt;
                 --�ǼǴ�����Ϣ
         IF v_cnt != 0
            THEN
             V_ERRMSG :='�ܹ���'||v_cnt ||'�������ֶγ��Ȳ����Ϲ涨';
              LOG_CHECK_ERROR (V_CUR_CHECKLEN,v_errmsg);
        END IF;
      END LOOP;

       DBMS_OUTPUT.PUT_LINE ('��ʼ�ֶ�ö�ټ��' );
      FOR V_CUR_CHECKENUM IN CUR_CHECKENUM
      LOOP
         --DBMS_OUTPUT.PUT_LINE ('V_CUR_CHECKENUM START:' || V_CUR_CHECKENUM.TABLE_NAME1);
         V_TBNAME := V_CUR_CHECKENUM.TABLE_NAME1;
         --�ֶ�ֵö�ټ��
            V_SQL :=
                  'SELECT * FROM '
               || V_CUR_CHECKENUM.TABLE_NAME1
               || ' WHERE '
               || V_CUR_CHECKENUM.COLUMN_NAME1
               || ' IS NOT NULL AND '
               ||V_CUR_CHECKENUM.COLUMN_NAME1
               || ' NOT IN '
               || V_CUR_CHECKENUM.ENUM_VALUE;
               
            V_CNT_SQL :=
                  'SELECT COUNT(*) FROM '
               || V_CUR_CHECKENUM.TABLE_NAME1
               || ' WHERE '
               || V_CUR_CHECKENUM.COLUMN_NAME1
               || ' IS NOT NULL AND '
               ||V_CUR_CHECKENUM.COLUMN_NAME1
               || ' NOT IN '
               || V_CUR_CHECKENUM.ENUM_VALUE;
               DBMS_OUTPUT.PUT_LINE ('�ֶ�ö��V_SQL==' || V_SQL);
              V_ERRMSG := V_CUR_CHECKENUM.COLUMN_NAME1 || '�ֶβ��ǹ涨��ö��ֵ';
              EAST_MXCL (V_TBNAME, V_SQL, V_ERRMSG);
               -----ͳ�ƻ������--------
         EXECUTE IMMEDIATE V_CNT_SQL INTO v_cnt;
                 --�ǼǴ�����Ϣ
         IF v_cnt != 0
            THEN
             V_ERRMSG :='�ܹ���'||v_cnt ||'�������ֶβ��ǹ涨��ö��ֵ';
              LOG_CHECK_ERROR (V_CUR_CHECKENUM,v_errmsg);
        END IF;
      END LOOP;

      DBMS_OUTPUT.PUT_LINE ('��ʼ�ֶ��������' );
      FOR V_CUR_CHECKINT IN CUR_CHECKINT
      LOOP
         --DBMS_OUTPUT.PUT_LINE ('V_CUR_CHECKENUM START:' || V_CUR_CHECKENUM.TABLE_NAME1);
         V_TBNAME := V_CUR_CHECKINT.TABLE_NAME1;
          V_SQL  :=
            'SELECT * FROM '
         || V_CUR_CHECKINT.TABLE_NAME1
         || ' WHERE not regexp_like('
         || V_CUR_CHECKINT.COLUMN_NAME1
         || ','
         || '''(^[1-9][0-9]{0,}$)'''
         || ')  AND '
         || V_CUR_CHECKINT.COLUMN_NAME1
         || '  IS NOT NULL ';
         
           V_CNT_SQL  :=
            'SELECT COUNT(*) FROM '
         || V_CUR_CHECKINT.TABLE_NAME1
         || ' WHERE not regexp_like('
         || V_CUR_CHECKINT.COLUMN_NAME1
         || ','
         || '''(^[1-9][0-9]{0,}$)'''
         || ')  AND '
         || V_CUR_CHECKINT.COLUMN_NAME1
         || '  IS NOT NULL ';
          DBMS_OUTPUT.PUT_LINE ('�ֶ�����V_SQL==' || V_SQL);
          V_ERRMSG := V_CUR_CHECKINT.COLUMN_NAME1||'��ֵ��������';
              DBMS_OUTPUT.PUT_LINE (V_SQL||';');
              EAST_MXCL (V_TBNAME, V_SQL, V_ERRMSG);
              
                     -----ͳ�ƻ������--------
         EXECUTE IMMEDIATE V_CNT_SQL INTO v_cnt;
                 --�ǼǴ�����Ϣ
         IF v_cnt != 0
            THEN
             V_ERRMSG :='�ܹ���'||v_cnt ||'�������ֶ���ֵ��������';
              LOG_CHECK_ERROR (V_CUR_CHECKINT,V_ERRMSG);
        END IF;
      END LOOP;
      
      
      
       DBMS_OUTPUT.PUT_LINE ('��ʼ�ֶ����ڸ�ʽ���' );
      FOR V_CUR_CHECKDATE IN CUR_CHECKDATE
      LOOP
         --DBMS_OUTPUT.PUT_LINE ('V_CUR_CHECKENUM START:' || V_CUR_CHECKENUM.TABLE_NAME1);
         V_TBNAME := V_CUR_CHECKDATE.TABLE_NAME1;
                 V_SQL  :=
            'SELECT * FROM '
         || V_CUR_CHECKDATE.TABLE_NAME1
         || ' WHERE not regexp_like('
         || V_CUR_CHECKDATE.COLUMN_NAME1
         || ','
         || '''((\d{3}[^0]|[^0]\d{3})(0[^0]0[1-9]|0[^0]1[0-9]|0[^0]2[0-8]|1[0-2]0[1-9]|1[0-2]1[0-9]|1[0-2]2[0-8]|0[13-9]29|1[0-2]29|0[13-9]30|1[0-2]30|0[13578]31|1[02]31)|\d{2}0[48]0229|\d{2}[2468][048]0229|\d{2}[13579][26]0229|0[48]000229|[13579][26]000229|[2468][048]000229)'''
         || ')  AND '
         || V_CUR_CHECKDATE.COLUMN_NAME1
         || '  IS NOT NULL ';
         
                   V_CNT_SQL  :=
            'SELECT COUNT(*) FROM '
         || V_CUR_CHECKDATE.TABLE_NAME1
         || ' WHERE not regexp_like('
         || V_CUR_CHECKDATE.COLUMN_NAME1
         || ','
         || '''((\d{3}[^0]|[^0]\d{3})(0[^0]0[1-9]|0[^0]1[0-9]|0[^0]2[0-8]|1[0-2]0[1-9]|1[0-2]1[0-9]|1[0-2]2[0-8]|0[13-9]29|1[0-2]29|0[13-9]30|1[0-2]30|0[13578]31|1[02]31)|\d{2}0[48]0229|\d{2}[2468][048]0229|\d{2}[13579][26]0229|0[48]000229|[13579][26]000229|[2468][048]000229)'''
         || ')  AND '
         || V_CUR_CHECKDATE.COLUMN_NAME1
         || '  IS NOT NULL ';
          DBMS_OUTPUT.PUT_LINE ('�ֶ�����V_SQL==' || V_SQL);
          V_ERRMSG := V_CUR_CHECKDATE.COLUMN_NAME1||'��ֵ����YYYYMMDD���ڸ�ʽ';
              DBMS_OUTPUT.PUT_LINE (V_SQL||';');
              EAST_MXCL (V_TBNAME, V_SQL, V_ERRMSG);
              
                 -----ͳ�ƻ������--------
         EXECUTE IMMEDIATE V_CNT_SQL INTO v_cnt;
                 --�ǼǴ�����Ϣ
         IF v_cnt != 0
            THEN
             V_ERRMSG :='�ܹ���'||v_cnt ||'�������ֶ���ֵ����YYYYMMDD���ڸ�ʽ';
              LOG_CHECK_ERROR (V_CUR_CHECKDATE,V_ERRMSG);
        END IF;
      END LOOP;
      
             DBMS_OUTPUT.PUT_LINE ('��ʼ�ֶ�ʱ���ʽ���' );
      FOR V_CUR_CHECKTIME IN CUR_CHECKTIME
      LOOP
         --DBMS_OUTPUT.PUT_LINE ('V_CUR_CHECKENUM START:' || V_CUR_CHECKENUM.TABLE_NAME1);
         V_TBNAME := V_CUR_CHECKTIME.TABLE_NAME1;
                 V_SQL  :=
            'SELECT * FROM '
         || V_CUR_CHECKTIME.TABLE_NAME1
         || ' WHERE not regexp_like('
         || V_CUR_CHECKTIME.COLUMN_NAME1
         || ','
         || '''(^([0-1][0-9]|[2][0-3])([0-5][0-9])([0-5][0-9])$)'''
         || ')  AND '
         || V_CUR_CHECKTIME.COLUMN_NAME1
         || '  IS NOT NULL ';
         
         V_CNT_SQL :=
            'SELECT COUNT(*) FROM '
         || V_CUR_CHECKTIME.TABLE_NAME1
         || ' WHERE not regexp_like('
         || V_CUR_CHECKTIME.COLUMN_NAME1
         || ','
         || '''(^([0-1][0-9]|[2][0-3])([0-5][0-9])([0-5][0-9])$)'''
         || ')  AND '
         || V_CUR_CHECKTIME.COLUMN_NAME1
         || '  IS NOT NULL ';
          DBMS_OUTPUT.PUT_LINE ('�ֶ�ʱ��V_SQL==' || V_SQL);
          V_ERRMSG := V_CUR_CHECKTIME.COLUMN_NAME1||'��ֵ����ʱ��HHMMSS��ʽ';
              DBMS_OUTPUT.PUT_LINE (V_SQL||';');
             EAST_MXCL (V_TBNAME, V_SQL, V_ERRMSG);
             
                      -----ͳ�ƻ������--------
         EXECUTE IMMEDIATE V_CNT_SQL INTO v_cnt;
                 --�ǼǴ�����Ϣ
         IF v_cnt != 0
            THEN
             V_ERRMSG :='�ܹ���'||v_cnt ||'�������ֶ���ֵ����ʱ��HHMMSS��ʽ';
              LOG_CHECK_ERROR (V_CUR_CHECKTIME,V_ERRMSG);
        END IF;
      END LOOP;
   END LOOP;
   select TO_CHAR(SYSDATE,'HH24MISS') INTO    V_END_TM from dual;
  UPDATE  EAST_PROCESS_LOG SET  END_TM= V_END_TM,status='1-�������';
   COMMIT;
   EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.put_line('sqlcode : ' ||sqlcode);
DBMS_OUTPUT.put_line('sqlerrm :' ||sqlerrm);
V_EXCEMSG :=V_SQL||'--'|| sqlcode ||'----'||sqlerrm;
  UPDATE  EAST_PROCESS_LOG SET EXCEMSG =EXCEMSG||';'||V_EXCEMSG;
  COMMIT;
END;
/