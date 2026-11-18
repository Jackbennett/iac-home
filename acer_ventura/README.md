# NixOS Config

Acer Swift SF314-43 config.

## Keyboard mapping
Replace pageUp/Down as left/right becuase split arrow keys are aweful.

Systemd remapping the keyboard works per-device, for anything dynamic/clever look into keyd.

### What
```
cp 99-keyboard.hwdb /etc/udev/hwdb.d/
systemd-hwdb update
udev trigger
```

#### How

src: https://www.reddit.com/r/linux_gaming/comments/nypsi1/updated_guide_to_remapping_keys_on_linux_using/

example:
```
evdev:name:THRUSTMASTER Tacticalboard:*
 KEYBOARD_KEY_70056=leftbrace
 KEYBOARD_KEY_70057=rightbrace
```

`cat /proc/bus/input/devices` to find a device and use evtools to see events from it.
The `MSC_SCAN` even value is the `KEYBOARD_KEY_<suffix>`.
Then add lowercase of the `KEY_<SCAN>` in the remapped `=<SCAN>` pattern.
