{smcl}
{* 2:12 PM 5/10/2017}{...}
{viewerdialog collapse "dialog collapse"}{...}
{vieweralsosee "[D] collapse" "mansection D collapse"}{...}
{viewerjumpto "Syntax" "icollapse##syntax"}{...}
{viewerjumpto "Examples" "icollapse##examples"}{...}

{title: icollapse}

{p2colset 5 21 23 2}{...}
{p2col :icollapse {hline 2}} Collapse with the "by" option that includes the whole population{p_end}
{p2colreset}{...}


{marker syntax}{...}
{title:Syntax}


{p 8 15}
{cmd:icollapse} 
{it:clist} 
{cmd:[if] [in] [weight],} 
[{cmd:BY}{cmd:(}varlist{cmd:)} 
{cmd:BYInclusive}{cmd:(}varlist{cmd:)} 
{cmd:CW} 
{cmd:fast} 
]{p_end}

{marker description}{...}
{title:Description}

{pstd}
{cmd:icollapse} is almost exactly as in collapse, but the "by" variables can be divided in	{it: by()} and {it:byinclusive()}.

{pstd}
Variables in {it:by()} will divide the collapse by exclusive	groups, while the {it:byi()} will divide by exclusive groups but will also collapse	for all the population.

{pstd}

For example, if the option provided is {by(area) byi(sex)}, and the variables have two values (rural/urban and male/female), the final collapse will be divided by 9 groups, defined by the following duples: 
1)male-rural, 2)male-urban, 3)female-rural, 4)female-urban, 5)both sexes-urban, 6)both sexes-rural, 7)male-both areas, 8)female-both areas, 9)both sexes-both areas.

However, if you specify {it:by(area) byi(sex)} you'd get: 1)female-urban, 2) female-rural
3)male-rural 4)male-rural, 5)both sexes-urban, 6)both sexes-rural. That is, there's no collapse by both areas.

Using {it:by(area sex)}, which is the same as collapse, will lead to four groups, namely 1)male-rural, 2)male-urban,3)female-rural, 4)female-urban. 

{title:Options}

{p 4 4 2}Same as collapse {p_end}

byinclusive can be used along with by. 

{title:Note}

{p 4 4 2} The overall category is defined by a null (or a "" in string variables) and hence it can be confused with a variable that has a null. For this the aux_collapse variable shows the by options. {p_end}




{title:Examples}

{p 4 4 2} The following will create a collapse with the mean of price, for all groups in foreign and rep78.{p_end}

{p 4 8}{inp:. sysuse auto.dta} {p_end}
{p 4 8}{inp:. icollapse price, byi(foreign rep78)} {p_end}
{p 4 8}{inp:. list} {p_end}



{title:Author}

{p 5}Jorge Soler Lopez{p_end}
{p 5}jsolerlopez [at] worldbank.org{p_end}
{p 5}jorgeandres  [at] gmx.net{p_end}


