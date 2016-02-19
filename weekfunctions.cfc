/**
*   Name: ISO 8601 Week Date Manipulator
*   Author: Nicholas Claaszen ( https://github.com/NicholasClaaszen && https://EquinoxCoding.com )
*   Date: 19/02/2016
*
*   Licensed under Creative Commons Attribution-ShareAlike 4.0 International
*   ( http://creativecommons.org/licenses/by-sa/4.0/ )
*
*   Any person dealing with the Software shall not misrepresent the source of the Software.
*
*   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
*   INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
*   PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
*   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
*   OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
*   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

component
	hint = "Functions for manipulating ISO 8601-compliant Week Dates"
{
	public struct function weekStartEnd( required string year, required string week, boolean skipCheck = false )
		hint = "Get the first and last day of a week in a specific year as a struct.
				Requires both the Year and the Week as integers."
	{
		if( isValid( 'integer', arguments.year ) && isValid( 'integer', arguments.week ) ) {
			/*
				Make sure that the weeknumber isn't out-of-bounds
			*/
			if( arguments.skipCheck || ( arguments.week GT 0 && arguments.week LTE this.weeksInYear( arguments.year ) ) ) {
				var r = {
					start: '',
					end: ''
				};
				/*
					January 4th is always in Week 1,
					https://en.wikipedia.org/wiki/ISO_week_date#Dates_with_fixed_week_number
				*/
				var anchor = createDate( arguments.year, 1, 4 );
				/*
					Find the monday that begins Week 1. As the 4th is always in week 1,
					either the 4th or an earlier date is monday.
				*/
				var x = anchor;
				var monday = '';
				while ( !len( monday ) ) {
					if( dayOfWeek( x ) EQ 2 ) {
						monday = x;
					} else {
						x = dateAdd( 'd', - 1, x );
					}
				}
				r.start = dateAdd( 'd', 7 * ( arguments.week - 1), monday );
				r.end = dateAdd( 'd', 6, r.start );
				return r;
			} else {
				if( arguments.week LTE 0 ) {
					throw( 'Requested week number #arguments.week# is negative or 0', 'Custom' );
				} else if ( arguments.week GT this.weeksInYear( arguments.year ) ) {
					throw( 'Requested week number #arguments.week# is out of bounds, #arguments.year#
							has #this.weeksInYear( arguments.year )# weeks.', 'Custom' );
				}
			}
		} else {
			throw( 'Arguments Year and Week to function weekStartEnd() must be integers', 'Custom' );
		}
	}

	public struct function dateInWeek( required string d )
		hint = "Return the weeknumber and year that weeknumber belongs to of a given date."
	{
		result = {
			week: 0,
			year: 0
		};

		if( isDate( arguments.d ) ) {
			result.year = year( arguments.d );
			/*
				Get the first week of the date's year's monday
			*/
			var fMon = this.weekStartEnd( result.year, 1, true ).start;

			/*
				If our date is earlier than the first monday, we have to look in last year
			*/
			if( dateCompare( arguments.d, fMon, 'd' ) EQ -1 ) {
				result.year -= 1;
				fMon = this.weekStartEnd( result.year, 1, true ).start;
			}
			/*
				How many days have passed since the first monay? Divide by 7 to get weeks, then floor it
			*/
			result.week = int( dateDiff( 'd', fMon, arguments.d ) / 7 ) + 1;

			return result;
		} else {
			throw( 'Argument d to function dateInWeek() must be a valid ColdFusion date', 'Custom' );
		}
	}

	public string function weeksInYear( required string y )
		hint = 'Returns the number of weeks in a given year.'
	{
		if( isValid( 'integer', y ) ) {
			var result = 0;
			var fMon = this.weekStartEnd( arguments.y, 1, true ).start;
			var lastDate = createDate( arguments.y, 12, 31 );

			result = int( dateDiff( 'd', fMon, lastDate ) / 7 ) + 1;

			return result;
		} else {
			throw( 'Argument y to function weeksInYear() must be a valid integer', 'Custom' );
		}
	}
}
