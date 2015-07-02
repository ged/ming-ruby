            var i = 0;
 	    banner = 'This is an example text. Welcome to Ming programming!';
	    _root.myclip.attachMovie('letter', 'myclip'+i, i);

            myIntervalFunction = function () {
            myclip.AStxt.text += banner.substr(i, 1);

	    if (i == banner.length) {
	      delete i;
	      clearInterval(myMovieClipInterval);
//	      AStxt._visible = false;
	      this.onEnterFrame = undefined;
            };
	    i++;
	    updateAfterEvent();
	
	    myformat = new TextFormat();
            myformat.color = 0x888000;
            myformat.font = 'Verdana';
            myformat.size = 20;
            _root.myclip.AStxt.setTextFormat(myformat);
	    };

	    myMovieClipInterval = setInterval(myIntervalFunction, 100);