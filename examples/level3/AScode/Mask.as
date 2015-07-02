_root.createEmptyMovieClip('image0_mc', 1);
_root.image0_mc.createEmptyMovieClip('imageHolder_mc', 1);
image0_mc.imageHolder_mc.loadMovie('picture.jpg');

_root.createEmptyMovieClip('image1_mc', 2);
_root.image1_mc.createEmptyMovieClip('imageHolder_mc', 1);
image1_mc.imageHolder_mc.loadMovie('backyard1.jpg');

_root.createEmptyMovieClip('mask_mc', 3);
mask_mc.lineStyle(3, 0x000000, 0);
mask_mc.beginFill(0, 100);
mask_mc.drawRectangle(640, 480);
mask_mc.endFill();
mask_mc._x = -320;
mask_mc._y = 240;

image1_mc.setMask(mask_mc);

image0_mc.onRelease = function() {
  _root.mask_mc.onEnterFrame = function() {
    this._x += 12;
    if (this._x >= 320) {
      this._x =320;
      delete this.onEnterFrame;
     };
  };
};
