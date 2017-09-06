<#import "/templets/commonQuery/CommonQueryTagMacro.ftl" as CommonQueryMacro>
<#assign bean=JspTaglibs["/WEB-INF/struts-bean.tld"] />
<@CommonQueryMacro.page title="DataCheckResult.title">
<table width="1000px" align="left">
<tr>
<td>
<@CommonQueryMacro.CommonQuery id="DataCheckResult" init="true" submitMode="current">
	<table width="100%">
		<tr>
   			<td valign="top" colspan="2">
   				<@CommonQueryMacro.Interface id="intface" label="У������ѯ" colNm=4 showButton="true" />
        	</td>
        </tr>
		<tr>
   			<td>
   				<@CommonQueryMacro.PagePilot id="PagePilot"/>
   			</td>
  			
  		</tr>
  		<tr>
      		<td colspan="2">
          		<@CommonQueryMacro.DataTable id ="datatable1" fieldStr="id,tableName,tableDesc,columnName,columnDesc,errormsg,dataDate,opr" width="100%"  readonly="true"/></br>
        	</td>
        </tr>
 
   </table>
</@CommonQueryMacro.CommonQuery>
</td>
</tr>
</table>
<script language="javascript">
	//��λһ����¼
	function locate(tableName) {
		var record = DataCheckResult_dataset.find(["id"],[id]);
		if (record) {
			DataCheckResult_dataset.setRecord(record); 
		}
	}

	function datatable1_opr_onRefresh(cell, value, record)
	{
	
		if (record) {
		    var tableName = record.getValue("tableName");
		   cell.innerHTML="<center><a href=\"JavaScript:openData('"+tableName+"')\">��ϸ</a></center>";
		   //  cell.innerHTML="<center><a href=\"${contextPath}\/fpages\/datamodify\/ftl\/DataManageJgxxb.ftl\">��ϸ</a></center>";
			//cell.innerHTML="<center>��ϸ</center>";
		} else {//�������ڼ�¼ʱ
		 cell.innerHTML="&nbsp;";
		}	
	}
	
	function openData(tableName){
		if( tableName != null){
		   if (tableName == "EAST_YGB"){
		      window.location.href = "${contextPath}/fpages/datamodify/ftl/DataManageYgb.ftl";
		   } else if (id == "EAST_JGXXB"){
		      window.location.href = "${contextPath}/fpages/datamodify/ftl/DataManageJgxxb.ftl";
		   } else{
		   }
		} else{
		}
		
	}
</script>
</@CommonQueryMacro.page>