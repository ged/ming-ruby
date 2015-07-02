_root.createEmptyMovieClip('output', ++depth);
_root.output.createTextField('output', ++depth,350,50,100,100);
myformat = new TextFormat();
myformat.color = 0x000000;
myformat.font = 'Arial';
myformat.size = 12;
with (_root.output.output){
multiline = true;
wordWrap = true;
border=true;
selectable=false;
text='Hello World';
setTextFormat(myformat);
}
_root.output.onEnterFrame=function(){_root.output.output.text=++aa;};
_root.output.onPress=function(){this.startDrag("");};
_root.output.onRelease=function(){stopDrag();};
_root.output.onReleaseOutside=function(){stopDrag();};
