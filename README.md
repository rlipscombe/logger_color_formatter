# logger_color_formatter

Simple log coloring for Erlang's logger.

## Dependency

```erlang
{deps, [
  {logger_color_formatter,
    {git, "https://github.com/rlipscombe/logger_color_formatter.git", {tag, "0.5.0"}}}
]}.
```

## Configuration

Add `color` and `reset` terms to the logger template. The color appropriate to the level will be applied between the
two.

This example colour everything after the timestamp to the end of the line.

```erlang
[
    {kernel, [
        {logger_level, debug},
        {logger, [
            {handler, default, logger_std_h, #{
                formatter =>
                    {logger_color_formatter, #{
                        template => [
                            time, " ",
                            color,
                            "[", level, "]",
                            {pid, [" ", pid, ""], ""},
                            {mfa, [" ", mfa, ":", line], ""},
                            ": ",
                            msg,
                            reset, "\n"
                        ]
                    }}
            }}
        ]}
    ]}
].
```

## Customisation

You can set the colors to be used by adding a `colors` term to the configuration. The default colors (also shown here)
are the same as Elixir's Logger.

```erlang
%...
template => [...],
colors =>
    #{
        debug => "\e[0;36m",
        info => "\e[0;37m",
        notice => "\e[0;37m",
        warning => "\e[0;33m",
        error => "\e[0;31m",
        critical => "\e[0;31m",
        alert => "\e[0;31m",
        emergency => "\e[0;31m",

        reset => "\e[0m"
    }
%...
```
