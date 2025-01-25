//
//
// Whatever
//
//

import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;

class WatchFaceView extends WatchUi.WatchFace {
  // Define number representations (example for '0' and '1')
  var numberPatterns as Array<Array> = [
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ],
      [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 0, 0, 0, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ],
      [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 1, 1, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ],
      [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ],
      [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ],
      [ 0, 0, 0, 0, 1 ], [ 1, 1, 1, 1, 1 ]
    ]
  ];

  // to draw dot rectangles
  var dotdiam = 12;
  var dotspace = 4;
  var size = dotdiam+dotspace;
  var numwidth = size*5;
  
  var gap = 8;
  var offset = 2;

  // move all up to allow text below
  var ydif = 25;

  // initial superclass, not the layout id
  function initialize() {
    WatchFace.initialize();
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {
    // background
    //dc.clear();
    var background = Application.loadResource(Rez.Drawables.backgroundImage);
    dc.drawBitmap(0, 0, background);
  }
  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  function drawNumber(dc as Graphics.Dc, number as Number, x as Number,
                      y as Number, size as Number) {
    var pattern = numberPatterns[number] as Array<Array>;
    for (var row = 0; row < pattern.size(); row++) {
      for (var col = 0; col < pattern[row].size(); col++) {
        if (pattern[row][col] == 1) {
          dc.fillRectangle(x + col * size, y + row * size, size, size);
        }
      }
    }
  }
  function drawTime(dc as Graphics.Dc, hour as Number, minute as Number) {
    // Adobe - font size 30, mousse script, export png x 1
    dc.setColor(0x8a8e1b, Graphics.COLOR_TRANSPARENT);

    // Draw hour (dc, number, x, y, size)
    // Tens place of hour
    drawNumber(dc, (hour / 10 % 10), (195-gap-numwidth-gap-numwidth), (195-50), size);
    // Ones place of hour
    drawNumber(dc, (hour % 10), 195-gap-numwidth, (195-50), size);

    // Draw minute
    // Tens place of minute
    drawNumber(dc, (minute / 10 % 10), 195+gap, (195-50), size);
    // Ones place of minute
    drawNumber(dc, (minute % 10), 195+gap+numwidth+gap, (195-50), size);
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Get date and time
    var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

    // clear screen to draw on
    //dc.clear();

    // draw time
    drawTime(dc, today.hour, today.min);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  // The user has just looked at their watch. Timers and animations may be
  // started here.
  function onExitSleep() as Void {}

  // Terminate any active timers and prepare for slow updates.
  function onEnterSleep() as Void {}
}
