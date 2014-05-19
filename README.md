fairserver
==========

A Dayz Epoch server solution proving a dynamic mission system and fun, more interesting missions and a more equitable way of doing them. Not messing with the bandit/hero dynamic, just making the game a little less rage-inducing :)

I love open source. Get stuck in if you want to help. 

About
==========
This is a step-by-step development of a one-size-fits all solution for someone running a DayZ epoch server. It currently consists of
ZFM which is the Zambino FairMission System, and ZFSS which is the client-side files for ZFM. It was created as the 
next step in the mission systems, and to provide some variability in content. 

AS OF 19/05/2014, THIS IS NOT A RELEASE QUALITY PROJECT. DO NOT DEPLOY TO YOUR SERVER UNLESS YOU HAVE UNDERSTANDING OF
SQF FUNCTIONS AND WANT TO TEST THESE.

At the moment, ZFM has the following features:
* Probability-based loot
* Fixed loot
* AI unit classes (Sniper, Rifleman, Heavy or Commander)
* Difficulties (DEADMEAT, EASY, MEDIUM, HARD and WAR_MACHINE) 
* Support for different types of mission (At the moment, in development, CRASH/WRECK is the only one possible)
* Randomised missions
  * Text for missions is randomised to prevent boredom factor.
  * Random Loot
  * Random Units
* Easily modified or updated
  * All content has been designed so that no additional files are required (i.e. Mission1, Mission2 or something similar)
    and so that missions can be generated dynamically.


The following features are planned: 
* Array-based missions
  * Any person with no knowledge of SQF can easily use the existing constants and classes to create missions. 

* Mission types
  * Currently only supports CRASH type missions, however, there are other missions planned in the near future:
    * AMBUSH - Sensor placed on random roads, ignores bambis or randomly hero/bandit and will ambush a player as they 
      move to a certain position
    * LONE SNIPER - Class already created -- A sniper will take up a position in a random town and wait for a certain
      type of person.
    * HOSTAGE - Random player will be protected by AI and survivors must band together to kill them.
    * DYNAMIC WRECK - AI will destroy a player driving somewhere and then defend the wreckage. 
    * CQC - AI will spawn with CQC weapons in open building locations and the player must clear the house.
