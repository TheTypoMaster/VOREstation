#define INFINITY 1.#INF

mob/var/playerscale = 1
mob/var/basesize = 1

/mob/proc/resize(size_mod) //This is used by verbs
	var/matrix/resize = matrix() // Defines the matrix to change the player's size
	resize.Scale(size_mod*basesize) //Change the size of the sprite
	resize.Translate(0,-1*(1-size_mod)*basesize*16) //Move the player down or up in the tile so their feet align with the bottom
	animate(usr,transform = resize, time = 5) //Animate the player resizing
	playerscale = size_mod //Change playerscale so that other items can interact with them

/mob/proc/resize_by_item(size_mod) //This is used by items that change people's size
	var/matrix/resize = matrix() // Defines the matrix to change the player's size
	resize.Scale(size_mod*basesize)
	resize.Translate(0,-1*(1-size_mod)*basesize*16)
//	animate(usr,transform = resize, time = 5) //Animate the player resizing. Doesn't work for items, but why not?
	playerscale = size_mod
	update_icons() //Hacky fix to make up for the fact that there's no animation, this forces the sprite to update

/*mob/verb/Micro() //Define the verb
	set category = "Resize" //Put it in the tab "Resize"
	usr.resize(0.25) //Make them size 0.25

mob/verb/Small()
	set category = "Resize"
    usr.resize(0.5)

mob/verb/Big()
	set category = "Resize"
    usr.resize(1.5)

mob/verb/Huge()
	set category = "Resize"
    usr.resize(2)

mob/verb/Normal()
	set category = "Resize"
	usr.resize(1)

mob/verb/Lolwut() // Flips a sprite upside down because fuck you that's why.
	set category = "Resize"
	if(playerscale==-1)usr.resize(1)
	else
		usr.resize(-1)
*/

/* // Obsolete.
mob/verb/Smaller()
	set category = "Resize"
	switch(playerscale)
		if(2 to INFINITY)
			usr.resize(1.5)
		if(1.5 to 2)
			usr.resize(1)
		if(1 to 1.5)
			usr.resize(0.5)
		if(0.25 to 1)
			usr.resize(0.25)
		if(0.01 to 0.25)
			usr << "You can't get any smaller!"
		if(-1)
			usr.resize(0.25)
		else usr << "\red Something's broken! Ask a coder to sort you out."

mob/verb/Bigger()
	set category = "Resize"
	switch(playerscale)
		if(2 to INFINITY)
			usr << "You can't get any bigger."
		if(1.5 to 2)
			usr.resize(2)
		if(1 to 1.5)
			usr.resize(1.5)
		if(0.5 to 1)
			usr.resize(1)
		if(0.01 to 0.25)
			usr.resize(0.5)
		if(-1)
			usr.resize(0.25)
		else usr << "\red Something's broken! Ask a coder to sort you out."
*/

// Ace was here! Redid this a little so we'd use math for shrinking characters. This is the old code.
/mob/living/proc/set_size()
	set name = "Set character size"
	set category = "Resize"
	playersize = input("Size") in list("Macro","Big","Normal","Small","Tiny")
	if(playersize == "Macro")
		src.resize(2)
	if(playersize == "Big")
		src.resize(1.5)
	if(playersize == "Normal")
		src.resize(1)
	if(playersize == "Small")
		src.resize(0.5)
	if(playersize == "Tiny")
		src.resize(0.25)

/* When we add this to character customization, "short" will set you a little smaller basesize than normal, or "tall" for one that's a little larger than normal.
If a player choses "Small" "Tiny" "Big" or "Macro" and not "tall" or "short", they will be set as that size. Not change their basesize which will be 1.
If we change the basesize with other options it will cause bad results. "Tall" and "Short" will be purely within humanoid size ranges.
-Ace */

mob/verb/Readme()
	set name = "READ ME!!"
	set category = "Resize"
	usr << "\red DO NOT ABUSE THESE COMMANDS. At the start of the shift, you may set your size if you play a character of abnormal size. However, DON'T ABUSE IT after you leave the arrival shuttle or this feature will be removed. -Ace"