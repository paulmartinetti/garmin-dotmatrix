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
  private var numberPatterns as Array<Array> = [
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
  private var offset = 2;

  // move all up to allow text below
  private var ydif = 25;

  // initial superclass, not the layout id
  function initialize() { WatchFace.initialize(); }

  // Load your resources here
  function onLayout(dc as Dc) as Void {}
  // setLayout($.Rez.Layouts.WatchFace(dc));

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
    dc.setColor(0x8a8e1b, Graphics.COLOR_BLACK);

    // Draw hour (dc, number, x, y, size)
    // Tens place of hour
    drawNumber(dc, (hour / 10 % 10), p1, p1 - ydif, size);
    // Ones place of hour
    drawNumber(dc, (hour % 10), p2, p1 - ydif, size);

    // Draw minute
    // Tens place of minute
    drawNumber(dc, (minute / 10 % 10), p1, p2 - ydif, size);
    // Ones place of minute
    drawNumber(dc, (minute % 10), p2, p2 - ydif, size);
  }

  // Update the view
  function onUpdate(dc as Dc) as Void {
    // Get date and time
    var today = Gregorian.info(Time.now(), Time.FORMAT_SHORT);

    // clear screen to draw on
    dc.clear();

    
    // load jour as png based on day
    //var image = Application.loadResource($.Rez.Drawables.N24) as BitmapResource;
    //System.println(image.getWidth());
    var image = Application.loadResource(jourA[today.day]) as BitmapResource;
    // set jour x based on its width
    var ix = 195 - (image.getWidth() / 2);
    // draw jour
    dc.drawBitmap(ix, 285, image);
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
