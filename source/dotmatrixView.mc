//
//
// Whatever
//
//

import Toybox.Graphics;
import Toybox.Lang;
// import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time;
import Toybox.Application;

    class WatchFaceView extends WatchUi.WatchFace {
  var _background as Drawable;
  var _dot as BitmapResource;

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
      [ 0, 1, 1, 1, 0 ], [ 1, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1 ],
      [ 0, 0, 1, 1, 0 ], [ 0, 0, 0, 0, 1 ], [ 1, 0, 0, 0, 1 ], [ 0, 1, 1, 1, 0 ]
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
      [ 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0 ]
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
  var dotdiam = 10;
  var dotspace = 1;
  var size = dotdiam + dotspace;
  var numwidth = size * 5;

  var gap = 6;
  // drawing two rectangles 12x6 at 90 degrees to make a plus sign, so use
  // offset to center in a square
  var offset = 3;

  // move all up to allow text below
  var ydif = 76;

  // initial superclass, not the layout id
  function initialize() {
    WatchFace.initialize();
    _background = new WatchUi.Bitmap({:rezId=>$.Rez.Drawables.backgroundImage, :locX=>0, :locY=>0});
    _dot = Application.loadResource($.Rez.Drawables.Dot);
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
          dc.drawBitmap(x + col * size, y + row * size, _dot);
        }
      }
    }
  }
  function drawTime(dc as Graphics.Dc, hour as Number, minute as Number) {
    // Adobe - font size 30, mousse script, export png x 1

    // Draw hour (dc, number, x, y, size)
    // Tens place of hour
    drawNumber(dc, (hour / 10 % 10),
               (195 - gap - numwidth - gap - numwidth - gap), (195 - ydif),
               size);
    // Ones place of hour
    drawNumber(dc, (hour % 10), 195 - gap - numwidth - gap, (195 - ydif), size);

    // Draw minute
    // Tens place of minute
    drawNumber(dc, (minute / 10 % 10), 195 + gap + gap, (195 - ydif), size);
    // Ones place of minute
    drawNumber(dc, (minute % 10), 195 + gap + numwidth + gap + 10, (195 - ydif),
               size);
  }

  function drawSeparaterDots(dc as Dc, yoffset as Number) {
    // draw two dots between hour and minutes
    dc.drawBitmap(195-gap, 195-yoffset, _dot);
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

    // draw date
    // Tens place of day
    drawNumber(dc, (today.day / 10 % 10), 195 - gap - numwidth, (195 + 40),
               size);
    // Ones place of day
    drawNumber(dc, (today.day % 10), 195 + gap, (195 + 40), size);

    // draw separater dots
    drawSeparaterDots(dc, 27);
    drawSeparaterDots(dc, 57);
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
