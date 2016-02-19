<cfscript>
	obj = createObject( 'component', 'weekfunctions' );
</cfscript>
<cfoutput>
	<div>
		<h1>
			weekStartEnd()
		</h1>
		<ul>
			<li>
				First week of 2016:
				<cftry>
					<cfdump var="#obj.weekStartEnd( 2016, 1 )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				Last week of 2015:
				<cftry>
					<cfdump var="#obj.weekStartEnd( 2015, 53 )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				Week out of bounds (high):
				<cftry>
					<cfdump var="#obj.weekStartEnd( 2015, 54 )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				Week out of bounds (zero):
				<cftry>
					<cfdump var="#obj.weekStartEnd( 2015, 0 )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				Week out of bounds (low):
				<cftry>
					<cfdump var="#obj.weekStartEnd( 2015, -2 )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
		</ul>
	</div>
	<div>
		<h1>
			dateInWeek()
		</h1>
		<ul>
			<li>
				Jan 1st 2016 ( should be: week 53 in 2015 )
				<cftry>
					<cfdump var="#obj.dateInWeek( createDate( 2016, 1, 1 ) )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				Jan 4th 2016 ( should be: week 1 in 2016 )
				<cftry>
					<cfdump var="#obj.dateInWeek( createDate( 2016, 1, 4 ) )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				now()
				<cftry>
					<cfdump var="#obj.dateInWeek( now() )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				Invalid date
				<cftry>
					<cfdump var="#obj.dateInWeek( 'notADate' )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
		</ul>
	</div>
	<div>
		<h1>
			weeksInYear()
		</h1>
		<ul>
			<li>
				2015 ( should be: 53 )
				<cftry>
					<cfdump var="#obj.weeksInYear( 2015 )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				2016 ( should be: 52 )
				<cftry>
					<cfdump var="#obj.weeksInYear( 2016 )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
			<li>
				Invalid year
				<cftry>
					<cfdump var="#obj.weeksInYear( 'notAnInteger' )#"/>
					<cfcatch>
						<cfdump var="#cfcatch.message#"/>
					</cfcatch>
				</cftry>
			</li>
		</ul>
	</div>
</cfoutput>
