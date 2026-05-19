---
name: hyprland-patterns
description: Hyprland configuration best practices and patterns
metadata: 
  node_type: memory
  type: reference
  originSessionId: 54a771e7-253d-4f42-a216-4f877a6d13b7
---

## Hyprland Configuration Structure

### Recommended Layout (from Hyprland Wiki)
```
~/.config/hypr/
├── hyprland.conf          (main entry point, sources hypr.conf)
├── hypr.conf              (symlink to active theme)
└── ~/.config/themes/
    └── cyberpunk/
        ├── hypr.conf      (actual config file)
        ├── waybar.css     (bar styling)
        └── wallpaper.jpg
```

### Current Setup
- Main config: `~/.config/hypr/hyprland.conf` → sources `hypr.conf` (symlink to theme)
- Active theme: `~/.config/themes/cyberpunk/hypr.conf`
- Symlink: `~/.config/hypr/hypr.conf` → `/home/chase/.config/themes/cyberpunk/hypr.conf`

## Configuration Best Practices

### Theme Switching
When switching themes, update symlink:
```bash
ln -sf ~/.config/themes/THEME_NAME/hypr.conf ~/.config/hypr/hypr.conf
hyprctl reload
```

### Settings Organization
- **Monolithic approach**: Keep all config in one file (current setup)
- **Modular approach** (alternative): Split into `conf.d/` subdirectories (numbered by topic)

Current approach is cleaner for small configs.

### Common Edits
1. **Colors/borders**: In `decoration` and `general` blocks
2. **Gaps/spacing**: `general { gaps_in, gaps_out }`
3. **Rounding**: `decoration { rounding }`
4. **Animations**: `animations` block with bezier curves
5. **Keybindings**: `bind`, `bindel`, `bindm` directives
6. **Programs**: `general { $terminal, $fileManager, $menu }`

### Testing Changes
After editing `~/.config/themes/cyberpunk/hypr.conf`:
- `hyprctl reload` to reload (no restart needed)
- Check auto-sync hook: `cd ~/dotfiles && git status`

## Hardware-Specific Patterns
Common checks when installing on new hardware:
- Monitor detection: `hyprctl monitors`
- GPU type: `lspci | grep -i vga` (Nvidia vs AMD)
- Refresh rate: Configure in `monitor=` directives
- Touchpad availability: Conditional in `input` block

## Resources
- **Official Wiki**: https://wiki.hypr.land/Configuring/Example-configurations/
- **Popular Dotfiles**: 
  - [JaKooLit](https://github.com/JaKooLit/Hyprland-Dots) — feature-rich, well-maintained
  - [ML4W](https://mylinuxforwork.com/) — DE-like experience with GUI settings
