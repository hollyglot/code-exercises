from math import sqrt, fabs
from itertools import chain, groupby
from sys import argv

script, filename = argv
location_data = list(chain(*[(float(x) for x in line.rstrip().split(' ')) for line in open(filename)]))

def triangulatePosition(x0, y0, r0, x1, y1, r1):
    # Triangulation is calculated by the intercection of two circles.
    # Each location is the center of one circle.
    # dx and dy are the vertical and horizontal distances between
    # the circle centers.

    dx = x1 - x0;
    dy = y1 - y0;

    # Determine the straight-line distance between the centers.
    d = sqrt((dy*dy) + (dx*dx));

    # Check for solvability
    if (d > (r0 + r1)):
        # no solution. circles do not intersect.
        return "Location cannot be determined."

    # 'point 2' is the point where the line through the circle
    # intersection points crosses the line between the circle
    # centers.  
    # 

    # Determine the distance from point 0 to point 2.
    a = ((r0*r0) - (r1*r1) + (d*d)) / (2.0000 * d)

    # Determine the coordinates of point 2.
    x2 = x0 + (dx * a/d);
    y2 = y0 + (dy * a/d);

    # Determine the distance from point 2 to either of the
    # intersection points.
    h = sqrt((r0*r0) - (a*a));

    # Now determine the offsets of the intersection points from
    # point 2.

    rx = -dy * (h/d);
    ry = dx * (h/d);

    # Determine the absolute intersection points. */
    xi = x2 - rx;
    xi_prime = x2 + rx;
    yi = y2 - ry;
    yi_prime = y2 + ry;

    intersection1 = "%.1f %.1f " %(xi_prime, yi_prime)
    intersection2 = "%.1f %.1f " %(xi, yi)
    intersections = (i[0] for i in groupby([intersection1, intersection2]))
    return '\n'.join(intersections)

print triangulatePosition(*location_data)