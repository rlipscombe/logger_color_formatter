# logger_color_formatter

Simple log colouring for Erlang's logger.

## Dependency

```erlang
{deps, [
  {logger_color_formatter,
    {git, "https://github.com/rlipscombe/logger_color_formatter.git", {tag, "0.5.0"}}}
]}.
```

## Configuration

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

```erlang
%...
template => [...],
colors =>
    #{debug => "\e[0;38m",
      info => "\e[1;37m",
      notice => "\e[1;36m",
      warning => "\e[1;33m",
      error => "\e[1;31m",
      critical => "\e[1;35m",
      alert => "\e[1;44m",
      emergency => "\e[1;41m"
    }
%...
```
