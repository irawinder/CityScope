/**

This is a script written by Philippe Lhoste 

Usually more than needed, but you can adapt his logic for various demos

Drags demo: draw Drags than can be dragged with the mouse.
http://processing.org/

by Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr & http://PhiLho.deviantART.com
*/
/* File/Project history:
 2.00.000 -- 2012/11/13 (PL) -- Separate Drag and DragList, standard method names.
 1.01.000 -- 2010/01/29 (PL) -- Update to better code, added DragList.
 1.00.000 -- 2008/04/29 (PL) -- Creation.
*/
/* Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicense.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2008-2012 Philippe Lhoste / PhiLhoSoft
*/

final int Drag_NB = 10;
DragList Drags = new DragList(false);

void setup()
{
  size(400, 400);
  smooth();

  // Create random Drags
  for (int i = 0; i < Drag_NB; i++)
  {
    int size = int(random(15, 30));
    Drags.add(new Drag(size + random(width - 2 * size), size + random(height - 2 * size), size, size / 5, color(128, 0, 0), color(0, 200, 0), color(0, 0, 200), color(200, 150, 0)
    ));
  }
}

void draw()
{
  background(190, 200, 255);

  Drags.update();
}
