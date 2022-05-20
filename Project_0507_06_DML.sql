USE BUDT703_Project_0507_06


--Q1) What are the star rates of each restaurant on each platform?--

SELECT	r.resID, 
		t.resRating, 
		p.pltName
FROM [Insight.Restaurant] r, [Insight.Register] g, [Insight.ResRating] t , [Insight.Platform] p
WHERE r.resID = g.resID 
AND g.PltId = t.pltId 
AND r.resID = t.resID 
AND g.PltId = p.pltId


--Q2) What is the information of the top ten restaurants in each category on each platform?--

select *
from (
     select T.resID,
			T.resName,
            T.resStarRate,
			T.resCategories,
			T.resStreet,
			T.resCity,
			T.resState,
			T.resZip,
			T.resPhone,
			T.resWeb,
            row_number() over(partition by T.resCategories order by T.resStarRate desc) as rn
     from (select r.resID,avg(a.resRating) as resStarRate ,c.resCategories,r.resName,r.resCity,r.resPhone,r.resState,r.resStreet,r.resWeb,r.resZip
			from [Insight.Restaurant] r, [Insight.RestaurantCategory] c, [Insight.ResRating] a
			where r.resID=c.resID AND r.resID = a.resID
			group by r.resID,c.resCategories,r.resName,r.resCity,r.resPhone,r.resState,r.resStreet,r.resWeb,r.resZip

			) as T
     ) as T
where T.rn <= 10 


--Q3) Who are the top 10 customers that leave the most reviews and the	 What are the corresponding platforms of each review?--

select *
from (
     select T.cusID,
            T.cusName,
            T.reviewNumber,
			T.PltID,
            row_number() over(partition by T.PltID order by T.reviewNumber desc) as rn
     from dbo.[Insight.Customer] as T
     ) as T
where T.rn <= 10


--Q4) What are the reviews that come with the highest star rate and the lowest star rate, respectively, on each platform?--

select *
from (
     select *,
            row_number() over(partition by T.resID order by T.revLike desc) as rn
     from dbo.[Insight.Review] as T
     ) as T
where T.rn <= 5