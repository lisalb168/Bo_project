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


/*results -
"name"
"Tennis Court 1"
"Tennis Court 2"
"Massage Room 1"
"Massage Room 2"
"Squash Court"
*/



/* Q2: How many facilities do not charge a fee to members? */
SELECT count(*)
FROM Facilities 
WHERE membercost = 0


/*results -
count(*)
      4
*/



/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost > 0 AND membercost < 0.2 * monthlymaintenance


/*results -
"facid" "name"  "membercost"  "monthlymaintenance"
"0" "Tennis Court 1"  "5.0" "200"
"1" "Tennis Court 2"  "5.0" "200"
"4" "Massage Room 1"  "9.9" "3000"
"5" "Massage Room 2"  "9.9" "3000"
"6" "Squash Court"  "3.5" "80"
*/



/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */
SELECT * 
FROM Facilities
WHERE facid IN (1,5)


/*results -
"facid" "name"  "membercost"  "guestcost" "initialoutlay" "monthlymaintenance"
"1" "Tennis Court 2"  "5.0" "25.0"  "8000"  "200"
"5" "Massage Room 2"  "9.9" "80.0"  "4000"  "3000"
*/



/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */
SELECT name, monthlymaintenance,
       CASE WHEN monthlymaintenance <= 100 THEN 'cheap'
            ELSE 'expensive'
       END AS label
FROM Facilities


/*results -
"name"  "monthlymaintenance"  "label"
"Tennis Court 1"  "200" "expensive"
"Tennis Court 2"  "200" "expensive"
"Badminton Court" "50"  "cheap"
"Table Tennis"  "10"  "cheap"
"Massage Room 1"  "3000"  "expensive"
"Massage Room 2"  "3000"  "expensive"
"Squash Court"  "80"  "cheap"
"Snooker Table" "15"  "cheap"
"Pool Table"  "15"  "cheap"
*/



/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

/* First use a query to find the last joindate, then locate the customer
who signed up on this date, pull the first and last name of this customer */
SELECT firstname, surname AS lastname
FROM Members
WHERE joindate IN 
	(	
		SELECT max(joindate)
		FROM Members
	)


/*results - 
"firstname" "lastname"
"Darren"  "Smith"
*/



/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

/* Condition on tennis court 1 and 2 using where statement. Join 3 table sources
to link the member Id and facility ID */
SELECT M.memid, CONCAT(M.firstname, ', ', M.surname) AS Fullname, B.facid, F.name
FROM Members AS M
     INNER JOIN Bookings AS B ON M.memid = B.memid 
     INNER JOIN Facilities AS F ON B.facid = F.facid
WHERE F.name IN ('Tennis Court 1','Tennis Court 2')
GROUP BY M.memid, Fullname, B.facid, F.name
ORDER BY Fullname


/*results -
"memid" "Fullname"  "facid" "name"
"12"  "Anne, Baker" "1" "Tennis Court 2"
"12"  "Anne, Baker" "0" "Tennis Court 1"
"6" "Burton, Tracy" "1" "Tennis Court 2"
"6" "Burton, Tracy" "0" "Tennis Court 1"
"10"  "Charles, Owen" "1" "Tennis Court 2"
"10"  "Charles, Owen" "0" "Tennis Court 1"
"1" "Darren, Smith" "1" "Tennis Court 2"
"28"  "David, Farrell"  "0" "Tennis Court 1"
"28"  "David, Farrell"  "1" "Tennis Court 2"
"11"  "David, Jones"  "1" "Tennis Court 2"
"11"  "David, Jones"  "0" "Tennis Court 1"
"17"  "David, Pinker" "0" "Tennis Court 1"
"26"  "Douglas, Jones"  "0" "Tennis Court 1"
"36"  "Erica, Crumpet"  "0" "Tennis Court 1"
"15"  "Florence, Bader" "1" "Tennis Court 2"
"15"  "Florence, Bader" "0" "Tennis Court 1"
"5" "Gerald, Butters" "1" "Tennis Court 2"
"5" "Gerald, Butters" "0" "Tennis Court 1"
"0" "GUEST, GUEST"  "0" "Tennis Court 1"
"0" "GUEST, GUEST"  "1" "Tennis Court 2"
"27"  "Henrietta, Rumney" "1" "Tennis Court 2"
"14"  "Jack, Smith" "1" "Tennis Court 2"
"14"  "Jack, Smith" "0" "Tennis Court 1"
"4" "Janice, Joplette"  "0" "Tennis Court 1"
"4" "Janice, Joplette"  "1" "Tennis Court 2"
"13"  "Jemima, Farrell" "0" "Tennis Court 1"
"13"  "Jemima, Farrell" "1" "Tennis Court 2"
"22"  "Joan, Coplin"  "0" "Tennis Court 1"
"35"  "John, Hunt"  "1" "Tennis Court 2"
"35"  "John, Hunt"  "0" "Tennis Court 1"
"20"  "Matthew, Genting"  "0" "Tennis Court 1"
"30"  "Millicent, Purview"  "1" "Tennis Court 2"
"7" "Nancy, Dare" "1" "Tennis Court 2"
"7" "Nancy, Dare" "0" "Tennis Court 1"
"9" "Ponder, Stibbons"  "0" "Tennis Court 1"
"9" "Ponder, Stibbons"  "1" "Tennis Court 2"
"24"  "Ramnaresh, Sarwin" "0" "Tennis Court 1"
"24"  "Ramnaresh, Sarwin" "1" "Tennis Court 2"
"8" "Tim, Boothe" "0" "Tennis Court 1"
"8" "Tim, Boothe" "1" "Tennis Court 2"
"3" "Tim, Rownam" "1" "Tennis Court 2"
"3" "Tim, Rownam" "0" "Tennis Court 1"
"16"  "Timothy, Baker"  "1" "Tennis Court 2"
"16"  "Timothy, Baker"  "0" "Tennis Court 1"
"2" "Tracy, Smith"  "0" "Tennis Court 1"
"2" "Tracy, Smith"  "1" "Tennis Court 2"
*/



/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

/* Condition on the specific date. Calculate the cost for each booking and
filter out cost > 30 bookings. Keep starttime variable in the output to 
make sure these are not duplicate bookings. */
/*
SELECT b.memid, b.slots, b.starttime, f.facid, f.name, f.guestcost, f.membercost,
       concat(m.firstname, ', ', m.surname) AS fullname,
       CASE WHEN b.memid = 0 THEN f.guestcost*b.slots
            ELSE f.membercost*b.slots
       END AS cost
FROM Bookings AS b LEFT JOIN 
	 Facilities AS f ON b.facid = f.facid LEFT JOIN 
	 Members AS m ON b.memid = m.memid
WHERE substr(b.starttime, 1, 10) = '2012-09-14'
HAVING cost > 30
ORDER BY cost DESC
*/

SELECT F.name AS FacilityName,
       CONCAT(M.firstname, ', ', M.surname) AS Fullname,     
       CASE WHEN B.memid = 0 THEN F.guestcost * B.slots
            ELSE F.membercost * B.slots
       END AS Cost
FROM Bookings as B 
     INNER JOIN Facilities AS F ON B.facid = F.facid 
     INNER JOIN Members AS M ON B.memid = M.memid
WHERE SUBSTR(B.starttime, 1, 10) = '2012-09-14' AND 
      (
        CASE WHEN B.memid = 0 THEN F.guestcost * B.slots
             ELSE F.membercost * B.slots
             END
      ) > 30

ORDER BY Cost DESC


/*results -
"FacilityName"  "Fullname"  "Cost"
"Massage Room 2"  "GUEST, GUEST"  "320.0"
"Massage Room 1"  "GUEST, GUEST"  "160.0"
"Massage Room 1"  "GUEST, GUEST"  "160.0"
"Massage Room 1"  "GUEST, GUEST"  "160.0"
"Tennis Court 2"  "GUEST, GUEST"  "150.0"
"Tennis Court 1"  "GUEST, GUEST"  "75.0"
"Tennis Court 2"  "GUEST, GUEST"  "75.0"
"Tennis Court 1"  "GUEST, GUEST"  "75.0"
"Squash Court"  "GUEST, GUEST"  "70.0"
"Massage Room 1"  "Jemima, Farrell" "39.6"
"Squash Court"  "GUEST, GUEST"  "35.0"
"Squash Court"  "GUEST, GUEST"  "35.0"
*/



/* Q9: This time, produce the same result as in Q8, but using a subquery. */

