<#import "/templets/commonQuery/CommonQueryTagMacro.ftl" as CommonQueryMacro>
<@CommonQueryMacro.page title="��������">
<table width="800px" align="left">
<tr>
<td>
<@CommonQueryMacro.CommonQuery id="DataManage" init="true" submitMode="current">
	<table width="100%">
		<tr>
   			<td valign="top" colspan="2">
   				<@CommonQueryMacro.Interface id="intface" label="���ݲ�ѯ" colNm=4 showButton="true" />
        	</td>
        </tr>
		<tr>
   			<td>
   				<@CommonQueryMacro.PagePilot id="PagePilot"/>
   			</td>
  			
  		</tr>
  		<tr>
      		<td colspan="2">
          		<@CommonQueryMacro.DataTable id ="datatable1" paginationbar="btAdd,-,btStatus" fieldStr="brno,brname,brclass,status,st,opr" width="100%"  readonly="true"/></br>
        	</td>
        </tr>
   </table>
</@CommonQueryMacro.CommonQuery>
</td>
</tr>
</table>