# Police Abuse Database (PADB) (beatings.org is available)
_An open-source project to collect statistics on law-enforcement overreach_

## Methodology
The PADB is a collection of **publicly-reported** incidents in the United States where law-enforcement
personnel committed some type of abuse in their official capacity. Some examples
of the types of abuse collected include:

 * Physical beating of a restrained suspect
 * Harassing someone for recording the police
 * Using a SWAT team to serve a simple search warrant
 * Shooting a restrained dog

There are also specific things which this database does not attempt to collect.
Specifically, since this is a database of law-enforcement abuse, it will not collect
incidents where the officer's actions were likely justified by the circumstances or
where the abuse was committed by someone other than a law-enforcement officer.

 * Unfair prosecution
 * Inhumane treatment of prisoners (officer abuse while in holding would be included)
 * Biased judges
 * Officer shooting at an armed suspect
 * Officer conducting a search to which the suspect consented
 * Beating a suspect that is **actually** resisting
 * Personal stories that are not publicly documented
 * Police in Germany beat up a homeless man (Not in the U.S.)
 * Officer beats his wife while off-duty (Not in official capacity)

## Consistency Guidelines
No model is perfect and while the data definition below will nicely describe the
most important details, it will not be a perfect fit for some (or even most) incidents
of police abuse. However, some amount of error is allowable as long as the error is
consistent and predictable. Here are some guidelines to ensure that incidents are
modelled as consistently as possible.

### The Crap Rolls Downhill Rule

 * When **multiple agencies** are involved and it is not clear which agencies
officers committed the abuse, then the incident is modelled using the  most
localized department. If the Sheriff's department and the city police respond
to a call and abuse occurs the incident is modelled as an incident from the city
police department. However, if it is reported that a Sheriff's   deputy beat a
handcuffed suspect then the incident is modelled as an incident from the
Sheriff's department.

 * When **multiple agencies** are involved and officers from both agencies committ
abuse, then the incident is  modelled as an incident from the most localized
department. If the DEA and the Sheriff's department drive a tank  through
someone's living room looking for a dime bag of weed then the incident is
recorded   as a Sheriff's department incident.

### Fruit of the Poisoned Tree Rule
 * When an officer commits an unnecessary abuse, anything that results from that
 abuse is also unnecessary. E.g., if an officer enters a home without permission
 and without a warrant he has committed a search abuse. If the home owner then
 tries to remove the officer and is beaten up the beating is also an abuse because
 the officer should not have been there in the first place.

### Overuse of SWAT teams

 * The use of SWAT teams to serve search warrants, especially for minor drug offenses,
will be considered intimidation (show-of-force) because there was an unnecessary
show of force involved in the action. If during the SWAT raid the door is broken
then force (destruction-of-property) applies also.

### Use of Police Property is Police action
 * If an off-duty officer makes use of resources that are only available to a police
 officer then it is an act of police misconduct. For example, if an officer uses a
 police database to the address of a guy that is sleeping with his wife, and then
 beats up the guy, the officer has committed an abuse. If an off-duty officer uses
 his service weapon or badge in the commission of abuse, then it is officer abuse
 and not private citizen action.
 * An off-duty officer is arrested for soliciting a prostitute, however, and does
 not appear to be using his position or police property to secure dates or get
 out of the charges then it is a private matter. While the officer may be fired
 or demoted, it isn't really an instance of a police officer abusing his or her
 position as an officer.

### Irritation is not abuse
http://photographyisnotacrime.com/2014/09/10/washington-d-c-cop-bullies-videographer-recording-arrest-despite-official-departmental-policy/
This officer might be wrong about the legality of video, but he does not at any
point become verbally abusive, put hands on the cameraman, or arrest him.

### Jury Decisions, Awards, Indictments, and Settlements
If a jury awards money to a victim then some number of people (juries aren't
always 12 people) looked at the facts of the case and decided that the police
did **SOMETHING** wrong. If the city settles the case out of court for some
amount of money then something probably went wrong somewhere. The city might
be settling because they want to avoid the risk of an unfair payout from the
jury, but there must be something to make the city attorney feel like that
chance exists. If a prosecutor takes the rare step of bringing charges against
an officer then it is likely that the officer did something wrong and it should be
recorded.

