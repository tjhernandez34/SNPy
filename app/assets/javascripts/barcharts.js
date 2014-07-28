$(document).ready(function(){

  var n = 4; // number of layers
  var m = 58; // number of samples per layer
  var stack = d3.layout.stack();
  var layers = stack(d3.range(n).map(function() { return bumpLayer(m, .1); }));
  var yGroupMax = d3.max(layers, function(layer) { return d3.max(layer, function(d) { return d.y; }) });
  var yStackMax = d3.max(layers, function(layer) { return d3.max(layer, function(d) { return d.y0 }) });

});
