#!/usr/bin/ruby
#
# 3Dcam.rb
# original script by Kirupa http://www.kirupa.com
# Ruby code by Pawel Karwowski pawel at baribal dot forall dot pl
# Revision 1.0 2006.05.07
#

require 'ming/ming'
include Ming

use_SWF_version(6)

set_scale(20.0)
m = SWFMovie.new
m.set_dimension(550,400)
m.set_rate(30)
m.set_background(0x00, 0x33, 0xcc)

m.add(SWFAction.new("
cubeData = [{colour:0xff9900, // Bottom
        Sides:[
        {x:-50, y:50, z:50}, // UL
        {x:-50, y:50, z:-50}, // OL
        {x:50, y:50, z:-50}, // OR
        {x:50, y:50, z:50} // UR
        ]},
{colour:0xff9900, // Top
        Sides:[
        {x:-50, y:-50, z:-50}, // UL
        {x:-50, y:-50, z:50}, // OL
        {x:50, y:-50, z:50}, // OR
        {x:50, y:-50, z:-50} // UR
        ]},
{colour:0xff8800, // Right
        Sides:[
        {x:50, y:-50, z:50}, // OR
        {x:50, y:50, z:50}, // UR
        {x:50, y:50, z:-50}, // UL
        {x:50, y:-50, z:-50} // OL
        ]},
{colour:0xff8800, // Left
        Sides:[
        {x:-50, y:-50, z:-50}, // OR
        {x:-50, y:50, z:-50}, // UR
        {x:-50, y:50, z:50}, // UL
        {x:-50, y:-50, z:50} // OL
        ]},
{colour:0xffaa00, // Front
        Sides:[
        {x:-50, y:50, z:-50}, // UL
        {x:-50, y:-50, z:-50}, // OL
        {x:50, y:-50, z:-50}, // OR
        {x:50, y:50, z:-50} // UR
        ]},
{colour:0xffaa00, // Back
        Sides:[
        {x:50, y:50, z:50}, // UL
        {x:50, y:-50, z:50}, // OL
        {x:-50, y:-50, z:50}, // OR
        {x:-50, y:50, z:50} // UR
        ]}
];
Objekt3d = function (data3d) {
        this.data3d = data3d;
        this.move3d = function(x, y, z) {
                var k = 0;
                while (k < this.data3d.length) {
                        var i = 0;
                        while (i < this.data3d[k].Sides.length) {
                                this.data3d[k].Sides[i].x =
this.data3d[k].Sides[i].x+x;
                                this.data3d[k].Sides[i].y =
this.data3d[k].Sides[i].y+y;
                                this.data3d[k].Sides[i].z =
this.data3d[k].Sides[i].z+z;
                                i++;
                        }
                        k++;
                }
        };
        this.scale3d = function(x, y, z) {
                var k = 0;
                while (k < this.data3d.length) {
                        var i = 0;
                        while (i < this.data3d[k].Sides.length) {
                                this.data3d[k].Sides[i].x =
this.data3d[k].Sides[i].x*x;
                                this.data3d[k].Sides[i].y =
this.data3d[k].Sides[i].y*y;
                                this.data3d[k].Sides[i].z =
this.data3d[k].Sides[i].z*z;
                                i++;
                        }
                        k++;
                }
        };
        this.rotate3d = function(xa, ya) {
                var rad = Math.PI/180;
                var px;
                var py;
                var pz;
                var sin_xa;
                var sin_ya;
                var cos_xa;
                var cos_ya;
                var tempz;
                var k = 0;
                while (k < this.data3d.length) {
                        var i = 0;
                        while (i <this.data3d[k].Sides.length) {
                                px = this.data3d[k].Sides[i].x;
                                py = this.data3d[k].Sides[i].y;
                                pz = this.data3d[k].Sides[i].z;
                                cos_ya = Math.cos(ya*rad);
                                sin_ya = Math.sin(ya*rad);
                                cos_xa = Math.cos(xa*rad);
                                sin_xa = Math.sin(xa*rad);
                                tempz = (pz*cos_ya)-(px*sin_ya);
                                this.data3d[k].Sides[i].x =
(pz*sin_ya)+(px*cos_ya);
                                this.data3d[k].Sides[i].y =
(py*cos_xa)-(tempz*sin_xa);
                                this.data3d[k].Sides[i].z =
(py*sin_xa)+(tempz*cos_xa);
                                i++;
                        }
                        k++;
                }
        };
};
Kamera3d = function (Objekt3d, distance, angle, loc) {
        this.Objekt3d = Objekt3d;
        this.distance = distance;
        this.angle = angle;
        this.loc = loc;
        this.mc = this.create();
};
Kamera3d.prototype.create = function() {
        return (this.loc.createEmptyMovieClip('camMC'+Stage.camNum,
Stage.camNum++));
};
Kamera3d.prototype.render = function() {
        this.mc.clear();
        var z;
        var pers;
        var sx;
        var sy;
        var tx;
        var ty;
        var polygon;
        var k = 0;
        while (k < this.Objekt3d.data3d.length) {
                polygon = [];
                var i = 0;
                while (i < this.Objekt3d.data3d[k].Sides.length) {
                        z =
this.Objekt3d.data3d[k].Sides[i].z+this.distance;
                        pers = this.angle/z;
                        sx = this.Objekt3d.data3d[k].Sides[i].x*pers;
                        sy = this.Objekt3d.data3d[k].Sides[i].y*pers;
                        polygon.push({sx:sx, sy:sy});
                        i++;
                }
                z =
((polygon[1].sx-polygon[0].sx)*(polygon[2].sy-polygon[0].sy))-((polygon[1].sy-polygon[0].sy)*(polygon[2].sx-polygon[0].sx));
                if (z>0) {
                        this.mc.beginFill(this.Objekt3d.data3d[k].colour,
this.Objekt3d.data3d[k].colour);
                        this.mc.moveTo(polygon[0].sx, polygon[0].sy);
                        this.mc.lineTo(polygon[1].sx, polygon[1].sy);
                        this.mc.lineTo(polygon[2].sx, polygon[2].sy);
                        this.mc.lineTo(polygon[3].sx, polygon[3].sy);
                        this.mc.lineTo(polygon[0].sx, polygon[0].sy);
                }
                k++;
        }
};
Cube3d = new Objekt3d(cubeData);
Szene3D = new Kamera3d(Cube3d, 200, 300, _root); //(Cube3d, 200, 400, _root);
Szene3D.render();
Szene3D.mc._x = 275; //275
Szene3D.mc._y = 200; //175
_root.onEnterFrame = function() {
	Cube3d.rotate3d((this._xmouse+100)/100, (this._ymouse+200)/100);
	Szene3D.render();
};
"))


m.save('3Dcam.swf')