### Sexual assault creates injuries
If an officer commits sexual assault or rape that should be recorded as a sexual
abuse in the abuse section. There should also be an injury listed in the physical
outcomes section even if the sex was consensual (statuatory rape or coerced) and
the victim was not beat up.

### Low Quality Incidents are out
If an incident report has few details, lacks dates or location or is based on
a lot of information that can't be independently verified then it is low-quality
and should not be entered. An accusation that officers beat up somebody with no
evidence to back it up is low quality. Video evidence adds quite a bit of quality as
do reports from news organizations and impartial witnesses.

### Accidents will happen
If an officer makes a proper decision to use force and in the process another person is
accidentally injured that is not going to be considered abuse. It's just a tragic
accident. http://www.rawstory.com/rs/2014/10/nyc-cops-accidentally-shoot-and-kill-man-they-were-trying-to-save-from-knife-attack/#.VC1W9_i_Oj8.reddit
In that incident, the police ordered a man to stop stabbing another man. When the man continued to
stab, the police shot him. However, one bullet entered the victim too. Sames goes
for raiding the wrong house with a search warrant. However, if the officers discover they are in
the wrong house and continue their search, they have now committed an abuse. And
if the officer thinks he's in the right house, and then uses excessive force it's also
an abuse.

## Data Definition
The PADB defines five broad types of abuse and has several
subcategories for each of them. The database also tries to collect victim
demographic information, information about the department and officers involved
in the abuse and what outcomes came from the incident.

### Abuse
Defined as the **unnecessary** use of any of the following. Each of the categories
is multi-select which means that every category which applies will be selected.

* **force**: firearm, taser, chemical, impact-weapon, unarmed, destruction-of-property, dog, false-arrest
* **search**: vehicle, cavity, person, strip, home
* **misconduct**: testilying, bribe, falsifying-evidence, misuse-data, theft, civil-forfeit
* **intimidation**: show-of-force, threats, verbal-abuse, harass-stalk
* **sexual**: harassment, abuse-minor, abuse-adult
* **restrained**: boolean
* **notes**: free-text

### Tracking
* **incident_id**
* **incident_summary**
* **incident_year**
* **incident_month**
* **incident_day**
* **reported_year**
* **reported_month**
* **reported_day**
* **notes**: free-text

### Location
* **state**
* **city**
* **zip**
* **county**
* **context**: Traffic Stop, 911, Search Warrant, Protest, Border-crossing, Checkpoint, Unknown
* **notes**: free-text

### Reference (separate table) (has many)
* **url**
* **date_accessed**
* **headline**
* **org_name**

### Victim
* **count**
* **race**: white, black, latino, asian, native american, other, unknown
* **age**: 0-5, 6-2, 13-18, 18-24, 25-34, 45-44, 45-54, 55-64, 65+, Unknown
* **gender**: male, female, transgendered, unknown
* **animal**: boolean
* **notes**: free-text

### Officer
* **service-years**:0-4, 5-9, 10-14, 15-19, 20+, Unknown
* **gender**: male, female, transgendered, unknown
* **race**: white, black, latino, asian, native american, other, unknown
* **multiple-incidents**: boolean

### Department
* **name**
* **city**
* **county**
* **state**
* **level**: Federal, State, County, City, Unknown
* **notes**: free-text

### Outcomes
* **internal-investigation**: No, Cleared of Wrongdoing, Sanctioned, Unknown
* **HR**: paid suspension, unpaid suspension, demoted, fired, Unknown
* **legal**: external-investigation, fines, settlement, criminal-charges, Unknown
* **physical**: injured, killed, Unknown
* **department-statement**: Acted appropriately, acted inappropriately, Unknown
* **union-statement**: Acted appropriately, acted inappropriately, Unknown
* **total-fines-settlement**: US dollars
* **notes**

# Other notes
elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml
