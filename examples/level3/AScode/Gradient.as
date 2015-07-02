rectWidth = 100;
rectHeight = 200;

_root.createEmptyMovieClip('shape_mc', 1);
shape_mc.lineStyle(3, 0, 100);
colors = [0x0000FF, 0x00FF00, 0xFF0000];
alphas = [100, 100, 100];
ratios = [0, 127.5, 255];
matrix = {matrixType: 'box', x: -rectWidth/2, y: -rectHeight/2, w: rectWidth, h: rectHeight, r: 0};
shape_mc.beginGradientFill('linear', colors, alphas, ratios, matrix);
shape_mc.drawRectangle(rectHeight, rectWidth, 20);
shape_mc.endFill();
shape_mc._x = 200;
shape_mc._y = 200;