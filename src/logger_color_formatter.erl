-module(logger_color_formatter).
-include("colors.hrl").

-export([config_check/1, format/2]).

-define(DEFAULT_FORMATTER, logger_formatter).

config_check(Config) ->
    ?DEFAULT_FORMATTER:check_config(update_config(os:getenv("NO_COLOR"), Config, debug)).

format(LogEvent = #{level := Level}, Config) ->
    Config2 = update_config(os:getenv("NO_COLOR"), Config, Level),
    ?DEFAULT_FORMATTER:format(LogEvent, Config2).

update_config(
    _NoColor = false,
    Config = #{template := Template, colors := Colors},
    Level
) ->
    Config#{template => update_template(Template, maps:merge(default_colors(), Colors), Level)};
update_config(_NoColor = false, Config = #{template := Template}, Level) ->
    Config#{template => update_template(Template, default_colors(), Level)};
update_config(_NoColor, Config, _Level) ->
    Config.

update_template(Template, Colors, Level) ->
    lists:map(
        fun
            (color) ->
                maps:get(Level, Colors);
            (reset) ->
                maps:get(reset, Colors);
            (Item) ->
                Item
        end,
        Template
    ).

default_colors() ->
    #{
        debug => ?NORMAL_CYAN,
        info => ?BOLD_WHITE,
        notice => ?BOLD_CYAN,
        warning => ?BOLD_YELLOW,
        error => ?BOLD_RED,
        critical => ?BOLD_MAGENTA,
        alert => ?BOLD_BLUE,
        emergency => ?BOLD_RED,
        % Not a colour, but this'll do.
        reset => ?RESET
    }.
