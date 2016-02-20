<cfset obj = createObject( 'component', 'weekfunctions' )/>
<cfset d = createDate( 1999, 12, 31 )/>
<cfoutput>
	<table>
		<thead>
			<tr>
				<th>
					Date
				</th>
				<th>
					ISO 8601
				</th>
				<th>
					Week()
				</th>
			</tr>
		</thead>
		<tbody>
			<cfloop from="1" to="365" index="i">
				<tr>
					<td>
						#lsDateFormat( dateAdd( 'd', i, d ), 'dd-mm-yyyy' )#
					</td>
					<td>
						#obj.dateInWeek( dateAdd( 'd', i, d ) ).week#
					</td>
					<td>
						#week( dateAdd( 'd', i, d ) )#
					</td>
				</tr>
			</cfloop>
		</tbody>
	</table>
</cfoutput>
