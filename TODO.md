# TODO

Since the ZD-O+ Excellence identifies as a standard Xbox controller, keeping the logic simple is the right call. Mapping at the firmware level is much more reliable than fighting Steam's X-input driver for extra HID buttons it doesn't recognize.

Here is the revised plan focusing on the monochrome aesthetic and the "on-device mapping" workflow.

### 1. Asset Strategy: "The Excellence Look"

* **Monochrome ABXY:** Use the Python script or Affinity to strip all color. The "Excellence" branding is premium and industrial; white or silver glyphs on the Steam UI will look much more cohesive with the physical hardware.
* **Custom Home Icon:** Since the ZD-O+ home button is a simple, modern circle with a centered LED ring, replace the 8BitDo/Xbox logo with two concentric circles.
* **Controller Outline:** Stick to a clean Xbox Series silhouette.

### 2. The Outline Graphic "Reminder"

Adding a text note directly into the controller outline SVG is a clever way to provide "just-in-time" documentation. When the user opens the controller settings in Steam, they'll see the visual reminder.

**How to implement it in the SVG:**
In **Affinity Designer 2**, open your `controller.svg` and add a small, clean text block (converted to curves) near the bottom or side of the controller silhouette:

> *“Firmware Mapping Active: M1-M2 / LM-RM mapped on-device”*

### 3. Revised Task List

* [ ] **Generate Monochrome Glyphs:**
* [ ] Create/Export `a.svg`, `b.svg`, `x.svg`, `y.svg` in solid `#FFFFFF` or `#E0E0E0`.
* [ ] Create `home.svg` using the concentric circle design.


* [ ] **Update Controller Outline:**
* [ ] Source a standard Xbox Series silhouette.
* [ ] **Add the Note:** Place the reminder text regarding on-device mapping into the SVG.
* [ ] **Convert to Curves:** Ensure all text in the SVG is converted to paths so CSS Loader renders it correctly without font dependencies.


* [ ] **Streamline `color.css`:**
* [ ] Point all standard `.GamepadGlyph` classes to your new monochrome assets.
* [ ] Remove any 8BitDo-specific logic for extra buttons (C/Z) to keep the file lean.


* [ ] **Update `theme.json`:**
* [ ] Set the name to **"ZD-O+ Excellence (Monochrome)"**.
* [ ] Ensure the description mentions that extra buttons are managed via hardware/app mapping.



### 4. Simplified CSS Mapping

Since you're sticking to the generic Xbox profile, your `color.css` only needs the essentials:

```css
/* Action Buttons */
.GamepadGlyph.A { background-image: url("assets/zdo/a.svg") !important; }
.GamepadGlyph.B { background-image: url("assets/zdo/b.svg") !important; }
.GamepadGlyph.X { background-image: url("assets/zdo/x.svg") !important; }
.GamepadGlyph.Y { background-image: url("assets/zdo/y.svg") !important; }

/* System Buttons */
.GamepadGlyph.Home { background-image: url("assets/zdo/home.svg") !important; }

/* Main Controller Visual */
.ControllerConfigurator .ControllerImage {
    background-image: url("assets/zdo/controller_with_note.svg") !important;
}

```

This approach keeps the theme lightweight and avoids "feature creep" for buttons that the OS can't technically differentiate anyway. It maintains the professional "Design Technologist" aesthetic you’re going for.
