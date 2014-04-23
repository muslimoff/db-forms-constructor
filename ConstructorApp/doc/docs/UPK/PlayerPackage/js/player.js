/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

function play()
{
	if (screenshots.length > 0) 
	{
		index = 0;
		img = document.createElement("img");
		img.src = screenshots[index];
		document.body.appendChild(img);
		timer = setInterval(step, 1000);
	}
}

function step()
{
	index++;
	if (index >= screenshots.length) 
	{
		index = 0;
		clearInterval(timer);
	}
	img.src = screenshots[index];
}
