<#import "/templets/commonQuery/CommonQueryTagMacro.ftl" as CommonQueryMacro>
<#assign bean=JspTaglibs["/WEB-INF/struts-bean.tld"] />
<@CommonQueryMacro.page title="�ֹ�ִ������У��">
<@CommonQueryMacro.CommonQuery id="DataVerify" init="true" submitMode="all" navigate="false">
<table width="1000px" align="left">
<tr>
<td>
	<table width="100%">
		<tr>
   			<td valign="top" colspan="2">
   				<@CommonQueryMacro.Interface id="intface" label="�ֹ�ִ�н����ѯ" btnNm="�ֹ�ִ�н����ѯ" colNm=4 showButton="true" />
        	</td>
        </tr>
  		<tr>
      		<td colspan="2">
          			<@CommonQueryMacro.DataTable id="datatable1"  fieldStr="workDate,startTm,endTm,status,excemsg"  width="100%" hasFrame="true"/>
        	</td>
        </tr>
   </table>
    <span id="button-tools" style="padding-center:10px"><@CommonQueryMacro.Button id= "btDel"/>&nbsp;</span>
</@CommonQueryMacro.CommonQuery>
</td>
</tr>
</table>
<script language="javascript">

$('#DataVerify_interface_dataset_btnSubmit').after($('#button-tools'));
$(function(){
});
function btDel_onClickCheck(button) {
alert("��̨����ʱ��ϳ������ĵȴ�,10���Ӻ��ٲ�ѯ��");
btDel.disable(true);
 setTimeout(function (){
            btDel.disable(false)
        },600000);
        
   DataVerify_dataset.flushData(DataVerify_dataset.pageIndex);     
}
</script>
</@CommonQueryMacro.page>