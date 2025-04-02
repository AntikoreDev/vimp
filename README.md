> [!WARNING]
> This was an **April Fools** for 2025, this software is no meant to be used for real purposes, still works though. If you want to convert this into a real thing for some reason, feel free to do so! You can use the ship sprites from Colorfire Redux for that if you want, freely.

# Visually Impressive Music Player
**Visually Impressive Music Player _(VIMP)_** is an experimental music/audio player based on the [Colorfire Redux](https://www.youtube.com/watch?v=DisYiUAFFH4&list=PLpLYs_zE3vbCNgZChhB8-LmvLqdUIefU-) music videos. Supports `.ogg` files, as well as `.mp3` and `.wav` weirdly.

<img src="https://res.antikore.dev/img/vimp_ss.png" heigth="720"/>

## Features
- Save/Load playlists
- Shuffle/Loop tracks and lists
- Keyboard hotkeys
- Funny visuals

## libmp3toogg.dll
This is just a helper for an extension to convert files to ogg using ffmpeg.
This is the source code if you want to recompile it yourself. Made by [@cixfra](https://github.com/cixfra)
```c
int convert_to_ogg(const char *in, const char *out)
{
    char final_cmd[1024] = ".\\ffmpeg.exe -i ";
    strcat(final_cmd, "\"");
    strcat(final_cmd, in);
    strcat(final_cmd, "\"");

    strcat(final_cmd, " ");

    strcat(final_cmd, "\"");
    strcat(final_cmd, out);
    strcat(final_cmd, "\"");

    int result = system(final_cmd);
    return (result);
}
```

## Legal Advice
Both repo and compiled binary includes an ffmpeg compiled binary from gyan.dev, if you're concerned about third-party intellectual property... I would be concerned on what are your priorities. Are you Nintendo?

## Download
Go to Releases Tab and download the latest compiled binary or build it yourself (using [GameMaker](https://store.steampowered.com/app/1670460/GameMaker/))
