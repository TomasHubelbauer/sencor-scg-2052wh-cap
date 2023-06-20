outer_diameter = 90;
outer_radius = outer_diameter / 2;
inner_diameter = 82;
inner_radius = inner_diameter / 2;
height = 17;
slit_length = 25;
slit_depth = outer_radius - inner_radius - 2;
slit_height = 5;
flap_height = 2;

// Make cylinders super duper smooth
$fn = 100;

// Cut out the inner cylinder out of the outer one to make the cap lip ring
difference() {
  // The cylinder representing the outer wall of the cap
  cylinder(height, outer_radius, outer_radius);

  // Shift the cutout cylinder up to make the thin window at the top of the lid
  translate([0, 0, .4])

  // The cylinder representing the inner wall of the cap
  cylinder(height, inner_radius, inner_radius);

  // Cut out the slits on the opposite sides by intersecting the mid cylinder
  translate([0, 0, .4])
  intersection() {
    // The cylinder representing the mid wall of the cap at the slit depth
    cylinder(height, inner_radius + slit_depth, inner_radius + slit_depth);

    translate([-slit_length / 2, -outer_radius, height - slit_height])
    // A cube that cuts into the mid cylinder to make the opposite side slits
    cube([slit_length, outer_radius * 2, height]);
  }
}

// TODO:
// - Add ramps to the slids instead of straight walls to make putting the lid on
//   easier
// - Find a way to taper the whole geometry so that it gets narrower towards the
//   top and looks more robust
// - Smooth out the edge of the top of the lid so it is nicer to handler by hand
//   by rotate extruding a quarter circle and excluding it from the lid and then
//   adding it to the inner side of the lid to make the wall thickness constant
// - Add an epsilon to the flaps so that the Z fighting does not appear in the
//   preview render

translate([0, 0, height - flap_height])
intersection() {
  difference() {
    // The cylinder representing the outer wall of the cap
    cylinder(flap_height, outer_radius, outer_radius);

    // The cylinder representing the inner wall of the cap
    cylinder(flap_height, inner_radius, inner_radius);
  }

  group() {
    translate([0, -outer_radius, 0])
    cube([slit_length / 2, outer_radius, flap_height]);

    translate([-slit_length / 2, 0, 0])
    cube([slit_length / 2, outer_radius, flap_height]);
  }
}
