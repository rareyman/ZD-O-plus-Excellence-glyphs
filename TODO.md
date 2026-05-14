# TODO

To transition the fork for the ZD-O+ Excellence, follow this structured plan. This focuses on asset replacement and CSS targeting for the unique hardware layout.

### Phase 1: Asset Preparation (SVG)

The ZD-O+ Excellence aesthetic relies on a clean, monochrome look with specific geometric shapes.

1. **Home Icon:** Replace `assets/8bitdo/home.svg` with a minimalist house icon or the circular "ZD" logo. Ensure the viewBox is identical to the original to avoid scaling issues.
2. **Monochrome ABXY:** Convert existing colored glyphs to a "generic" style.
* Set `fill` to white or a light grey (`#E0E0E0`).
* Maintain the rounded-square profile characteristic of the Excellence face buttons.


3. **Auxiliary Buttons:** Create six new SVG files in `assets/zdo/`:
* `m1.svg` / `m2.svg`: Paddle-shaped silhouettes.
* `lm.svg` / `rm.svg`: Smaller rectangular "bumper-plus" shapes.
* `lk.svg` / `rk.svg`: Pill-shaped icons (for the buttons adjacent to the triggers).


4. **Controller Outline:** Modify `assets/8bitdo/controller.svg`. The ZD-O+ body is more angular than the 8BitDo 2C; update the silhouette to reflect the steeper grip angle and the extra shoulder buttons.

### Phase 2: CSS Logic Updates

Update `color.css` to handle the specific mapping of the ZD-O+ Excellence when it identifies as a standard controller.

1. **Remove Color References:** Update the ABXY selectors to remove any color-specific backgrounds or filters inherited from the 8BitDo 2C theme.
2. **Map Rear Paddles:**
* Assign `m1.svg` to `.GamepadGlyph.L4`.
* Assign `m2.svg` to `.GamepadGlyph.R4`.


3. **Map Auxiliary Bumpers:**
* Assign `lm.svg` and `rm.svg` to `.GamepadGlyph.L5` and `.GamepadGlyph.R5`. Note: Steam Input often treats these as the 5th set of grip buttons by default.


4. **Address Trigger-Adjacent Buttons:**
* Since Steam does not have a standard `L6/R6` class, these are often mapped via firmware to existing buttons. If they have unique HID classes, target them; otherwise, create a "Combo" glyph icon that combines the trigger and the LK/RK button for the UI.



### Phase 3: Manifest & Structure

1. **Update `theme.json`:**
* Change the `name` to "ZD-O+ Excellence Glyphs".
* Update `author` to your handle.
* Adjust the `preview` image to show the monochrome buttons and the new controller outline.


2. **Clean Up:** Delete the original `8bitdo` asset folder once paths are migrated to your new `zdo` folder to reduce the package size.

### Phase 4: Validation

1. **Steam Deck Testing:** Copy the folder to `~/home/deck/homebrew/themes/` and reload CSS Loader.
2. **Controller Settings Check:** Navigate to *Settings > Controller > Test Device Inputs*. Verify that the glyphs appearing on the screen match the physical ZD-O+ layout.
3. **UI Scale:** Test in both the "Compact" and "Standard" Steam UI views to ensure the new SVGs don't clip.

### Task Summary

* [ ] Export monochrome ABXY SVGs.
* [ ] Design and export M1, M2, LM, RM, LK, RK SVGs.
* [ ] Refine `controller.svg` outline to match ZD-O+ chassis.
* [ ] Map L4/R4 and L5/R5 in `color.css`.
* [ ] Update `theme.json` metadata and preview image.
