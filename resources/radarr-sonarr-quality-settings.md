# Radarr & Sonarr Ultimate Quality Settings

This guide outlines a configuration optimized for the best balance between quality and file size while avoiding undesirable codecs and release tags.

## Must-Not-Include Tags:

Copy and paste the following string into Radarr and Sonarr's "Must not contain" field:

```
.CAM., .HD-TS., .HDCAM., .HQCAM., .TS., .R5., .R6., .SCR., .TELESYNC., .3D., .AC3D., .AC3LD., .AC3MD., .DTSD., .HQDTS., .HQHDTS., .ISO., danish, dksub, dubbed, dutch, dvd9, FGT, french, german, hebrew, hebsubs, italian, korean, korsub, multisubs, nl, RARBG, spanish, swedish, swesub, truefrench, vain, WebHD, WebRip, xvid, yify
```

## Quality Profiles (General Recommendations):

### For **Radarr (Movies)**:

1. **Ultra-HD**: `Remux-2160p`, `Bluray-2160p`
2. **HD**: `Remux-1080p`, `Bluray-1080p`, `Bluray-720p`
3. **SD**: Avoid, unless necessary for older films.

### For **Sonarr (TV Shows)**:

1. **Ultra-HD**: `Remux-2160p`, `Bluray-2160p`
2. **HD**: `Remux-1080p`, `Bluray-1080p`, `HDTV-1080p`, `Bluray-720p`, `HDTV-720p`
3. **SD**: Again, avoid unless necessary.

Ensure that the size limits for each quality level are set according to your storage capabilities and streaming bandwidth. If you have a high-speed network and abundant storage, you might opt for larger file sizes for better quality. If you're constrained on storage or have limited network bandwidth, you might aim for a more moderate file size without compromising too much on quality.

## Final Tips:

1. **H.265 (HEVC) Codec**: If your devices support H.265 playback and you want to save space without compromising quality, adjust the must-not-include tags to allow H.265 content.
2. **Foreign Audio Tracks**: If you watch content with foreign language parts and prefer to have them in the original language with English subtitles, ensure you select multi-audio releases or specify the requirement for the desired language track.
3. **Manual Review**: It's always beneficial to periodically review the content Radarr and Sonarr fetch. Automation is fantastic, but manual checks ensure you're continuously happy with your content quality.
