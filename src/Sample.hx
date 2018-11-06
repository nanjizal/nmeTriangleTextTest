import nme.display.Sprite;
import nme.events.Event;
import nme.geom.Rectangle;
import nme.display.BitmapData;
import nme.display.Graphics;
import nme.display.TriangleCulling;
import nme.Lib;
import trilateralXtra.fDrawing.PolyPainter;
import trilateralXtra.fDrawing.ImageDrawing;
// Derived from NME sample 09
class Sample extends Sprite {
   var t0: Float;
   var s0: Sprite;
   public function new(){
      super();
      addChild(s0 = new Sprite());
      onLoaded( nme.Assets.getBitmapData( "font1AlphaWhite.png" ) );
   }
   function onLoaded( inData: BitmapData ){
      var me = this;
      t0 = haxe.Timer.stamp();
      stage.addEventListener( Event.ENTER_FRAME, function(_) { me.doUpdate( inData ); } );
   }
   function doUpdate( inData: BitmapData ){
      var imgDrawing = new ImageDrawing();
      imgDrawing.startFrame( s0 );
      var str = "The quick brown fox jumps over the lazy dog.";
      var scale = 2.;
      var gridX = 57.;
      var gridY = 60.;
      var y = 40.;
      var x = 40.;
      var currX = x;
      var w = 1000.*scale;
      var dx = 28*scale;
      var dy = gridY*2*scale;
      var colors = [ 0xFFFF0000, 0xFF00FF00, 0xFF0000FF, 0xFFFFFF00 ];
      var jumps = [ ];
      var lastSpace = 0;
      var spaceInt = 0;
      for( i in 0...str.length ){
          var charCode = str.charCodeAt( i );
          var no = charCode - 97 + 65;
          if( no == spaceInt ) lastSpace = i;
          currX += dx;
          if( currX > w ) {
              jumps.push( lastSpace );
              currX = (i-lastSpace)*dx;
          }
      }
      currX = x;
      y = 40;
      var jumpCount = 0;
      var sin: Float;
      var theta = (haxe.Timer.stamp()-t0);
      for( i in 0...str.length ){
          var charCode = str.charCodeAt( i );
          var no = charCode - 97 + 65;
          var j = i%colors.length;
          sin = 10*Math.sin( theta * i );
          imgDrawing.drawImageGridIndexColor( inData, no, currX, y + sin, gridX, gridY, scale, colors[ j ], 0.9 );
          currX += dx;
          if( jumps[ jumpCount ] <= i ) {
              y += dy;
              currX = x;
              jumpCount++;
          }
      }
      imgDrawing.end();
   }
}
