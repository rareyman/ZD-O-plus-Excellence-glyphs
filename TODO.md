# TODO

Since the ZD-O+ Excellence identifies as a standard Xbox controller, Steam won't natively "see" the extra 6 buttons as unique inputs (L4/L5, etc.) because the standard X-input driver doesn't support them. Instead, those buttons are almost certainly mirroring existing Xbox inputs via the controller's onboard firmware or the ZD mobile app.

Here is the updated execution plan for your repo.

### 1. Updated Asset Strategy (Affinity Designer 2)

Since you're using Affinity, you should avoid using the raw SVG `<text>` elements and instead **Convert to Curves** (Cmd+Enter) before exporting. This ensures the labels (M1, LM, etc.) look exactly like the physical hardware font.

* **Home Icon:** The ZD-O+ home button is a simple double-ring circle.
* **ABXY:** Keep these monochrome (white/silver).
* **M1/M2/LM/RM:** Since they mirror standard buttons, we will map them to the "Pro Controller" classes Steam uses for visual overrides.

### 2. Task List

* [ ] **Run the Python Generator:** Use the script I provided to generate the base shapes.
* [ ] **Refine in Affinity Designer 2:**
* [ ] Import `a.svg`, `b.svg`, etc. Change stroke to `#E0E0E0` and convert text to curves.
* [ ] Import `home.svg`. Add a smaller concentric circle to match the ZD logo style.
* [ ] Import `controller.svg`. Modify the 8BitDo silhouette to be more angular. Add the **LM/RM** buttons (between LB/RB) and **LK/RK** (the small buttons adjacent to the triggers).


* [ ] **Map the "Mirror" Logic in CSS:**
Since Steam sees an Xbox controller, it doesn't have native `LM` or `LK` classes. To get them to appear in the UI, you have to target the "Rear Button" classes that Steam UI uses when a user enables "Extended Xbox Support."

```css
/* color.css mappings */

/* Rear Paddles */
.GamepadGlyph.L4 { background-image: url("assets/zdo/m1.svg"); }
.GamepadGlyph.R4 { background-image: url("assets/zdo/m2.svg"); }

/* Auxiliary Shoulders (Often mapped to L5/R5 in hybrid profiles) */
.GamepadGlyph.L5 { background-image: url("assets/zdo/lm.svg"); }
.GamepadGlyph.R5 { background-image: url("assets/zdo/rm.svg"); }

/* Special Case: Trigger-adjacent LK/RK */
/* These usually don't have separate glyphs in Steam. 
   Recommendation: Design a "Trigger+Button" glyph for L2/R2 
   to show the LK/RK interaction visually. */

```

### 3. Updated Python Script (Optimized for Affinity Import)

I've tweaked this to ensure the layers are named properly for when you open them in Affinity.

```python
import os

def generate_zdo_svg(name, content):
    path = "assets/zdo"
    os.makedirs(path, exist_ok=True)
    with open(f"{path}/{name}.svg", "w") as f:
        f.write(f'<svg width="40" height="40" viewBox="0 0 40 40" xmlns="http://www.w3.org/2000/svg">\n{content}\n</svg>')

# Generic Monochrome ABXY
for b in ["A", "B", "X", "Y"]:
    generate_zdo_svg(b.lower(), f'<circle cx="20" cy="20" r="18" fill="none" stroke="#E0E0E0" stroke-width="2"/><text x="20" y="21" text-anchor="middle" font-family="Arial" font-weight="bold" font-size="18" fill="#E0E0E0">{b}</text>')

# Auxiliary Buttons
aux = {
    "lm": "rect x='5' y='12' width='30' height='16' rx='8'",
    "lk": "rect x='12' y='5' width='16' height='30' rx='8'",
    "m1": "path d='M30 10 L15 15 C10 18 10 22 15 25 L30 30'"
}
# (Duplicate for RM, RK, M2 by mirroring)

for k, v in aux.items():
    label = k.upper()
    tag = f'<{v} fill="none" stroke="#E0E0E0" stroke-width="2"/>'
    text = f'<text x="20" y="21" text-anchor="middle" font-size="9" fill="#E0E0E0" font-family="Arial">{label}</text>'
    generate_zdo_svg(k, tag + text)

```

### 4. Controller Outline Tip

Since the ZD-O+ Excellence is modular, you might want to create a "Technical Drawing" style outline in Affinity. Use a **0.5pt stroke** for the internal modular seams (where the faceplate pops off) and a **1.5pt stroke** for the main silhouette. This fits the "Excellence" engineering theme perfectly.

Once you have the SVGs saved to your repo, do you need help setting up the `theme.json` to make these selectable as a "Generic Monochrome" option in CSS Loader?


***

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
