// BEGIN-INTERNAL

package org.robolectric.shadows;

import android.graphics.ColorSpace;

import org.robolectric.annotation.Implementation;
import org.robolectric.annotation.Implements;

@Implements(ColorSpace.Rgb.class)
public class ShadowRgbColorSpace {

  @Implementation
  protected long getNativeInstance() {
    return 1;
  }

}
// END-INTERNAL
