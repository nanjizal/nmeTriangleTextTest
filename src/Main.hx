package;
import kha.Framebuffer;
import kha.System;
import kha.Image;
import kha.Color;
import kha.Assets;
import kha.graphics2.Graphics;
import kha.graphics4.DepthStencilFormat;
import kha.input.Keyboard;
import kha.input.Mouse;
import kha.input.KeyCode;
import kha.math.FastMatrix3;
import trilateralXtra.kDrawing.PolyPainter;
import trilateralXtra.kDrawing.ImageDrawing;
class Main {
    public var t0: Float = 0.;
    public static 
    function main() {
        System.init( {  title: "Triangle Text Test"
                     ,  width: 1024, height: 768
                     ,  samplesPerPixel: 4 }
                     , function()
                     {
                        new Main();
                     } );
    }
    public function new(){ Assets.loadEverything( loadAll ); }
    public function loadAll(){
        trace( 'loadAll' );
        startRendering();
    }
    function startRendering(){
        System.notifyOnRender( function ( framebuffer ) { render( framebuffer ); } );
    }
    function render( framebuffer: Framebuffer ){
        var imgDrawing = new ImageDrawing();
        imgDrawing.startFrame( framebuffer );
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
            var no = charCode - 97 + 65 - 7;
            if( no < 0 ) no = 0;
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
        t0+=0.01;
        var theta = (haxe.Timer.stamp()-t0);
        for( i in 0...str.length ){
            var charCode = str.charCodeAt( i );
            var no = charCode - 97 + 65 - 7;
            if( no < 0 ) no = 0;
            trace( no );
            var j = i%colors.length;
            sin = 10*Math.sin( theta * i );
            imgDrawing.drawImageGridIndexColor( Assets.images.font1AlphaWhite, no, currX, y + sin, gridX, gridY, scale, colors[ j ], 0.9 );
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
