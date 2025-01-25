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
 private
  var _background as Drawable;

  // Define number representations (example for '0' and '1')
  var numberPatterns as Array<Array> = [
    [
      [ 0, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 1, 1 ],
      [ 1, 0, 1, 0, 1 ], [ 1, 1, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 0, 1, 1, 1, 0 ]
    ],
    [
      [ 0, 0, 0, 1, 0 ], [ 0, 0, 1, 1, 0 ], [ 0, 1, 0, 1, 0 ],
      [ 0, 0, 0, 1, 0 ], [ 0, 0, 0, 1, 0 ], [ 0, 0, 0, 1, 0 ], [ 0, 0, 0, 1, 0 ]
    ],
    [
      [ 0, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ],
      [ 0, 0, 0, 1, 0 ], [ 0, 0, 1, 0, 0 ], [ 0, 1, 0, 0, 0 ], [ 1, 1, 1, 1, 1 ]
    ],
    [
      [ 0, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ],
      [ 0, 0, 0, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 0, 1, 1, 1, 0 ]
    ],
    [
      [ 0, 0, 0, 1, 0 ], [ 0, 0, 1, 1, 0 ], [ 0, 1, 0, 1, 0 ],
      [ 1, 0, 0, 1, 0 ], [ 1, 1, 1, 1, 1 ], [ 0, 0, 0, 1, 0 ], [ 0, 0, 0, 1, 0 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 0 ], [ 1, 1, 1, 1, 0 ],
      [ 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 0, 1, 1, 1, 0 ]
    ],
    [
      [ 0, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 0 ],
      [ 1, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 0, 1, 1, 1, 0 ]
    ],
    [
      [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 0, 1 ], [ 0, 0, 0, 1, 0 ],
      [ 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0 ],[ 0, 0, 1, 0, 0 ],[ 0, 0, 1, 0, 0 ]
    ],
    [
      [ 0, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ],
      [ 0, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 0, 1, 1, 1, 0 ]
    ],
    [
      [ 0, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ],
      [ 0, 1, 1, 1, 1 ], [ 0, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 0, 1, 1, 1, 0 ]
    ]
  ];

  // to draw dot rectangles
  var dotdiam = 12;
  var dotspace = 4;
  var size = dotdiam + dotspace;
  var numwidth = size * 5;

  var gap = 5;
  var offset = 3;

  // move all up to allow text below
  var ydif = 25;

  // initial superclass, not the layout id
  function initialize() {
    WatchFace.initialize();
    _background = new WatchUi.Bitmap({:rezId=>$.Rez.Drawables.backgroundImage, :locX=>0, :locY=>0});
  }

  // Load your resources here
  function onLayout(dc as Dc) as Void {}
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
          dc.setColor(0x939598, Graphics.COLOR_TRANSPARENT);
          dc.fillRectangle((x + col * size) + 1, (y + row * size) + 1,
                           dotdiam - 2, dotdiam - 2);

          dc.setColor(0x58595b, Graphics.COLOR_TRANSPARENT);
          // upper left corner x, y, w, h
          // tall
          dc.fillRectangle((x + col * size) + offset, y + row * size,
                           dotdiam / 2, dotdiam);
          // wide
          dc.fillRectangle(x + col * size, (y + row * size) + offset, dotdiam,
                           dotdiam / 2);
        }
      }
    }
  }
  function drawTime(dc as Graphics.Dc, hour as Number, minute as Number) {
    // Adobe - font size 30, mousse script, export png x 1

    // Draw hour (dc, number, x, y, size)
    // Tens place of hour
    drawNumber(dc, (hour / 10 % 10), (195 - gap - numwidth - gap - numwidth),
               (195 - 50), size);
    // Ones place of hour
    drawNumber(dc, (hour % 10), 195 - gap - numwidth, (195 - 50), size);

    // Draw minute
    // Tens place of minute
    drawNumber(dc, (minute / 10 % 10), 195 + gap, (195 - 50), size);
    // Ones place of minute
    drawNumber(dc, (minute % 10), 195 + gap + numwidth + gap, (195 - 50), size);
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Get date and time
    var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

    // clear screen to draw on
    dc.clear();
    _background.draw(dc);

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
