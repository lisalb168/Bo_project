/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */
SELECT name 
FROM Facilities 
WHERE membercost > 0


/* Q2: How many facilities do not charge a fee to members? */
SELECT count(*)
FROM Facilities 
WHERE membercost = 0


/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost > 0 and membercost < 0.2*monthlymaintenance


/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */
SELECT * 
FROM Facilities
WHERE facid in (1,5)


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */
select name, monthlymaintenance,
       case when monthlymaintenance <= 100 then 'cheap'
            else 'expensive'
       end as label
from Facilities


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

/* First use a query to find the last joindate, then locate the customer
who signed up on this date, pull the first and last name of this customer */
select firstname, surname as lastname
from Members
where joindate in 
	(	
		SELECT max(joindate)
		FROM Members
	)


/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

/* Condition on tennis court 1 and 2 using where statement. Join 3 table sources
to link the member Id and facility ID */
SELECT m.memid, CONCAT(m.firstname, ', ', m.surname) as fullname, b.facid, f.name
FROM Members as m inner join
     Bookings as b on m.memid = b.memid inner join
     Facilities as f on b.facid=f.facid
where f.name in ('Tennis Court 1','Tennis Court 2')
group by 1,2,3,4
order by 2


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

/* Condition on the specific date. Calculate the cost for each booking and
filter out cost > 30 bookings. Keep starttime variable in the output to 
make sure these are not duplicate bookings. */
SELECT /*b.memid, b.slots,*/ b.starttime, /*f.facid,*/ f.name, /*f.guestcost, f.membercost,*/
       CONCAT(m.firstname, ', ', m.surname) as fullname,
       case when b.memid = 0 then f.guestcost*b.slots
            else f.membercost*b.slots
       end as cost
FROM Bookings AS b LEFT JOIN 
	 Facilities AS f ON b.facid = f.facid LEFT JOIN 
	 Members AS m ON b.memid = m.memid
WHERE substr(b.starttime, 1, 10) = '2012-09-14'
having cost > 30
order by cost desc


/* Q9: This time, produce the same result as in Q8, but using a subquery. */

/* Convert the previous solution into using a subquery */
select fac.name, sday.fullname, sday.starttime,
       case when sday.memid = 0 then sday.guestcost*sday.slots
            else sday.membercost*sday.slots
       end as cost

from Facilities AS fac

right join

(
SELECT b.memid, b.slots, b.starttime, f.facid, f.name, f.guestcost, f.membercost,
       CONCAT(m.firstname, ', ', m.surname) as fullname
FROM Bookings AS b LEFT JOIN 
	 Facilities AS f ON b.facid = f.facid LEFT JOIN 
	 Members AS m ON b.memid = m.memid
WHERE substr(b.starttime, 1, 10) = '2012-09-14'
) as sday

on fac.facid = sday.facid

having cost > 30
order by cost desc


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

/* Use a subquery to find out all the booking combinations by member ID, number of slots,
starttime, facility ID and facility name. Then calculate the revenue for each facility
and filter out revenue < 1000 facilities. Order by decending revenue. */
select fac.facid, fac.name, 
       sum(case when gpd.memid = 0 then fac.guestcost*gpd.slots
                else fac.membercost*gpd.slots
                end) as revenue
from Facilities as fac

	 right join

	(
   	 	SELECT b.memid, b.slots, b.starttime, f.facid, f.name
	
		FROM Bookings as b left join
			 Facilities as f on b.facid=f.facid left join
     	 	 Members as m on b.memid=m.memid
		group by 1,2,3,4,5
	) as gpd

	on fac.facid = gpd.facid

group by 1,2
having revenue < 1000
order by 3 desc



