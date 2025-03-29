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

## Download
Go to Releases Tab and download the latest compiled binary or build it yourself (using [GameMaker](https://store.steampowered.com/app/1670460/GameMaker/))
