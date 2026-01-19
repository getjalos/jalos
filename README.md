# jalos

A custom Linux distribution based on Debian Trixie with XFCE.

## Prerequisites

- Podman (or Docker)
- ~10GB free disk space for builds

## Quick Start

```bash
# Build the container
podman build -t jalos-builder .

# Enter the build environment
./build.sh

# Inside the container:
lb config
lb build
```

The ISO will appear in `live/jalos-amd64.hybrid.iso`.

## Structure

```
jalos/
├── Dockerfile              # Build environment
├── build.sh               # Container helper script
├── README.md
└── live/
    ├── auto/config        # lb config options
    └── config/
        ├── package-lists/ # What to install
        ├── bootloaders/   # GRUB customization
        ├── hooks/         # Build-time scripts
        └── includes.chroot/  # Files to include
            ├── etc/
            │   ├── os-release
            │   ├── lightdm/
            │   └── skel/      # User defaults
            └── usr/share/
                ├── backgrounds/jalos/
                └── plymouth/themes/jalos/
```

## Customization

### Adding packages
Edit files in `live/config/package-lists/`. One package per line.

### Wallpaper
Add your image as `live/config/includes.chroot/usr/share/backgrounds/jalos/default.png`

### Plymouth boot splash
Replace the script in `plymouth/themes/jalos/` or add images.

## Clean builds

```bash
./build.sh lb clean          # Quick clean
./build.sh lb clean --purge  # Full clean (re-downloads packages)
```

## Testing

```bash
# Test with QEMU
qemu-system-x86_64 -enable-kvm -m 2048 -cdrom live/jalos-amd64.hybrid.iso
```