<#import "/templets/commonQuery/CommonQueryTagMacro.ftl" as CommonQueryMacro>
<#assign bean=JspTaglibs["/WEB-INF/struts-bean.tld"] />
<@CommonQueryMacro.page title="�����Ϣ">
<@CommonQueryMacro.CommonQueryTab id="bopForDebtFeiPerSaveTabs" navigate="false" currentTab="BopForDebtFeiPerSaveOver">
	<@CommonQueryMacro.CommonQuery id="bopForDebtFeiPerSaveOver" init="false" submitMode="current" navigate="false" >
		<table align="left">
			<tr>
				<td colspan="2">
					<@CommonQueryMacro.Interface id="interface"  label="�������ѯ����" />
				</td>
			</tr>
			<tr>
  			  	<td>
  			    	<@CommonQueryMacro.PagePilot id="pagePilot1" maxpagelink="9"   pageCache="false" showArrow="true"/>
  			  	</td>
  			  	<td align="right">
					<a href="javascript:btNewClick();"><@bean.message key="����" /></a>
	       		</td>
  			</tr>
  			<tr>
		      	<td colspan="2">
					<@CommonQueryMacro.DataTable id ="datatable1" fieldStr="opr[100],filler2,workDate[100],actiontype[80],recStatus[80],approveStatus[80],repStatus[80],exdebtcode[180],changeno,buscode,accoamount,chdate[85]" readonly="true" hasFrame="true" width="1000" height="260"/>
		      	</td>
      		</tr>
		</table>
	</@CommonQueryMacro.CommonQuery>
</@CommonQueryMacro.CommonQueryTab>
<script language="JavaScript">

	function initCallGetter_post(){
		var currentDate = "${statics["com.huateng.ebank.business.common.GlobalInfo"].getCurrentInstanceWithoutException().getTxdate()}";
		bopForDebtFeiPerSaveOver_interface_dataset.setValue("startdate", currentDate);
		bopForDebtFeiPerSaveOver_interface_dataset.setValue("enddate", currentDate);
	}

	//��ϵͳˢ�µ�Ԫ�������ʱ������
	function datatable1_opr_onRefresh(cell,value,record) {
		if (record) {//�����ڼ�¼ʱ
			var id = record.getValue("id");
			var recStatus = record.getValue("recStatus");
			var innerStr = "<center>";
			if (recStatus == "01" || recStatus == "02") {
				innerStr = innerStr + "<a href=\"JavaScript:doCollection('"+id+"')\">�޸�</a>&nbsp;&nbsp;<a href=\"JavaScript:doDelete('"+id+"')\">ɾ��</a>"
			} else {
				innerStr = innerStr + "<a title='�ü�¼״̬�����޸�' style='color:#999999'>�޸�</a>&nbsp;&nbsp;<a title='�ü�¼״̬����ɾ��' style='color:#999999'>ɾ��</a>";
			}
			innerStr = innerStr + "</center>";
			 
			cell.innerHTML =innerStr;
		} else {//�������ڼ�¼ʱ
		 	cell.innerHTML="&nbsp;";
		}
	}
	
	function datatable1_filler2_onRefresh(cell,value,record) {
		if (record) {//�����ڼ�¼ʱ
			var id = record.getValue("id");
			var filler2 = record.getValue("filler2");
			cell.innerHTML = "<a style='text-decoration:none' href=\"JavaScript:doDetail('"+id+"')\">" + filler2 + "</a>"
		} else {
			cell.innerHTML="&nbsp;";
		}
	}
	
	//����
	function btNewClick(){		
		showWin("�Ǿ�����˴�������Ϣ����","${contextPath}/fpages/datacollection/ftl/BopForDebtFeiPerSaveOverInfo.ftl?op=new","report","flushPage()");
	}
	
	//ˢ������
	function flushPage(){
		bopForDebtFeiPerSaveOver_dataset.flushData();
	}
	
	//�޸�
	function doCollection(id){
		showWin("�Ǿ�����˴�������Ϣ�޸�","${contextPath}/fpages/datacollection/ftl/BopForDebtFeiPerSaveOverInfo.ftl?id=" + id + "&op=modify","report","flushPage()");
	}
	
	//ɾ��
	function doDelete(id){
		showWin("�Ǿ�����˴�������Ϣɾ��","${contextPath}/fpages/datacollection/ftl/BopForDebtFeiPerSaveOverInfo.ftl?id=" + id + "&op=delete","report","flushPage()");
	}
	
	//��ϸ��Ϣ
	function doDetail(id){
		showWin("�Ǿ�����˴�������Ϣ��ϸ","${contextPath}/fpages/datacollection/ftl/BopForDebtFeiPerSaveOverInfo.ftl?id=" + id + "&op=detail");
	}
</script>
</@CommonQueryMacro.page>