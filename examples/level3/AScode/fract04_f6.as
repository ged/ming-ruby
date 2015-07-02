MaxiY = 80;
MaxiX = 100;
Im = -1.25;

_root.onEnterFrame = function(){
	if (py<MaxiY) {
		Re = -2;
		for (var px = 0; px<MaxiX; px++) {
			if (px == 0){ py++; }
			Zr = Re;
			Zi = Im;
			n = 1;
			for (var mk = 0; mk<20; mk++){
				a = Zr*Zr;
				b = Zi*Zi;

				if((a+b)>4 ){ break; }

				Zi= Zr*Zi;
				Zr= a-b+Re;
				Zi = Zi+Zi+Im;
				n *= 10.000000001;

			}

			nn = (Math.sqrt(Math.sqrt(n)));
			
			couleur= nn << 16 | nn*2 << 8 | nn*8;
			_root.lineStyle(5,couleur);
			_root.moveTo((5*px)-1,(4*py)-1);
			_root.lineTo((5*px)+1,(4*py)+1);
			Re = Re+(2/MaxiY);
		}
		Im = Im+(3/MaxiX);
	}
};