/* Convert the previous solution into using a subquery */
/*
SELECT fac.name, sday.fullname, sday.starttime,
       CASE WHEN sday.memid = 0 THEN sday.guestcost*sday.slots
            ELSE sday.membercost*sday.slots
       END AS cost

FROM Facilities AS fac

RIGHT JOIN

(
SELECT b.memid, b.slots, b.starttime, f.facid, f.name, f.guestcost, f.membercost,
       concat(m.firstname, ', ', m.surname) AS fullname
FROM Bookings AS b LEFT JOIN 
	 Facilities AS f ON b.facid = f.facid LEFT JOIN 
	 Members AS m ON b.memid = m.memid
WHERE substr(b.starttime, 1, 10) = '2012-09-14'
) AS sday

ON fac.facid = sday.facid

HAVING cost > 30
ORDER BY cost DESC
*/

SELECT *
FROM (
        SELECT F.name AS FacilityName,
               CONCAT(M.firstname, ', ', M.surname) AS Fullname,     
               CASE WHEN B.memid = 0 THEN F.guestcost * B.slots
                    ELSE F.membercost * B.slots
               END AS Cost
        FROM Bookings as B 
             INNER JOIN Facilities AS F ON B.facid = F.facid 
             INNER JOIN Members AS M ON B.memid = M.memid
        WHERE SUBSTR(B.starttime, 1, 10) = '2012-09-14'
      ) AS T

WHERE T.Cost > 30
ORDER BY T.Cost DESC


/*results -
"FacilityName"  "Fullname"  "Cost"
"Massage Room 2"  "GUEST, GUEST"  "320.0"
"Massage Room 1"  "GUEST, GUEST"  "160.0"
"Massage Room 1"  "GUEST, GUEST"  "160.0"
"Massage Room 1"  "GUEST, GUEST"  "160.0"
"Tennis Court 2"  "GUEST, GUEST"  "150.0"
"Tennis Court 1"  "GUEST, GUEST"  "75.0"
"Tennis Court 2"  "GUEST, GUEST"  "75.0"
"Tennis Court 1"  "GUEST, GUEST"  "75.0"
"Squash Court"  "GUEST, GUEST"  "70.0"
"Massage Room 1"  "Jemima, Farrell" "39.6"
"Squash Court"  "GUEST, GUEST"  "35.0"
"Squash Court"  "GUEST, GUEST"  "35.0"
*/



/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

/* Use a subquery to find out all the booking combinations by member ID, number of slots,
starttime, facility ID and facility name. Then calculate the revenue for each facility
and filter out revenue < 1000 facilities. Order by decending revenue. */
/*
SELECT FAC.facid, FAC.name, 
       SUM(CASE WHEN GPD.memid = 0 THEN FAC.guestcost * GPD.slots
                ELSE FAC.membercost * GPD.slots
                END) AS Revenue
FROM Facilities AS FAC

	 RIGHT JOIN

	(
   	SELECT B.memid, B.slots, B.starttime, F.facid, F.name
	
		FROM Bookings AS B LEFT JOIN
			   Facilities AS F ON B.facid = F.facid LEFT JOIN
     	 	 Members AS M ON B.memid = M.memid
		GROUP BY memid, slots, starttime, facid, name
	) AS GPD

	ON FAC.facid = PGD.facid

GROUP BY facid, name
HAVING Revenue < 1000
ORDER BY Revenue DESC
*/


SELECT GPD.Facid, GPD.Name, FAC.Revenue
FROM 

    (
       SELECT F.facid, F.name
       FROM Bookings AS B 
            INNER JOIN Facilities AS F ON B.facid = F.facid 
            INNER JOIN Members AS M ON B.memid = M.memid
       GROUP BY facid, name
   
    ) AS GPD

    LEFT JOIN

    (
       SELECT F.facid, F.name, 
              SUM(CASE WHEN B.memid = 0 THEN F.guestcost * B.slots
                       ELSE F.membercost * B.slots
                       END
                 ) AS Revenue
       FROM Facilities AS F 
            INNER JOIN Bookings AS B ON F.facid = B.facid 
       GROUP BY F.facid, F.name

    ) AS FAC

    ON GPD.facid = FAC.facid 

WHERE Revenue < 1000
ORDER BY Revenue DESC



/*results -
"Facid" "Name"  "Revenue"
"8" "Pool Table"  "270.0"
"7" "Snooker Table" "240.0"
"3" "Table Tennis"  "180.0"
*/

