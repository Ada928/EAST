<#import "/templets/commonQuery/CommonQueryTagMacro.ftl" as CommonQueryMacro>
<@CommonQueryMacro.page title="ǩԼ��Ϣ">
	<@CommonQueryMacro.CommonQueryTab id="BopCfaExplrmbloDsAuditTabs" navigate="false" currentTab="BopCfaExplrmbloDsAudit">
		<@CommonQueryMacro.CommonQuery id="BopCfaExplrmbloDsAudit" init="false" submitMode="selected" navigate="false" >
			<table align="left">
				<tr>
					<td colspan="2">
						<@CommonQueryMacro.Interface id="interface" label="�������ѯ����" />
					</td>
				</tr>
				<tr>
					<td>
						<@CommonQueryMacro.PagePilot id="ddresult" maxpagelink="9" showArrow="true" />
					</td>
	    		</tr>
	    		<tr>
	    			<td colspan="2">
						<@CommonQueryMacro.DataTable id ="BopCfaExplrmbloDsAuditTable" hasFrame="true" paginationbar="btApproved"
							fieldStr="select[60],filler2,workDate[100],actiontype,recStatus[70],approveStatus[70],repStatus[70],explrmblono[130],creditorcode,debtorcode[80],debtorname,valuedate[100],maturity[100],credconcurr[150],credconamount[100]" readonly="true" hasFrame="true" width="900" height="260"/>
	      			</td>
	    		</tr>

			    <tr>
		    		<td>
			    		<@CommonQueryMacro.FloatWindow id="aditADSubWindow" label="�����Ϣ" width="" resize="true" defaultZoom="normal" minimize="false" maximize="false" closure="true" float="true" exclusive="true" position="center" show="false" >
							<div align="center">
								<@CommonQueryMacro.Group id="group1" label="�����Ϣ" fieldStr="approveStatusChoose,approveResultChoose" colNm=2/>
								</br>
								<center>
									<@CommonQueryMacro.Button id= "btSave"/>&nbsp;&nbsp;
									<@CommonQueryMacro.Button id= "btClose"/>
								</center>
							</div>
						</@CommonQueryMacro.FloatWindow>
			    	</td>
			    </tr>

			</table>
		</@CommonQueryMacro.CommonQuery>
	</@CommonQueryMacro.CommonQueryTab>

	<script language="JavaScript">

		function initCallGetter_post(){
			<#assign workdate = statics["com.huateng.ebank.business.common.GlobalInfo"].getCurrentInstance().getTxdate()?default('')>
			BopCfaExplrmbloDsAudit_interface_dataset.setValue("qworkDate", "${workdate}");
			BopCfaExplrmbloDsAudit_interface_dataset.setValue("eworkDate", "${workdate}");	
		}
	
		//��ϵͳˢ�µ�Ԫ�������ʱ������
		function BopCfaExplrmbloDsAuditTable_filler2_onRefresh(cell,value,record) {
			if (record) {//�����ڼ�¼ʱ
				var id = record.getValue("id");
				var filler2 = record.getValue("filler2");
				cell.innerHTML = "<center><a style='text-decoration:none' href=\"JavaScript:doDetail('"+id+"')\">"+filler2+"</a></center>";
			} else {
				//�������ڼ�¼ʱ
			 	cell.innerHTML="&nbsp;";
			}
		}

		//��ѯ
		function doDetail(id){
			showWin("ǩԼ��Ϣ��ѯ","${contextPath}/fpages/datacollection/ftl/BopCfaExplrmbloDsAdd.ftl?op=detail&id="+id,"report","flushPage()");
		}

		//ˢ������
		function flushPage(){
			BopCfaExplrmbloDsAudit_dataset.flushData(1);
		}

		function btSave_postSubmit(buttno) {
			flushCurrentPage();
			alert("����ɹ�");
		}

		function btApproved_onClickCheck(button) {

			var hasSelected = false;
			var hasAudit = false;
			var record = BopCfaExplrmbloDsAudit_dataset.getFirstRecord();
			while(record){
				var v_selected = record.getValue("select");
				var v_approveStatus = record.getValue("approveStatus");
				if( v_selected == true ){
					hasSelected=true;
					if (v_approveStatus != "00") {
						hasAudit = true;
					}
				}
				record=record.getNextRecord();
	   		}
	   		if (!hasSelected) {
	   			alert("��ѡ����Ӧ�ļ�¼��");
	   			return false;
	  	 	}
	  	 	if (hasAudit) {
	   			if(!confirm("��ѡ��¼��������˼�¼��ȷ�������������")) {
					return false;
				}
	   		}
		}

		function btSave_onClickCheck(button) {

			var status = BopCfaExplrmbloDsAudit_dataset.getValue("approveStatusChoose");
			var result = BopCfaExplrmbloDsAudit_dataset.getValue("approveResultChoose");
			if (!status.length > 0) {
	   			alert("��ѡ����˽����");
	   			return false;
	   		}
	   		if (status == "02" && result.length < 1) {
	   			alert("��˽����ͨ�������˵��������д��");
	   			return false;
			}
			BopCfaExplrmbloDsAudit_dataset.setParameter("approveStatusChoose",status);
		   	BopCfaExplrmbloDsAudit_dataset.setParameter("approveResultChoose",result);
			subwindow_aditADSubWindow.close();
			return true;
		}

		//ˢ�µ�ǰҳ
		function flushCurrentPage() {
			BopCfaExplrmbloDsAudit_dataset.flushData(BopCfaExplrmbloDsAudit_dataset.pageIndex);
		}

		function btApproved_onClick() {
			subwindow_aditADSubWindow.show();
		}

		function btClose_onClick() {
			subwindow_aditADSubWindow.hide();
		}
	</script>
</@CommonQueryMacro.page>